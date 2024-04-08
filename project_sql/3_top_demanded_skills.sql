
select 
skills
,COUNT(skills_job_dim.job_id)
FROM job_postings_fact 
INNER JOIN 
skills_job_dim 
ON job_postings_fact .job_id = skills_job_dim.job_id
INNER JOIN 
skills_dim 
ON skills_job_dim.skill_id = skills_dim.skill_id
where 
 job_title_short = 'Data Analyst'
--and job_work_from_home = TRUE
GROUP BY
skills
order by COUNT(skills_job_dim.job_id) desc
Limit 5
;

