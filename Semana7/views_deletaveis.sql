#referência: https://www.mysqltutorial.org/create-sql-updatable-views.aspx
-- create a new table named items
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(11 , 2 ) NOT NULL
);

-- insert data into the items table
INSERT INTO items(name,price) 
VALUES('Laptop',700.56),('Desktop',699.99),('iPad',700.50) ;

-- create a view based on items table
CREATE VIEW LuxuryItems AS
    SELECT 
        *
    FROM
        items
    WHERE
        price > 700;
-- query data from the LuxuryItems view
SELECT 
    *
FROM
    LuxuryItems;
    
DELETE FROM LuxuryItems 
WHERE
    id = 3;

SELECT 
    *
FROM
    LuxuryItems;
# depois desse último select perceberemos que a linha com id = 3 foi removida da tabela base
SELECT 
    *
FROM
    items;