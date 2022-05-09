### Semana 13 - Introdução a Administração de Banco de Dados ##############

# Variáveis GLOBAL e SESSION
SELECT @@GLOBAL.autocommit, @@SESSION.autocommit;

#
SELECT*, CHAR(argument) AS argument_text FROM mysql.general_log;
