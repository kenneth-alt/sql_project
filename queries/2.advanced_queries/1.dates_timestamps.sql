SELECT 
  job_title_short AS title,
  job_location AS location,
  job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
  EXTRACT(MONTH FROM job_posted_date) AS month
FROM 
  job_postings_fact
LIMIT 10 ;

SELECT 
  EXTRACT(MONTH FROM Job_posted_date) as month,
  COUNT(job_id) AS Job_count
FROM
  job_postings_fact
WHERE
  job_title_short = 'Data Engineer'
GROUP BY
  month
ORDER BY
  Job_count DESC

SELECT
  job_schedule_type,
  AVG(salary_year_avg) AS annual_average,
  AVG(salary_hour_avg) AS hourly_average
FROM
  job_postings_fact
WHERE
  job_posted_date > '2023-06-01' --AND
  --salary_year_avg IS NOT NULL AND
  --salary_hour_avg IS NOT NULL
GROUP BY
  job_schedule_type

SELECT 
  company_dim.name AS company_name,
  job_postings_fact.job_posted_date
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
  job_postings_fact.job_health_insurance = True 
  AND job_posted_date BETWEEN '2023-04-01' AND '2023-06-01'
LIMIT 1000