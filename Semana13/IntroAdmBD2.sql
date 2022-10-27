select user from mysql.user;

create user pedro@localhost identified by 'Secure2pass!';



select user from mysql.user;

## se logar com o usuário bob
show databases;

create database bobdb;
use bobdb;
create database pedrodb;
use pedrodb;



create table lists(
id int auto_increment primary key,
todo varchar(100) not null,
completed bool default false);

grant all privileges on bobdb.* to bob@localhost;
grant all privileges on pedrodb.* to pedro@localhost;

grant all privileges on pedrodb.lists to bob@localhost;
GRANT 
   SELECT (todo)
ON lists
TO bob@localhost;

SHOW GRANTS FOR pedro@localhost;
SHOW GRANTS FOR bob@localhost;

CREATE DATABASE crm;

CREATE TABLE customers(
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL, 
    last_name VARCHAR(255) NOT NULL, 
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(255)
);

INSERT INTO customers(first_name,last_name,phone,email)
VALUES('John','Doe','(408)-987-7654','john.doe@mysqltutorial.org'),
      ('Lily','Bush','(408)-987-7985','lily.bush@mysqltutorial.org');
      
SELECT * FROM customers;

CREATE ROLE 
    crm_dev, 
    crm_read, 
    crm_write;

select * from mysql.user;

GRANT ALL 
ON crm.* 
TO crm_dev;

GRANT SELECT 
ON crm.* 
TO crm_read;

GRANT INSERT, UPDATE, DELETE
ON crm.* 
TO crm_write;

-- developer user 
CREATE USER crm_dev1@localhost IDENTIFIED BY 'Secure$1782';
-- read access user
CREATE USER crm_read1@localhost IDENTIFIED BY 'Secure$5432';    
-- read/write users
CREATE USER crm_write1@localhost IDENTIFIED BY 'Secure$9075';   
CREATE USER crm_write2@localhost IDENTIFIED BY 'Secure$3452';

GRANT crm_dev 
TO crm_dev1@localhost;

GRANT crm_read 
TO crm_read1@localhost;

GRANT crm_read, 
    crm_write 
TO crm_write1@localhost, 
    crm_write2@localhost;
    
SHOW GRANTS FOR crm_dev1@localhost;
SHOW GRANTS 
FOR crm_write1@localhost 
USING crm_write;

SELECT current_role();
SET DEFAULT ROLE ALL TO crm_read1@localhost;

SET ROLE NONE;

SET ROLE ALL;

SET ROLE DEFAULT;

##Exercícios slide semana 13:
#Q1 ok
#Q2
create user ray@localhost identified by 'Secure1pass!' PASSWORD EXPIRE
INTERVAL 90 DAY;
SELECT * FROM MYSQL.USER;
GRANT SELECT, INSERT, UPDATE on
	ap.vendors to ray@localhost;
GRANT SELECT, INSERT, UPDATE on
	ap.invoices to ray@localhost;

create user gu3021939@localhost identified by 'gu3021939';