## Cópia de backup porque deu erro ao alterar a tabela 

create table order_items_backup(
	order_item_id BIGINT,
    created_at DATETIME,
    order_id BIGINT,
    price_usd DECIMAL(6,2),
    cogs_usd DECIMAL(6,2),
    website_session_id BIGINT,
    primary key (order_item_id),
    constraint foreign key fk_product_id (product_id) 
    references
		products(product_id)
);


alter table order_items_backup add product_id int;


alter table order_items_backup add is_primary_item int;

insert into order_items_backup (
order_item_id, created_at, 
order_id, price_usd, cogs_usd, 
website_session_id, product_id, is_primary_item
)

select * from order_items;


drop table order_items;


create table order_items(
	order_item_id BIGINT,
    created_at DATETIME,
    order_id BIGINT,
    price_usd DECIMAL(6,2),
    cogs_usd DECIMAL(6,2),
    website_session_id BIGINT,
    product_id int,
    primary key (order_item_id),
    constraint foreign key  (product_id) 
    references
		products(product_id)
);


alter table order_items add product_id int;

alter table order_items add is_primary_item int;


insert into order_items (
order_item_id, created_at, 
order_id, price_usd, cogs_usd, 
website_session_id, product_id, is_primary_item
)

select * from order_items_backup;
