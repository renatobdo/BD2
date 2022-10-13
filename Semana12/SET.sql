#######################################
# Sintaxe para setar variáveis de sistema
######################################
#global
SET global var_name = var_value;

#session variables
SET [session] var_name = var_value;

# Exemplos para setar variáveis de sistema
SET GLOBAL AUTOCOMMIT = ON;
SET SESSION AUTOCOMMIT = OFF;
SET GLOBAL AUTOCOMMIT = DEFAULT;

SET GLOBAL MAX_CONNECTIONS = 90;
SET GLOBAL MAX_CONNECTIONS = DEFAULT;

SET GLOBAL tmp_table_size = 36700160;
SET GLOBAL tmp_table_size = 35 * 1024 * 1024;

# Exemplos que buscam as variáveis de sistema
select @@global.autocommit, @@session.autocommit;


