##################    Para esses exemplos utilizar o banco de dados classicmodels #####################################
################################### Procedimento armazenado que utiliza IF e com parâmetro de entrada e saída ################
DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL(10,2) DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSEIF credit <= 50000 AND credit > 10000 THEN
        SET pCustomerLevel = 'GOLD';
    ELSE
        SET pCustomerLevel = 'SILVER';
    END IF;
END$$

DELIMITER ;
#####
#
CALL GetCustomerLevel(141, @level);
SELECT @level;
#
CALL GetCustomerLevel(447, @level); 
SELECT @level;
#
