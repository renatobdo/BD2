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
####################################################################
# Procedimento armazenado que utiliza CASE
####################################################################
#
DELIMITER $$
CREATE PROCEDURE GetCustomerShipping(
	IN  pCustomerNUmber INT, 
	OUT pShipping       VARCHAR(50))
BEGIN
    DECLARE customerCountry VARCHAR(100);
	SELECT 
		country
	INTO customerCountry FROM
		customers
	WHERE
		customerNumber = pCustomerNUmber;
    CASE customerCountry
		WHEN  'USA' THEN
		   SET pShipping = '2-day Shipping';
		WHEN 'Canada' THEN
		   SET pShipping = '3-day Shipping';
		ELSE
		   SET pShipping = '5-day Shipping';
	END CASE;
END$$
DELIMITER ;
#
CALL GetCustomerShipping(112,@shipping);
SELECT @shipping;
