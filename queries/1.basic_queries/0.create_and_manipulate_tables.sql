CREATE TABLE job_applied (
  job_id INT,
  application_date DATE,
  custom_resume BOOLEAN,
  resume_name VARCHAR(255),
  cover_letter BOOLEAN,
  cover_letter_name VARCHAR(255),
  status VARCHAR(50)
);

INSERT INTO job_applied 
            (
              job_id,
              application_date,
              custom_resume,
              resume_name,
              cover_letter,
              cover_letter_name,
              status
            )
VALUES (1,
        '2024-03-01',
        true,
        'resume_01.pdf',
        true,
        'cover_letter_01.pdf',
        'submitted'),
        (2,
        '2024-03-03',
        true,
        'resume_01.pdf',
        false,
        'cover_letter_01.pdf',
        'submitted'),
        (3,
        '2024-03-06',
        false,
        'resume_01.pdf',
        true,
        'cover_letter_01.pdf',
        'submitted'),
        (4,
        '2024-03-13',
        true,
        'resume_01.pdf',
        true,
        'cover_letter_01.pdf',
        'submitted'),
        (5,
        '2024-03-15',
        false,
        'resume_01.pdf',
        true,
        'cover_letter_01.pdf',
        'submitted');

SELECT *
FROM job_applied

ALTER TABLE job_applied
ADD Contact VARCHAR(50)

UPDATE job_applied
SET contact = 'Erling'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Beamer'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Jack'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Kendozor'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Manor'
WHERE job_id = 5;

ALTER TABLE job_applied
RENAME COLUMN contact to contact_name

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE VARCHAR(100)