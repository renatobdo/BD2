####################### Procedimento armazenado que utiliza variáveis ################################
DELIMITER // 
CREATE PROCEDURE test() 
BEGIN 
    DECLARE max_invoice_total DECIMAL (9, 2);
    DECLARE min_invoice_total DECIMAL (9, 2);
    DECLARE percent_difference DECIMAL (9, 2);
    DECLARE count_invoice_id INT;
    DECLARE vendor_id_var INT;
    SET     vendor_id_var = 95;
    SELECT MAX(invoice_total),
           MIN(invoice_total),
           COUNT(invoice_id) INTO max_invoice_total,
           min_invoice_total,
           count_invoice_id
    FROM   invoices
    WHERE  vendor_id = vendor_id_var;
    SET percent_difference = (max_invoice_total - min_invoice_total) / min_invoice_total * 100;
    SELECT CONCAT('$', max_invoice_total) AS 'Maximum invoice',
           CONCAT('$', min_invoice_total) AS 'Minimum invoice',
           CONCAT(' % ', ROUND (percent_difference, 2 ) ) AS ' Percent difference ',
           count_invoice_id AS ' Number of invoices ';
END//

###################Procedimentos armazenados com IFs ############################################
DELIMITER // 
CREATE PROCEDURE test2() 
BEGIN 
    DECLARE first_invoice_due_date DATE;
    SELECT  MIN(invoice_due_date) INTO first_invoice_due_date
    FROM invoices
    WHERE invoice_total - payment_total - credit_total > 0;

    IF first_invoice_due_date < NOW() THEN
    -- 'outstanding invoices are overdue!'
        SELECT 'faturas pendentes estão atrasadas!';
    ELSEIF first_invoice_due_date = NOW() THEN
    -- 'outstanding invoices are due today!'
        SELECT 'faturas pendentes vencem hoje!';
    ELSE
    -- No invoices are overdue.
        SELECT 'Nenhuma fatura está vencida.';
	END IF;
END//
call test2();

#################Procedimentos armazenados que utilizam CASE #####################################
DELIMITER //
CREATE PROCEDURE test3()
BEGIN
    DECLARE terms_id_var INT;
    SELECT terms_id INTO terms_id_var
    FROM invoices WHERE invoice_id = 4;
    CASE terms_id_var
        WHEN 1 THEN
            SELECT 'Net due 10 days' AS Terms;
        WHEN 2 THEN
            SELECT 'Net due 20 days' AS Terms;
        WHEN 3 THEN
        -- Líquido devido 30 dias
            SELECT 'Net due 30 days' AS Terms;
        ELSE
            SELECT 'Net due more tha.n 3 0 days ' AS Terms;
    END CASE;
END//
call test3();
####################### Procedimentos que utilizam WHILE loop ####################################

DELIMITER //
CREATE PROCEDURE test4( )
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE s VARCHAR(400) DEFAULT '';
    WHILE i < 4 DO
        SET s = CONCAT(s, 'i=',i, ' | ');
        SET i = i + 1;
    END WHILE;
    SELECT s AS message;
END//
call test4();
############ outras possiblidade de se utilizar o LOOP #############################################
-- A REPEAT loop
    REPEAT        
        SET s = CONCAT ( s, 'i= ', i, ' | ' ) ;
        SET i = i + 1;
    UNTIL i = 4;
    END REPEAT;

-- A simple loop
    testLoop: LOOP
        SET s = CONCAT(s, 'i=', i, ' | ');
        SET i = i + 1;
        IF i = 4 THEN
            LEAVE testLoop;
        END IF;
    END LOOP testLoop;  
