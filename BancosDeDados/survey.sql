create database survey;
use survey;

create table salary_survey(country varchar(50),
years_experience bigint,
employment_status varchar(50),
job_title varchar(50),
is_manager varchar(5),
education_level varchar(50));

select count(*) from salary_survey;
drop table salary_survey3;

select country,
    count(*) as respondents,
    avg(years_experience) as yrs_experience,
    avg(case when is_manager = 'Yes' then 1 else 0 end) as pct_mgrs,
    avg(case when education_level = 'Masters' then 1 else 0 end) as pct_masters
from salary_survey
group by 1 order by 2 desc;

select * from salary_survey order by years_experience DESC;
update salary_survey set years_experience = null where years_experience > 60;