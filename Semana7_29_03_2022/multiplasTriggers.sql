## https://www.mysqltutorial.org/mysql-triggers/create-multiple-triggers-for-the-same-trigger-event-and-action-time/

CREATE TABLE PriceLogs (
    id INT AUTO_INCREMENT,
    productCode VARCHAR(15) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    updated_at TIMESTAMP NOT NULL 
			DEFAULT CURRENT_TIMESTAMP 
            ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (productCode)
        REFERENCES products (productCode)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


############### Criação da trigger BEFORE UPDATE ################################
DELIMITER $$

CREATE TRIGGER tgr_before_products_update 
   BEFORE UPDATE ON products 
   FOR EACH ROW 
BEGIN
     IF OLD.msrp <> NEW.msrp THEN
         INSERT INTO PriceLOgs(product_code,price)
         VALUES(old.productCode,old.msrp);
     END IF;
END$$

DELIMITER ;

#########################################
# Verificando o preço do produto S12_1099
#########################################
SELECT 
    productCode, 
    msrp 
FROM 
    products
WHERE 
    productCode = 'S12_1099';
 
#######################################
# Atualizando o valor de um campo
#####################
UPDATE products
SET msrp = 200
WHERE productCode = 'S12_1099';


######################
#Deverá funcionar conforme previsto
############################
SELECT * FROM PriceLogs;

###########################
# Criando outra tabela para armazenar dados do usuário
###########################
CREATE TABLE UserChangeLogs (
    id INT AUTO_INCREMENT,
    productCode VARCHAR(15) DEFAULT NULL,
    updatedAt TIMESTAMP NOT NULL 
	DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP,
    updatedBy VARCHAR(30) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (productCode)
        REFERENCES products (productCode)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
##########################################
## Criando a triggers
###########################################
DELIMITER $$

CREATE TRIGGER before_products_update_log_user
   BEFORE UPDATE ON products 
   FOR EACH ROW 
   FOLLOWS before_products_update
BEGIN
    IF OLD.msrp <> NEW.msrp THEN
	INSERT INTO 
            UserChangeLogs(productCode,updatedBy)
        VALUES
            (OLD.productCode,USER());
    END IF;
END$$

DELIMITER ;

####################################
## Testando
######################################
UPDATE 
    products
SET 
    msrp = 220
WHERE 
    productCode = 'S12_1099';
    
##### Verificando ###################
SELECT * FROM PriceLogs;
SELECT * FROM UserChangeLogs;

