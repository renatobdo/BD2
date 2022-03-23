## https://www.devmedia.com.br/mysql-basico-triggers/37462

CREATE TABLE Produtos
(
	Referencia	VARCHAR(3) PRIMARY KEY,
	Descricao	VARCHAR(50) UNIQUE,
	Estoque	INT NOT NULL DEFAULT 0
);

INSERT INTO Produtos VALUES ('001', 'Feijão', 10);
INSERT INTO Produtos VALUES ('002', 'Arroz', 5);
INSERT INTO Produtos VALUES ('003', 'Farinha', 15);

CREATE TABLE ItensVenda
(
	Venda		INT,
	Produto	VARCHAR(3),
	Quantidade	INT
);

DELIMITER $

CREATE TRIGGER Tgr_ItensVenda_Insert AFTER INSERT
ON ItensVenda
FOR EACH ROW
BEGIN
	UPDATE Produtos SET Estoque = Estoque - NEW.Quantidade
WHERE Referencia = NEW.Produto;
END$

## caso seja cancelada uma venda deve-se voltar a quantidade que havia no estoque
CREATE TRIGGER Tgr_ItensVenda_Delete AFTER DELETE
ON ItensVenda
FOR EACH ROW
BEGIN
	UPDATE Produtos SET Estoque = Estoque + OLD.Quantidade
WHERE Referencia = OLD.Produto;
END$

DELIMITER ;

################ Testando a trigger AFTER INSERT #######################
INSERT INTO ItensVenda VALUES (1, '001',3);
select * from produtos;

INSERT INTO ItensVenda VALUES (1, '002',1);
select * from produtos;

INSERT INTO ItensVenda VALUES (1, '003',5);
select * from produtos;

################ Testando a trigger AFTER DELETE ########################
DELETE FROM ItensVenda WHERE Venda = 1 AND Produto = '001';
select * from produtos;

######## mostra todas as triggers ###############################
SHOW TRIGGERS

###### apaga a trigger criada #########################################
DROP TRIGGER Tgr_ItensVenda_Insert

###################################################################
##		 MAIS EXEMPLOS DE TRIGGERS 			 ##
## retirados de https://www.mysqltutorial.org/mysql-triggers/mysql after insert trigger/
#
###################################################################

#################################################################
################## BEFORE INSERT ################################
DROP TABLE IF EXISTS WorkCenters;

CREATE TABLE WorkCenters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

DROP TABLE IF EXISTS WorkCenterStats;

CREATE TABLE WorkCenterStats(
    totalCapacity INT NOT NULL
);

DELIMITER $$

CREATE TRIGGER before_workcenters_insert
BEFORE INSERT
ON WorkCenters FOR EACH ROW
BEGIN
    DECLARE rowcount INT;
    
    SELECT COUNT(*) 
    INTO rowcount
    FROM WorkCenterStats;
    
    IF rowcount > 0 THEN
        UPDATE WorkCenterStats
        SET totalCapacity = totalCapacity + new.capacity;
    ELSE
        INSERT INTO WorkCenterStats(totalCapacity)
        VALUES(new.capacity);
    END IF; 

END $$

DELIMITER ;

######################## TESTANDO a trigger BEFORE INSERT #################3#########
INSERT INTO WorkCenters(name, capacity)
VALUES('Mold Machine',100);

SELECT * FROM WorkCenterStats;    

INSERT INTO WorkCenters(name, capacity)
VALUES('Packing',200);

SELECT * FROM WorkCenterStats;
#######################################################

###############    AFTER INSERT #############################
DROP TABLE IF EXISTS members;

CREATE TABLE members (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    birthDate DATE,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS reminders;

CREATE TABLE reminders (
    id INT AUTO_INCREMENT,
    memberId INT,
    message VARCHAR(255) NOT NULL,
    PRIMARY KEY (id , memberId)
);

DELIMITER $$

CREATE TRIGGER after_members_insert
AFTER INSERT
ON members FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO reminders(memberId, message)
        VALUES(new.id,CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    END IF;
END$$

DELIMITER ;

################################### TESTANDO AFTER INSERT ################################
INSERT INTO members(name, email, birthDate)
VALUES
    ('John Doe', 'john.doe@example.com', NULL),
    ('Jane Doe', 'jane.doe@example.com','2000-01-01');

SELECT * FROM members;    
SELECT * FROM reminders;    


####################### Exemplos de triggers BEFORE update  ##################################
CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     employeeNumber = OLD.employeeNumber,
     lastname = OLD.lastname,
     changedat = NOW();
SHOW TRIGGERS;

##########################TESTANDO BEFORE UPDATE ######################
UPDATE employees 
SET 
    lastName = 'Phan'
WHERE
    employeeNumber = 1056;
    
SELECT * FROM employees_audit;

########################### DROPANDO A TRIGGER ###################
drop trigger before_employee_update;

####################### OUTRO EXEMPLO DE BEFORE UPDATE ##########
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    id INT AUTO_INCREMENT,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    fiscalYear SMALLINT NOT NULL,
    fiscalMonth TINYINT NOT NULL,
    CHECK(fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK(fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >=0),
    UNIQUE(product, fiscalYear, fiscalMonth),
    PRIMARY KEY(id)
);

INSERT INTO sales(product, quantity, fiscalYear, fiscalMonth)
VALUES
    ('2003 Harley-Davidson Eagle Drag Bike',120, 2020,1),
    ('1969 Corvair Monza', 150,2020,1),
    ('1970 Plymouth Hemi Cuda', 200,2020,1);

SELECT * FROM sales;

DELIMITER $$

CREATE TRIGGER before_sales_update
BEFORE UPDATE
ON sales FOR EACH ROW
BEGIN
    DECLARE errorMessage VARCHAR(255);
    SET errorMessage = CONCAT('The new quantity ',
                        NEW.quantity,
                        ' cannot be 3 times greater than the current quantity ',
                        OLD.quantity);
                        
    IF new.quantity > old.quantity * 3 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END $$

DELIMITER ;

########################### TESTANDO BEFORE UPDATE #########################################
UPDATE sales 
SET quantity = 150
WHERE id = 1;

SELECT * FROM sales;

UPDATE sales 
SET quantity = 500
WHERE id = 1;

###Error Code: 1644. The new quantity 500 cannot be 3 times greater than the current quantity 150

SHOW ERRORS;

############################# AFTER UPDATE ###################################################
CREATE TABLE Sales (
    id INT AUTO_INCREMENT,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    fiscalYear SMALLINT NOT NULL,
    fiscalMonth TINYINT NOT NULL,
    CHECK(fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK(fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >=0),
    UNIQUE(product, fiscalYear, fiscalMonth),
    PRIMARY KEY(id)
);
INSERT INTO Sales(product, quantity, fiscalYear, fiscalMonth)
VALUES
    ('2001 Ferrari Enzo',140, 2021,1),
    ('1998 Chrysler Plymouth Prowler', 110,2021,1),
    ('1913 Ford Model T Speedster', 120,2021,1);

SELECT * FROM Sales;

DROP TABLE IF EXISTS SalesChanges;

CREATE TABLE SalesChanges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    salesId INT,
    beforeQuantity INT,
    afterQuantity INT,
    changedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER after_sales_update
AFTER UPDATE
ON sales FOR EACH ROW
BEGIN
    IF OLD.quantity <> new.quantity THEN
        INSERT INTO SalesChanges(salesId,beforeQuantity, afterQuantity)
        VALUES(old.id, old.quantity, new.quantity);
    END IF;
END$$

DELIMITER ;

select * from sales;

################################### TESTANDO AFTER UPDATE ####################################
UPDATE Sales 
SET quantity = 350
WHERE id = 1;

SELECT * FROM SalesChanges;
select * from sales;

################################## AUMENTANDO A QUANTIDADE EM 10% ############################
UPDATE Sales 
SET quantity = CAST(quantity * 1.1 AS UNSIGNED);
# 1 - 385
# 2 - 121
# 3 - 132 
SELECT * FROM SalesChanges;


################################### BEFORE DELETE ##############################################

DROP TABLE IF EXISTS Salaries;

CREATE TABLE Salaries (
    employeeNumber INT PRIMARY KEY,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0
   # 1234567891,23
);

INSERT INTO salaries(employeeNumber,validFrom,amount)
VALUES
    (1002,'2000-01-01',50000),
    (1056,'2000-01-01',60000),
    (1076,'2000-01-01',70000);

select * from salaries;
DROP TABLE IF EXISTS SalaryArchives;    

CREATE TABLE SalaryArchives (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employeeNumber INT,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0,
    deletedAt TIMESTAMP DEFAULT NOW()
);

DELIMITER $$

CREATE TRIGGER tgr_before_salaries_delete
BEFORE DELETE
ON salaries FOR EACH ROW
BEGIN
    INSERT INTO SalaryArchives(employeeNumber,validFrom,amount)
    VALUES(OLD.employeeNumber,OLD.validFrom,OLD.amount);
END$$    
DELIMITER ;

select * from salaries;

###################################### TESTANDO BEFORE DELETE ##########################################
DELETE FROM salaries
WHERE employeeNumber = 1002;

SELECT * FROM SalaryArchives;    

DELETE FROM salaries;

SELECT * FROM SalaryArchives;

####################################### AFTER DELETE ###################################################

DROP TABLE IF EXISTS Salaries;

CREATE TABLE Salaries (
    employeeNumber INT PRIMARY KEY,
    salary DECIMAL(10,2) NOT NULL DEFAULT 0
);
INSERT INTO Salaries(employeeNumber,salary)
VALUES
    (1002,5000),
    (1056,7000),
    (1076,8000);
DROP TABLE IF EXISTS SalaryBudgets;

CREATE TABLE SalaryBudgets(
    total DECIMAL(15,2) NOT NULL
);
INSERT INTO SalaryBudgets(total)
SELECT SUM(salary) 
FROM Salaries;

SELECT * FROM SalaryBudgets;        

CREATE TRIGGER after_salaries_delete
AFTER DELETE
ON Salaries FOR EACH ROW
UPDATE SalaryBudgets 
SET total = total - old.salary;

##################################### testando AFTER DELETE ############################################
DELETE FROM Salaries
WHERE employeeNumber = 1002;

SELECT * FROM SalaryBudgets;    

DELETE FROM Salaries;

SELECT * FROM SalaryBudgets;    

