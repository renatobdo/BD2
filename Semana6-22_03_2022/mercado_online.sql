create schema mercado_online;

use mercado_online;

create table order_items(
	order_item_id BIGINT,
    created_at DATETIME,
    order_id BIGINT,
    price_usd DECIMAL(6,2),
    cogs_usd DECIMAL(6,2),
    website_session_id BIGINT,
    primary key (order_item_id)
)
## REALIZE A IMPORTAÇÃO DOS ARQUIVOS order_items.csv NA TABELA order_items. UTILIZE A FERRAMENTA DO WORKBENCH TABLE DATA IMPORT WIZARD.

select MIN(created_at),
MAX(created_at) from order_items;


create table order_item_refunds(
	order_item_refund_id BIGINT,
    created_at DATETIME,
    order_item_id BIGINT,
    order_id BIGINT,
    refund_amount_usd DECIMAL(6,2),
    PRIMARY KEY (order_item_refund_id),
    FOREIGN KEY (order_item_id) REFERENCES order_items
		(order_item_id));

## REALIZE A IMPORTAÇÃO DOS ARQUIVOS order_item_refunds.csv NA TABELA order_item_refunds. UTILIZE A FERRAMENTA DO WORKBENCH TABLE DATA IMPORT WIZARD.

select * from order_item_refunds;

## O que acontece no comando DELETE ABAIXO ?
delete from order_item_refunds where created_at > '2012-04-23';

###
Error Code: 1175. You are using safe update mode and you tried 
to update a table without a WHERE that uses a KEY column.  
To disable safe mode, toggle the option in Preferences -> SQL Editor and 
reconnect.	0.000 sec

delete from order_item_refunds where order_item_refund_id between 6 and 10;
