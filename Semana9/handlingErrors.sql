##
# https://www.mysqltutorial.org/mysql-error-handling-in-stored-procedures/
# Criação da tabela
##
CREATE TABLE SupplierProducts (
    supplierId INT,
    productId INT,
    PRIMARY KEY (supplierId , productId)
);
###
# Criando a procedure que irá tratar o erro
###
DELIMITER $$
CREATE PROCEDURE InsertSupplierProduct(
    IN inSupplierId INT, 
    IN inProductId INT
)
BEGIN
    -- exit if the duplicate key occurs
    -- troque o EXIT pelo CONTINUE e veja a diferença
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT CONCAT('Duplicate key (',inSupplierId,',',inProductId,') occurred') AS message;
    END;
    
    -- insert a new row into the SupplierProducts
    INSERT INTO SupplierProducts(supplierId,productId)
    VALUES(inSupplierId,inProductId);
    
    -- return the products supplied by the supplier id
    SELECT COUNT(*) 
    FROM SupplierProducts
    WHERE supplierId = inSupplierId;
    
END$$

DELIMITER ;
#
# Testando
#
CALL InsertSupplierProduct(1,1);
CALL InsertSupplierProduct(1,2);
CALL InsertSupplierProduct(1,3);
CALL InsertSupplierProduct(1,3);
#
##########################
# Erros customizados
################################
DROP PROCEDURE IF EXISTS TestProc;
DELIMITER $$
CREATE PROCEDURE TestProc()
BEGIN
    DECLARE TableNotFound CONDITION for 1146 ; 
    DECLARE EXIT HANDLER FOR TableNotFound 
	SELECT 'Please create table abc first' Message; 
    SELECT * FROM abc;
END$$
DELIMITER ;
#
call TestProc();
#
########################################
# Levantando erros https://www.mysqltutorial.org/mysql-signal-resignal/
########################################
DELIMITER $$

CREATE PROCEDURE AddOrderItem(
		         in orderNo int,
			 in productCode varchar(45),
			 in qty int, 
                         in price double, 
                         in lineNo int )
BEGIN
	DECLARE C INT;

	SELECT COUNT(orderNumber) INTO C
	FROM orders 
	WHERE orderNumber = orderNo;

	-- check if orderNumber exists
	IF(C != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Order No not found in orders table';
	END IF;
	-- more code below
	-- ...
END$$
### 
CALL AddOrderItem(10,'S10_1678',1,95.7,1);
