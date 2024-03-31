-- Top Paying Jobs
SELECT
  job_id,
  job_title,
  name AS company_name,
  job_location,
  job_schedule_type,
  salary_year_avg,
  job_posted_date
FROM 
  job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
  job_title_short = 'Data Engineer' AND
  job_location = 'Canada' AND
  salary_year_avg IS NOT NULL
ORDER BY
  salary_year_avg DESC
LIMIT 10

