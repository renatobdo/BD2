## brecho
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

CREATE SCHEMA brecho;
USE brecho;

CREATE TABLE inventory (
  inventory_id BIGINT UNSIGNED NOT NULL,
  item_name VARCHAR(50),
  number_in_stock BIGINT,
  PRIMARY KEY (inventory_id)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

INSERT INTO inventory VALUES
(1,'fur coat',1),
(2,'mocassins',4),
(3,'velour jumpsuit',12),
(4,'house slippers',6),
(5,'brown leather jacket',3),
(6,'broken keyboard',6),
(7,'ski blanket',1),
(8,'kneeboard',2),
(9,'pro wings sneakers',2)
;
COMMIT; 

CREATE TABLE customers (
  customer_id BIGINT UNSIGNED NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

INSERT INTO customers VALUES
(1, 'Mack', 'Lewis'),
(2, 'Ryan', 'More'),
(3, 'Brooklyn', 'Haggerty'),
(4, 'Tim', 'Grinnell'),
(5, 'Ray', 'Bridwell'),
(6, 'Ben', 'Dalton')
;
COMMIT;

CREATE TABLE customer_purchases (
  customer_purchase_id BIGINT UNSIGNED NOT NULL,
  customer_id BIGINT UNSIGNED NOT NULL,
  inventory_id BIGINT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

INSERT INTO customer_purchases VALUES
(1, 1, 3),
(2, 1, 2),
(3, 1, 4),
(4, 1, 7),
(5, 2, 5),
(6, 3, 1),
(7, 4, 6),
(8, 5, 8),
(9, 6, 9),
(10, 2, 3),
(11, 1, 2),
(12, 1, 6)
; 
COMMIT; 

CREATE TABLE purchase_summary (
  purchase_summary_id BIGINT UNSIGNED NOT NULL,
  customer_id BIGINT UNSIGNED NOT NULL,
  total_purchases BIGINT UNSIGNED NOT NULL,
  purchase_excluding_last BIGINT UNSIGNED NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

INSERT INTO purchase_summary VALUES
(1, 1, 6, 5),
(2, 2, 2, 1),
(3, 3, 1, 0),
(4, 4, 1, 0),
(5, 5, 1, 0),
(6, 6, 1, 0)
; 
COMMIT; 
