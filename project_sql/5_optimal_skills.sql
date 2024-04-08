/*

Identify Skills which are high in demand and associated with high average salaries
*/

With skills_demand as 
(
select 
    skills_dim.skills
    ,skills_dim.skill_id
    ,COUNT(skills_job_dim.job_id) as demand_count
FROM 
    job_postings_fact 
INNER JOIN 
    skills_job_dim 
ON 
    job_postings_fact .job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim 
ON 
    skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst'
    and salary_year_avg is not NULL
    and job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id

)
, average_salary as 
(
    select 
    skills_dim.skills
    ,skills_dim .skill_id
    ,ROUND(AVG(salary_year_avg)) as Avg_salary
    --,AVG(salary_hour_avg)
FROM 
    job_postings_fact 
INNER JOIN 
    skills_job_dim 
ON 
    job_postings_fact .job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim 
ON skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst'
and salary_year_avg is not NULL
and job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
)
select 
    skills_demand.skill_id
    ,skills_demand.skills
    ,skills_demand.demand_count
    ,Avg_salary
from 
    skills_demand
inner JOIN
    average_salary
ON
skills_demand.skill_id = average_salary.skill_id
where
    demand_count > 10
order by 
     Avg_salary desc, demand_count desc
;
------------------------------------------------------------------

More concise way of writing a query
-----------------------------------------------------------------

select 
    skills_dim.skills
    ,skills_dim.skill_id
    ,COUNT(skills_job_dim.job_id) as demand_count
    ,ROUND(AVG(job_postings_fact.salary_year_avg)) as Avg_salary
FROM 
    job_postings_fact 
INNER JOIN 
    skills_job_dim 
ON 
    job_postings_fact .job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim 
ON 
    skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst'
    and salary_year_avg is not NULL
    and job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
having 
    COUNT(skills_job_dim.job_id) > 10
order by 
     Avg_salary desc, demand_count desc
Limit 30
;
