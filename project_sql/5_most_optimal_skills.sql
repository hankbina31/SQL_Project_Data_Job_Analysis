SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(job_postings_fact.job_id) AS demand_skill_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
HAVING
    COUNT(job_postings_fact.job_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_skill_count DESC   
LIMIT 25;
/* 1. Demand AnalysisDominant Core Skills: SQL is the most in-demand skill ($7,291$ occurrences), followed by Excel ($4,611$) and Python ($4,330$). These three form the primary technical foundation for the role.Visualization Tools: Tableau ($3,745$) shows significantly higher demand than Power BI ($2,609$) and Looker ($868$), establishing it as the leading visualization tool in this dataset.Niche vs. Broad Demand: Azure and Powerpoint represent the lower end of the top 10 demand scale, with fewer than $830$ occurrences each.2. Salary AnalysisHighest Earning Potential: Azure commands the highest average salary at approximately $\$111,225$, despite having the second-lowest demand in the top 10.Salary Leaders: Python ($\$101,397$), R ($\$100,498$), and Looker ($\$103,795$) are the only other skills averaging over $\$100,000$.Lowest Average Salaries: Excel ($\$87,288$) and Powerpoint ($\$88,701$) are the only skills with an average salary below $\$90,000$.3. Key Trends and CorrelationsNegative Correlation between Demand and Salary: There is a moderate negative correlation ($r \approx -0.30$) between a skill's demand and its average salary. This indicates that while foundational skills like SQL and Excel are required most frequently, specialized or technical skills (Azure, Python, Looker) command higher financial premiums.Technical Premium: Programming-heavy skills (Python, R) and Cloud platforms (Azure) consistently outperform administrative or presentation tools (Excel, Powerpoint) in salary metrics.The "Sweet Spot": Python and Tableau represent a high-value balance, maintaining both high demand ($>3,500$) and high average salaries ($>\$99,000$).
*/