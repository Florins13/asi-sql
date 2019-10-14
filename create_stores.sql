--use child_store;
--use sports_store;

create table products (
	code int primary key,
	price float NOT NULL,
	stock int,
	prod_type char(15) NOT NULL,
	prod_state char(15)
);

--select * from products;