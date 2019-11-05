use Headquarters;

insert into products (code, supplier_code, min_stock, order_state ) 
VALUES (100, 10, 5, false);

use child_store;

insert into products (code, price, stock, prod_type) 
VALUES (100, 10.99, 0, 'child');

