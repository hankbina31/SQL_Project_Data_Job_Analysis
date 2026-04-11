
WITH remote_job AS (
SELECT 
    job_postings_fact.job_id,
    job_postings_fact.job_work_from_home
FROM 
    job_postings_fact
WHERE job_work_from_home = True AND
job_title_short = 'Data Analyst'
)
SELECT 
    COUNT(remote_job.job_id) AS skill_needed_count,
    skills_dim.skills
FROM 
    remote_job
LEFT JOIN skills_job_dim ON remote_job.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
GROUP BY 
    skills
HAVING
    skills IS NOT NULL
ORDER BY 
    skill_needed_count DESC
LIMIT 5;

