-- Creating sub-tables the classic way
-- January
CREATE TABLE january_jobs AS 
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS 
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS 
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


-- Using sub-queries(query inside of a query) to select sub-tables without creating the tables permanently
SELECT *
FROM (
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs


-- Using sub-queries in WHERE clause
SELECT 
  company_id,
  name AS companies
FROM company_dim
WHERE company_id IN (
  SELECT company_id
  FROM job_postings_fact
  WHERE job_no_degree_mention = True
)
LIMIT 1000


-- Most popular skills mentions in job postings
SELECT 
  top_ten_skills.skill_id,
  skills_dim.skills,
  top_ten_skills.no_of_mentions
FROM (
  SELECT
    skill_id,
    COUNT(*) AS no_of_mentions
  FROM skills_job_dim
  GROUP BY
    skill_id
  ORDER BY
    no_of_mentions DESC
  LIMIT 10
) AS top_ten_skills
LEFT JOIN skills_dim ON top_ten_skills.skill_id = skills_dim.skill_id

-- Large, Medium and Small companies based on number of job postings

SELECT
  company_name,
  number_of_postings,
  CASE 
    WHEN number_of_postings > 100 THEN 'Large'
    WHEN number_of_postings BETWEEN 50 AND 99 THEN 'Medium'
    ELSE 'Small'
  END AS company_size
FROM (
  SELECT
    company_dim.name AS company_name,
    company_sizes.no_of_postings AS number_of_postings
  FROM (
    SELECT
      company_id,
      COUNT(company_id) AS no_of_postings
    FROM
      job_postings_fact
    GROUP BY
      company_id
  ) AS company_sizes
  LEFT JOIN company_dim ON company_sizes.company_id = company_dim.company_id
)
ORDER BY
  number_of_postings DESC
