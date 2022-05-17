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

# REVOKE
The syntax of the REVOKE statement for all privileges
REVOKE ALL[ PRIVILEGES], GRANT OPTION
FROM userl[, user2] ...

A statement that revokes all privileges from a user
REVOKE ALL, GRANT OPTION
FROM jim

A statement that revokes all privileges from multiple users
REVOKE ALL, GRANT OPTION
FROM ap_user, anne@localhost

The syntax of the REVOKE statement for specific privileges
REVOKE privilege_ list
ON [db_name.]table
FROM userl[, user2] ...

A statement that revokes specific privileges from a user
REVOKE INSERT, UPDATE
ON ap.vendors FROM joel@localhost
#############################################
###Como alterar senhas
############################################
How to use the ALTER USER statement
The syntax
ALTER USER [IF EXISTS] {username |USER()} [IDENTIFIED BY 'password']
[PASSWORD EXPIRE [DEFAULT |NEVER |INTERVAL days DAY] |
PASSWORD HISTORY {DEFAULT | number_passwords} I
PASSWORD REUSE INTERVAL {DEFAULT |days DAY}]

A statement that changes a user's password
ALTER USER john IDENTIFIED BY 'password'

A statement that changes the current user's password
ALTER USER USER () IDENTIFIED BY 'secret' 

A statement that forces a user to change their password every 90 days
ALTER USER IF EXISTS john PASSWORD EXPIRE INTERVAL 90 DAY

How to use the SET PASSWORD statement
The syntax
SET PASSWORD [FOR username] = 'password'

A statement that changes a user's password
SET PASSWORD FOR john= 'password'

A statement that changes the current user's password
SET PASSWORD= 'secret'

A SELECT statement that selects all users that don't have passwords
SELECT Host, User
FROM mysql.user
WHERE authentication_ string = ''

###############################
# Script que configura usuários e privilégios para um banco de dados
###################################
A script that sets up the users and privileges for a database
-- drop the users (remove IF EXISTS for MySQL 5.6 and earlier)
DROP USER IF EXISTS john;
DROP USER IF EXISTS jane;
DROP USER IF EXISTS jim;
DROP USER IF EXISTS joel@localhost;
-- create the users
CREATE USER john IDENTIFIED BY 'sesame';
CREATE USER jane IDENTIFIED BY 'sesame';
CREATE USER jim IDENTIFIED BY 'sesame';
CREATE USER joel@localhost IDENTIFIED BY 'sesame';

-- grant privileges to a developer (joel)
GRANT ALL ON *.* TO joel@localhost WITH GRANT OPTION;

-- grant privileges to the ap manager (jim)
GRANT SELECT, INSERT, UPDATE, DELETE ON ap.* TO jim WITH GRANT OPTION;

-- grant privileges to ap users (john, jane)
GRANT SELECT, INSERT, UPDATE, DELETE ON ap.vendors TO john, jane;
GRANT SELECT, INSERT, UPDATE, DELETE ON ap.invoices TO john, jane;
GRANT SELECT, INSERT, UPDATE, DELETE ON ap.invoice_ line_ items TO john,
GRANT SELECT ON ap.general_ ledger_accounts TO john, jane;
GRANT SELECT ON ap.terms TO john, jane;

######################
## ROLES (papéis ou funções) em um banco de dados
####################
How to create a role
The syntax of the CREATE ROLE statement
CREATE ROLE [IF NOT EXISTS] rolel[, role2] ...

A statement that creates a new role
CREATE ROLE invoice_entry

How to grant privileges to roles
GRANT INSERT, UPDATE
ON invoices
TO invoice_entry
GRANT INSERT, UPDATE
ON invoice_line_items
TO invoice_entry

How to assign users to roles
The syntax of the GRANT statement for assigning users to roles
GRANT rolel[, role2]...
TO usernamel[, username2] ...
[WITH ADMIN OPTION]

A statement that assigns two users to the new role
GRANT invoice_entry TO john, jane

How to display the privileges for a role
SHOW GRANTS FOR invoice_entry

####
## Como configurar papéis default (padrão)
####################
How to set the default roles
The syntax of the SET DEFAULT ROLE statement
SET DEFAULT ROLE {NONE |ALL |role|[, role2] ... }
TO usernamel[, username2] ...

A statement that sets the default role for two users
SET DEFAULT ROLE invoice_entry TO john, jane

How to change the active roles
The syntax of the SET ROLE statement
SET ROLE {DEFAULT|NONE |ALL |ALL EXCEPT rolel[, role2] ... |rolel[, role2] ... }

A statement that changes the active role
SET ROLE invoice_entry

How to display the roles that are currently active
SELECT CURRENT_ROLE( )

How to revoke privileges from roles
REVOKE UPDATE
ON invoice_line_items
FROM invoice_entry

How to remove users from roles
The syntax of the REVOKE statement for removing users from roles
REVOKE rolel[, role2] ...
FROM usernamel[, username2] ...

A statement that removes a user from the new role
REVOKE invoice_entry FROM john

How to drop roles
The syntax of the DROP ROLE statement
DROP ROLE [IF EXISTS] rolel [, role2] ...

A statement that deletes the new role
DROP ROLE invoice_entry
