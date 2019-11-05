create synonym hq_products for [DESKTOP-LSM7R1H\SQL_ASI_1].Headquarters.dbo.products
create synonym child_products for [DESKTOP-LSM7R1H\SQL_ASI_2].Child_store.dbo.products

--select *from hq_products, child_products where order_state = 0;

BEGIN DISTRIBUTED TRAN


--if exists (select code,min_stock from hq_products  where order_state = 0 AND child_products.stock < min_stock)
--select code,min_stock from hq_products INNER JOIN test on 

BEGIN
	SELECT 

	ROLLBACK  TRAN
