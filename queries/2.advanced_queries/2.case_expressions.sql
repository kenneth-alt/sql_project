SELECT
  COUNT(job_id) AS data_eng_jobs,
  CASE
    WHEN job_location = 'Anywhere' THEN 'Remote, Anywhere'
    WHEN job_location LIKE '%Calgary%' THEN 'Calgary'
    ELSE 'Rest of the world'
  END AS location_group
FROM job_postings_fact
WHERE
  job_title_short = 'Data Engineer'
GROUP BY
  location_group


SELECT
  COUNT(job_id) AS no_of_jobs,
  CASE
    WHEN salary_year_avg > 100000 THEN 'High'
    WHEN salary_year_avg > 75000 THEN 'Medium'
    ELSE 'Low'
  END AS salary_range
FROM
  job_postings_fact
GROUP BY
  salary_range

