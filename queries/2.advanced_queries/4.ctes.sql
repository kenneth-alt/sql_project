-- Select jobs posted in January only with CTEs
WITH january_jobs AS (
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT * FROM january_jobs

-- Companies with the most job postings
WITH company_job_count AS (
  SELECT
    company_id,
    COUNT(*) AS total_jobs
  FROM
    job_postings_fact
  WHERE
    job_title_short = 'Data Engineer' AND job_country = 'Canada'
  GROUP BY
    company_id
)

SELECT 
  company_dim.name AS company_name, 
  COALESCE(company_job_count.total_jobs, 0) AS total_jobs
FROM
  company_dim
LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY
  total_jobs DESC


-- Number of remote job postings per skill
WITH remote_job_skills AS (
  SELECT
    skills_to_job.skill_id,
    COUNT(*) AS skills_count
  FROM
    skills_job_dim as skills_to_job
  INNER JOIN job_postings_fact AS job_postings ON skills_to_job.job_id = job_postings.job_id
  WHERE
    job_postings.job_work_from_home = True
    AND job_postings.job_title_short = 'Data Engineer'
  GROUP BY
    skills_to_job.skill_id
)

SELECT 
  remote_job_skills.skill_id,
  skills_dim.skills,
  remote_job_skills.skills_count
FROM remote_job_skills
INNER JOIN skills_dim ON remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY
  remote_job_skills.skills_count DESC
LIMIT 10