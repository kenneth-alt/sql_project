-- Left Join
SELECT
  job_postings.job_title_short,
  job_postings.job_location,
  companies.name
FROM job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies
  ON job_postings.company_id = companies.company_id
LIMIT 100;


-- Inner Join
SELECT
  job_postings.job_title,
  skills_to_job.skill_id,
  skills.skills
FROM 
  job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
LIMIT 1000;

-- More Examples
SELECT
  job.job_title,
  companies.name
FROM job_postings_fact AS job
LEFT JOIN company_dim AS companies ON job.company_id = companies.company_id
WHERE
  job_title LIKE '%Data_Scientist%'
LIMIT 1000

-- --
SELECT
  job.job_title,
  skills_to_job.skill_id,
  skills.skills
FROM job_postings_fact AS job
LEFT JOIN skills_job_dim AS skills_to_job ON job.job_id = skills_to_job.job_id
LEFT JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
  job_location LIKE '%Calgary%'
LIMIT 1000

-- -- --
SELECT
  skills.skills AS skill_name,
  COUNT(skills_to_job.job_id) AS number_of_postings,
  ROUND(AVG(job.salary_year_avg), 0) AS avg_salary_for_skill
FROM 
  job_postings_fact AS job
LEFT JOIN skills_job_dim AS skills_to_job ON job.job_id = skills_to_job.job_id
LEFT JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
GROUP BY
  skill_name
HAVING
  AVG(job.salary_year_avg) IS NOT NULL
ORDER BY
  avg_salary_for_skill DESC
LIMIT 1000