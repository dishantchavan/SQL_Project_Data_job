
select 
    skills
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
    skills
order by 
    Avg_salary desc
Limit 30
;


/*
 Top-paying skills for data analysts:

Big Data & Cloud Demand: Skills like Pyspark, Databricks, and AWS/GCP/Azure indicate a strong demand for expertise in big data processing and cloud-based analytics.

Collaboration & Version Control: Gitlab, Bitbucket, and Git skills are essential, highlighting the importance of collaborative coding practices and version control in data analysis.

AI & Advanced Analytics: DataRobot, Watson, and scikit-learn signify the rising need for skills in machine learning and AI, showcasing the trend towards advanced analytics solutions.
*/