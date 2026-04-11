
SELECT 
    job_title,
    job_id,
    company_id,
    salary_year_avg,
    job_via
    
FROM
(SELECT *
FROM january_job
UNION ALL
SELECT *
FROM february_job
UNION ALL
SELECT *
FROM march_job)
AS quarter1_job_postings
WHERE 
    quarter1_job_postings.salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg DESC