#################
################# cursor 
#################
drop procedure createEmailList;
DELIMITER $$
CREATE PROCEDURE createEmailList (
	INOUT emailList varchar(4000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE emailAddress varchar(100) DEFAULT "";

	-- declare cursor for employee email
	DEClARE curEmail 
		CURSOR FOR 
			SELECT email FROM employees;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curEmail;

	getEmail: LOOP
		FETCH curEmail INTO emailAddress;
		IF finished = 1 THEN 
			LEAVE getEmail;
		END IF;
		-- build email list
		SET emailList = CONCAT(emailAddress,";",emailList);
	END LOOP getEmail;
	CLOSE curEmail;

END$$
DELIMITER ;

SET @emailList = ""; 
CALL createEmailList(@emailList); 
SELECT @emailList;

##################################
# Exemplo 2
#################################

 CREATE DATABASE TUTORIAL_CURSOR;
  USE TUTORIAL_CURSOR;

  CREATE TABLE VEICULOS(
  VEICULO varchar(32) NOT NULL,
  KILOMETRAGEM int NOT NULL
  );

  INSERT INTO VEICULOS (VEICULO, KILOMETRAGEM) VALUES ('Carro 1',  '5230');
  INSERT INTO VEICULOS (VEICULO, KILOMETRAGEM) VALUES ('Carro 2',  '7800');
  INSERT INTO VEICULOS (VEICULO, KILOMETRAGEM) VALUES ('Carro 3', '16540');
  INSERT INTO VEICULOS (VEICULO, KILOMETRAGEM) VALUES ('Carro 4', '32230');

  DROP PROCEDURE IF EXISTS TUTORIAL_CURSOR.SomaKilometragem;

  DELIMITER $$
  CREATE PROCEDURE TUTORIAL_CURSOR.SomaKilometragem (OUT resultado INT)
  BEGIN

  -- Definição de variáveis utilizadas na Procedure
  DECLARE existe_mais_linhas INT DEFAULT 0;
  DECLARE kilometros INT DEFAULT 0;
  DECLARE total_de_kilometros INT DEFAULT 0;

  -- Definição do cursor
  DECLARE meuCursor CURSOR FOR SELECT KILOMETRAGEM FROM VEICULOS;

  -- Definição da variável de controle de looping do cursor
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas=1;

  -- Abertura do cursor
  OPEN meuCursor;

  -- Looping de execução do cursor
  meuLoop: LOOP
  FETCH meuCursor INTO kilometros;

  -- Controle de existir mais registros na tabela
  IF existe_mais_linhas = 1 THEN
  LEAVE meuLoop;
  END IF;

  -- Soma a kilometragem do registro atual com o total acumulado
  SET total_de_kilometros = total_de_kilometros + kilometros;

  -- Retorna para a primeira linha do loop
  END LOOP meuLoop;

  -- Setando a variável com o resultado final
  SET resultado = total_de_kilometros;

  END $$

  DELIMITER ;

  CALL SomaKilometragem(@variavel_temporaria);
  SELECT @variavel_temporaria;
  
  ###########################################
  # Exemplo 3
  ########
##
# outro exemplo de cursores
#
CREATE TABLE tutorials (
   ID INT PRIMARY KEY,
   TITLE VARCHAR(100),
   AUTHOR VARCHAR(40),
   DATE VARCHAR(40)
);

insert into tutorials values(1, 'Java', 'Krishna', '2019-09-01');
insert into tutorials values(2, 'JFreeCharts', 'Satish', '2019-05-01');
insert into tutorials values(3, 'JavaSprings', 'Amit', '2019-05-01');
insert into tutorials values(4, 'Android', 'Ram', '2019-03-01');
insert into tutorials values(5, 'Cassandra', 'Pruthvi', '2019-04-06');

CREATE TABLE backup (
   ID INT,
   TITLE VARCHAR(100),
   AUTHOR VARCHAR(40),
   DATE VARCHAR(40)
);

DELIMITER //
CREATE PROCEDURE ExampleProc()
   BEGIN
      DECLARE done INT DEFAULT 0;
      DECLARE tutorialID INTEGER;
      DECLARE tutorialTitle, tutorialAuthor, tutorialDate VARCHAR(20);
      
      DECLARE cur CURSOR FOR SELECT * FROM tutorials;
      
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      
      OPEN cur;
      
      label: LOOP
		FETCH cur INTO tutorialID, 
			tutorialTitle, tutorialAuthor, tutorialDate;
		INSERT INTO backup VALUES(tutorialID, tutorialTitle, tutorialAuthor, tutorialDate);
		IF done = 1 THEN 
			LEAVE label;
		END IF;
      END LOOP;
      CLOSE cur;
   END//
DELIMITER ;

CALL ExampleProc;
select * from backup;
