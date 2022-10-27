select user from mysql.user;    
create user ifsp_bd2_tercas@localhost
	identified by 'Secure1pass!';
create database ifsp_bd2_tercasdb;
grant all privileges on ifsp_bd2_tercasdb.* 
	to ifsp_bd2_tercas@localhost;

 create table lists(
id int auto_increment primary key,
todo varchar(100) not null,
completed bool default false);

insert into lists(todo) values('Learn MySQL');


show grants for ifsp_bd2_tercas@localhost;
show grants for super_ifsp@localhost;

