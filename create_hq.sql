use Headquarters;

create table suppliers (
	code int primary key  ,
	nome char(50) NOT NULL,
	address char(100) NOT NULL
);

create table products (
	code int primary key,
	supplier_code int FOREIGN KEY REFERENCES suppliers(code),
	min_stock int,
	order_state boolean,
	order_quantity int
); 