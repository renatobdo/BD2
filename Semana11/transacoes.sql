###############################################################
# Transações
#https://www.mysqltutorial.org/mysql-transaction.aspx 
###############################################################
-- 1. start a new transaction
START TRANSACTION;

-- 2. Get the latest order number
SELECT 
    @orderNumber:=MAX(orderNUmber)+1
FROM
    orders;

-- 3. insert a new order for customer 145
INSERT INTO orders(orderNumber,
                   orderDate,
                   requiredDate,
                   shippedDate,
                   status,
                   customerNumber)
VALUES(@orderNumber,
       '2005-05-31',
       '2005-06-10',
       '2005-06-11',
       'In Process',
        145);
        
-- 4. Insert order line items
INSERT INTO orderdetails(orderNumber,
                         productCode,
                         quantityOrdered,
                         priceEach,
                         orderLineNumber)
VALUES(@orderNumber,'S18_1749', 30, '136', 1),
      (@orderNumber,'S18_2248', 50, '55.09', 2); 
      
-- 5. commit changes    
COMMIT;

##
##
SELECT 
    a.orderNumber,
    orderDate,
    requiredDate,
    shippedDate,
    status,
    comments,
    customerNumber,
    orderLineNumber,
    productCode,
    quantityOrdered,
    priceEach
FROM
    orders a
        INNER JOIN
    orderdetails b USING (orderNumber)
WHERE
    a.ordernumber = 10426;
    
### ROLLBACK
start transaction;
delete from orders;
#https://stackoverflow.com/questions/1905470/cannot-delete-or-update-a-parent-row-a-foreign-key-constraint-fails
SET FOREIGN_KEY_CHECKS=0;
-- SET FOREIGN_KEY_CHECKS=0; -- to disable them
-- SET FOREIGN_KEY_CHECKS=1; -- to re-enable them
select count(*) from orders;
rollback;
select connection_id();

show variables like '%isolation%';
