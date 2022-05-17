###
# Criação de usuário
##########################
#Um script que cria 1 usuário e garante permissões a ele:
########################
CREATE USER 'admin02'@'localhost' IDENTIFIED BY 'admin02';

GRANT ALL PRIVILEGES
ON *.*
TO 'admin02'@'localhost' WITH GRANT OPTION;

#######################
#Um script que cria 2 usuários e garante permissões a eles:
#######################
CREATE USER 'ap_admin'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'ap_user'@'localhost' IDENTIFIED BY 'password';

GRANT ALL
ON ap.*
TO 'ap_ admin'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ap.*
TO 'ap_user'@'localhost';

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
CREATE USER 'joel'@'localhost' IDENTIFIED BY 'sesame'
#
#A statement that creates a user from any host
CREATE USER IF NOT EXISTS jane IDENTIFIED BY 'sesame' -- creates jane@%

#A statement that creates a user whose password expires immediately
CREATE USER 'anne'@'localhost' PASSWORD EXPIRE

#A statement that creates a user whose last five passwords can't be reused
CREATE USER jim IDENTIFIED BY 'sesame' PASSWORD HISTORY 5

#A statement that creates a user whose passwords can't be reused for 365 days
CREATE USER john IDENTIFIED BY 'sesame' PASSWORD REUSE INTERVAL 365 DAY

#How to rename a user
#The syntax of the RENAME USER statement
RENAME USER username TO new username

#A statement that renames a user from a specific host
RENAME USER 'joel'@'localhost' TO 'joelmurach'@'localhost'

#How to drop a user
#The syntax of the DROP USER statement
DROP USER [IF EXISTS] username

#A statement that drops a user from a specific host
DROP USER 'joelmurach'@'localhost'

#A statement that drops a user from any host
DROP USER IF EXISTS jane
-- drops jane@%

#
The syntax of an account name
username[@hostname]

A user that can only connect from the same server as MySQL
john@loca1host

The same user with optional quotation marks
'john'@'localhost'

The same user with an IP address instead of the localhost keyword
john@127.0.0.1

A user that can connect from any computer
john

The same user but with the wildcard character explicitly coded
john@'% '

A user that can only connect from the murach.com domain
john@'%.murach.com'

A username that needs to be coded with quotes
'quinn-the-mighty'@'%.murach.com'

###
#The syntax of the GRANT statement
GRANT privilege_ list
ON [db_name.] table
TO userl [, user2 ] ...
[WITH GRANT OPTION]

#A statement that grants global privileges to a user
GRANT ALL
ON *.*
TO jim
WITH GRANT OPTION

#A statement that grants database privileges to a user
GRANT SELECT, INSERT, UPDATE
ON ap.*
TO joel@localhost

#A statement that grants table privileges to a user
GRANT SELECT, INSERT, UPDATE
ON ap.vendors
TO joel@localhost

#A statement that grants column privileges to a user
GRANT SELECT (vendor_ name, vendor_ state, vendor_ zip_ code),
UPDATE (vendor_addressl)
ON ap.vendors
TO joel@localhost

#A statement that uses the current database
GRANT SELECT, INSERT, UPDATE, DELETE
ON vendors
TO ap_user@localhost

#A statement that gives a user the ability to grant privileges to other users
GRANT USAGE
ON*.*
TO anne@localhost
WITH GRANT OPTION

#
#A statement that displays a list of users
#SELECT User, Host FROM mysql.user

A statement that displays a list of users
SELECT User, Host FROM mysql.user

The syntax of the SHOW GRANTS statement
SHOW GRANTS [FOR user]

A statement that shows the privileges for a user from any host
SHOW GRANTS FOR jim

A statement that shows the privileges for a user from a specific host
SHOW GRANTS FOR ap_user@localhost

A statement that shows the privileges for the current user
SHOW GRANTS
