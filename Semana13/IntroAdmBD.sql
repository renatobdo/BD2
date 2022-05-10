### Semana 13 - Introdução a Administração de Banco de Dados ##############

## Trabalhando com eventos agendados (Working with MySQL Scheduled Event)
#### https://www.mysqltutorial.org/mysql-triggers/working-mysql-scheduled-event/ ##################
#
#
#
# Criando um exemplo de evento único
#
CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    message VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL
);
#
CREATE EVENT IF NOT EXISTS test_event_01
ON SCHEDULE AT CURRENT_TIMESTAMP
DO
  INSERT INTO messages(message,created_at)
  VALUES('Test MySQL Event 1',NOW());
#
## Verifidando a mensagem
#
SELECT * FROM messages;
#
#
SHOW EVENTS FROM classicmodels;
#
#A saída não mostra nenhuma linha porque o evento é descartado automaticamente quando expira. 
# Nesse caso, é um evento único e expirou quando sua execução foi concluída.
# Para manter o evento após sua expiração, use a cláusula ON COMPLETION PRESERVE.
#
CREATE EVENT test_event_02
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
   INSERT INTO messages(message,created_at)
   VALUES('Test MySQL Event 2',NOW());
##
#Verificando
#
SELECT * FROM messages;
#
#Se você executar a instrução SHOW EVENTS novamente, verá que o evento 
#está lá devido ao efeito da cláusula ON COMPLETION PRESERVE:
#
#
SHOW EVENTS FROM classicmodels;
#
#Criando um exemplo de evento recorrente
#
#

CREATE EVENT test_event_03
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
   INSERT INTO messages(message,created_at)
   VALUES('Test MySQL recurring Event',NOW());
#
#
#Observe que usamos as cláusulas STARTS e ENDS para definir o período de expiração do evento.
#Você pode testar esse evento recorrente aguardando alguns minutos e verificando a tabela de mensagens.
SELECT * FROM messages;

#
#Dropar um evento
DROP EVENT [IF EXIST] event_name;
DROP EVENT IF EXIST test_event_03;

#
##################################
#Variáveis de sistema
##################
# Variáveis GLOBAL e SESSION
SELECT @@GLOBAL.autocommit, @@SESSION.autocommit;

#
SELECT*, CHAR(argument) AS argument_text FROM mysql.general_log;
