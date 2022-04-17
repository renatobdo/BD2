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
#
##
####################################################################
# Procedimento armazenado 2 que utiliza CASE
####################################################################

DELIMITER $$
CREATE PROCEDURE GetDeliveryStatus(
	IN pOrderNumber INT,
    OUT pDeliveryStatus VARCHAR(100)
)
BEGIN
	DECLARE waitingDay INT DEFAULT 0;
    SELECT 
		DATEDIFF(requiredDate, shippedDate)
	INTO waitingDay
	FROM orders
    WHERE orderNumber = pOrderNumber;
    
    CASE 
		WHEN waitingDay = 0 THEN 
			SET pDeliveryStatus = 'On Time';
        WHEN waitingDay >= 1 AND waitingDay < 5 THEN
			SET pDeliveryStatus = 'Late';
		WHEN waitingDay >= 5 THEN
			SET pDeliveryStatus = 'Very Late';
		ELSE
			SET pDeliveryStatus = 'No Information';
	END CASE;	
END$$
DELIMITER ;
#
CALL GetDeliveryStatus(10100,@delivery);
select @delivery as 'status da entrega';
#
#
####################
# Procedimento armazenado que retorna múltiplos valores
#https://www.mysqltutorial.org/mysql-stored-procedures-return-multiple-values/
#####################
DELIMITER $$

CREATE PROCEDURE get_order_by_cust(
	IN cust_no INT,
	OUT shipped INT,
	OUT canceled INT,
	OUT resolved INT,
	OUT disputed INT)
BEGIN
		-- shipped
		SELECT
            count(*) INTO shipped
        FROM
            orders
        WHERE
            customerNumber = cust_no
                AND status = 'Shipped';

		-- canceled
		SELECT
            count(*) INTO canceled
        FROM
            orders
        WHERE
            customerNumber = cust_no
                AND status = 'Canceled';

		-- resolved
		SELECT
            count(*) INTO resolved
        FROM
            orders
        WHERE
            customerNumber = cust_no
                AND status = 'Resolved';

		-- disputed
		SELECT
            count(*) INTO disputed
        FROM
            orders
        WHERE
            customerNumber = cust_no
                AND status = 'Disputed';

END$$
#
CALL get_order_by_cust(141,@shipped,@canceled,@resolved,@disputed);
SELECT @shipped,@canceled,@resolved,@disputed;
#
#########################################
# Criando Funções armazenadas
# https://www.mysqltutorial.org/mysql-stored-function/
#########################################
DELIMITER $$
CREATE FUNCTION CustomerLevel(
	credit DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE customerLevel VARCHAR(20);

    IF credit > 50000 THEN
		SET customerLevel = 'PLATINUM';
    ELSEIF (credit >= 50000 AND 
			credit <= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF credit < 10000 THEN
        SET customerLevel = 'SILVER';
    END IF;
	-- return the customer level
	RETURN (customerLevel);
END$$
DELIMITER ;
#
# Chamando a função no comando select
#
SELECT 
    customerName, 
    CustomerLevel(creditLimit)
FROM
    customers
ORDER BY 
    customerName;
#
########################################################
# Chamando uma função armazenada em uma stored procedure
########################################################
DELIMITER $$
CREATE PROCEDURE GetCustomerLevel3(
    IN  customerNo INT,  
    OUT customerLevel VARCHAR(20)
)
BEGIN
	DECLARE credit DEC(10,2) DEFAULT 0;
    -- get credit limit of a customer
    SELECT 
		creditLimit 
	INTO credit
    FROM customers
    WHERE 
		customerNumber = customerNo;
    -- call the function 
    SET customerLevel = CustomerLevel(credit);
END$$
DELIMITER ;
#
#####
CALL GetCustomerLevel3(-131,@customerLevel);
SELECT @customerLevel;
