show databases;
use ifsp_bd2_tercasdb;
select * from lists;

show grants for ifsp_bd2_tercas@localhost;

CREATE USER super_ifsp@localhost 
IDENTIFIED BY 'Secure1Pass!';

grant all privileges on ifsp_bd2_tercasdb.* 
	to super_ifsp@localhost;