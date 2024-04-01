SELECT 
  job_title_short, 
  ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
WHERE
  salary_year_avg IS NOT NULL 
  AND job_country = 'Canada'
GROUP BY 
  job_title_short
ORDER BY 
  avg_salary DESC

-- Distinct selection
SELECT DISTINCT
  job_location
FROM
  job_postings_fact
ORDER BY
  job_location 

-- Comparison and Logical operators
SELECT 
  job_title_short,
  job_location,
  job_schedule_type
FROM
  job_postings_fact
WHERE 
  job_schedule_type NOT LIKE '%Full-time%'
LIMIT 100

SELECT
  job_title_short,
  job_location,
  salary_year_avg
FROM
  job_postings_fact
WHERE 
  job_location IN ('Canada', 'Anywhere') AND
  (job_title_short = 'Data Engineer' AND salary_year_avg > 100000)
ORDER BY
  salary_year_avg DESC