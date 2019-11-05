--use child_store;
--use sports_store;

create table products (
	code int primary key,
	price float NOT NULL,
	stock int,
	prod_type char(15) NOT NULL,
);

--select * from products;