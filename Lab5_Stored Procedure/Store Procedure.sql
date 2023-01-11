USE FptAptechBikeStore
DROP PROCEDURE if EXISTS Display_Customers
CREATE PROCEDURE Display_Customers
AS
SELECT customer_id, first_name, last_name, phone
FROM sales.customers

EXECUTE Display_Customers-- hien thi du lieu

EXECUTE xp fileexist ''

EXECUTE sys.sp_who-- luu tru he thong