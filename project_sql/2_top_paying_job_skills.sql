/*
Skills for the top paying jobs
*/

With top_paying_jobs AS
(
    select 
        j.job_id
        ,j.job_title
        ,j.salary_year_avg
        ,c.name as company_name
    FROM 
        job_postings_fact j
    left JOIN
        company_dim c
    ON 
        j.company_id = c.company_id
    where 
        j.job_title_short = 'Data Analyst'
        and j.job_location = 'Anywhere'
        and j.salary_year_avg is not null
    ORDER BY
        j.salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
;


