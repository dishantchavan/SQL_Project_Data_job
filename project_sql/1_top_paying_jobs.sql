/*
Question; What are the top-paying data analyst jobs?
-Identify the top 1o highest-paying data analyst roles

*/

select 
    j.job_id
    ,j.job_title
    ,j.job_location
    ,j.job_schedule_type
    ,j.salary_year_avg
    ,j.job_posted_date
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