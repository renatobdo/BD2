create table website_sessions(
	website_session_id bigint,
    created_at datetime,
    user_id bigint,
    is_repeat_session int,
    utm_source varchar(50),
    utm_campaign varchar(50),
    utm_content varchar(50),
    device_type varchar(50),
    http_referer varchar(100),
   primary key (website_session_id)
);


## importe as tabelas 14 e 15 do git https://github.com/renatobdo/BD2/tree/main/Semana6-22_03_2022

##  Exercício 17

create view monthly_sessions as
select 
	year(created_at) as ano,
    month(created_at) as mes,
    utm_source,
    utm_campaign, 
    count(website_session_id) as number_of_sessions
    from website_sessions
    group by 1,2,3,4;
