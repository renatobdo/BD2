use test;
create table doctors (doctor_id int primary key,
doctor_name varchar(100));
create table visits (doctor_id int,
patient_name varchar(100), vdate date);
#FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id) ON DELETE CASCADE 
#ON UPDATE CASCADE);
#drop table visits;
#drop table doctors;
#alter table visits drop primary key;
#alter table visits add primary key (doctor_id, patient_name) ;
alter table visits add id int after doctor_id;

select * from doctors;
insert into doctors values (210, 'Dr. John Linga'),
(211, 'Dr. Peter Hall'),
(212, 'Dr. Ke Gee'),
(213, 'Dr. Pat Fay');
select * from visits;
insert into visits values (210, 3,'Julia Nayer','2013-10-15'),
(214, 2,'TJ Olson','2013-10-14'),
(215, 4,'John Seo','2013-10-15'),
(212, 5,'James Marlow','2013-10-16');
insert into visits values (212, 1,'Jason Mallin','2013-10-12');
delete from visits;

select * from visits;
alter table visits add primary key (id);

