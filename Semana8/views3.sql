#### Exercício 15 slide semana 8
## Utilizar o BD survey
select country,
    count(*) as respondents,
    avg(years_experience) as yrs_experience,
    avg(case when is_manager = 'Yes' then 1 else 0 end) as pct_mgrs,
    avg(case when education_level = 'Masters' then 1 else 0 end) as pct_masters
from salary_survey
group by 1 order by 2 desc;
