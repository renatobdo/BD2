###
# Criação de usuário
#####

CREATE USER ap_ admin@loc alhost IDENTIFIED BY 'password';
CREATE USER ap_user@localhost IDENTIFIED BY 'password';

GRANT ALL
ON ap.*
TO ap_ admin@localhost;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ap.*
TO ap_user@localhost;

show grants for ap_admin@localhost;
show privileges;

select * from mysql.tables_priv;
select * from mysql.db;
select * from mysql.tables_priv;
select * from mysql.columns_priv;


#How to create a user
#The syntax of the CREATE USER statement
CREATE USER [IF NOT EXISTS] username [IDENTIFIED BY password]
[PASSWORD EXPIRE [DEFAULT INEVER IINTERVAL days DAY] I
PASSWORD HISTORY {DEFAULT lnwnber_passwords} I
PASSWORD REUSE INTERVAL {DEFAULT ldays DAY}]

#A statement that creates a user from a specific host
CREATE USER joel@localhost IDENTIFIED BY 'sesame'
#
#A statement that creates a user from any host
CREATE USER IF NOT EXISTS jane IDENTIFIED BY 'sesame' -- creates jane@%

#A statement that creates a user whose password expires immediately
CREATE USER anne@localhost PASSWORD EXPIRE

#A statement that creates a user whose last five passwords can't be reused
CREATE USER jim IDENTIFIED BY 'sesame' PASSWORD HISTORY 5

#A statement that creates a user whose passwords can't be reused for 365 days
CREATE USER john IDENTIFIED BY 'sesame' PASSWORD REUSE INTERVAL 365 DAY

#How to rename a user
#The syntax of the RENAME USER statement
RENAME USER username TO new username

#A statement that renames a user from a specific host
RENAME USER joel@localhost TO joelmurach@localhost

#How to drop a user
#The syntax of the DROP USER statement
DROP USER [IF EXISTS] username

#A statement that drops a user from a specific host
DROP USER joelmurach@localhost

#A statement that drops a user from any host
DROP USER IF EXISTS jane
-- drops jane@%

