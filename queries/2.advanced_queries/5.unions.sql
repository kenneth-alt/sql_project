-- Unions are used for row-wise combinations
SELECT 
  quarter1_job_postings.job_title_short,
  quarter1_job_postings.salary_year_avg,
  quarter1_job_postings.job_location,
  quarter1_job_postings.job_via,
  quarter1_job_postings.job_posted_date::DATE
FROM (
  SELECT *
  FROM january_jobs
  UNION ALL
  SELECT *
  FROM february_jobs
  UNION ALL
  SELECT *
  FROM march_jobs
) AS quarter1_job_postings
WHERE
   quarter1_job_postings.salary_year_avg > 100000
   AND  quarter1_job_postings.job_title_short = 'Data Engineer'
ORDER BY
  quarter1_job_postings.salary_year_avg DESC


-- -- --
SELECT
  job_postings_fact.job_title_short,
  skills_dim.skills,
  skills_dim.type,
  job_postings_fact.salary_year_avg
FROM  
  job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE EXTRACT(MONTH FROM job_posted_date) BETWEEN 1 AND 3 
      AND job_postings_fact.salary_year_avg > 100000
