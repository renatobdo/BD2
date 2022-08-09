create table doctors (doctor_id int primary key,
doctor_name varchar(100));
create table visits (doctor_id int primary key,
patient_name varchar(100), vdate date,
FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id) ON DELETE CASCADE 
ON UPDATE CASCADE);
alter table visits drop primary key;
alter table visits add primary key (doctor_id, patient_name) ;

insert into doctors values (210, 'Dr. John Linga'),
(211, 'Dr. Peter Hall'),
(212, 'Dr. Ke Gee'),
(213, 'Dr. Pat Fay');

insert into visits values (210, 'Julia Nayer','2013-10-15'),
(214, 'TJ Olson','2013-10-14'),
(215, 'John Seo','2013-10-15'),
(212, 'James Marlow','2013-10-16');

insert into visits values (212, 'Jason Mallin','2013-10-12');

select * from visits;

select a.doctor_id, a.doctor_name, c.patient_name, c.vdate
from doctors a 
RIGHT JOIN visits c
 on a.doctor_id = c.doctor_id;