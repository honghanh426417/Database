USE FptAptechBikeStore
SELECT product_name, list_price 
FROM production.products where brand_id 
IN (SELECT brand_id
      FROM production.brands
      WHERE brand_name LIKE 'Electra')

-- Subquery with ANY : TRUE OR FALSE
SELECT * FROM production.products
WHERE list_price = ANY(SELECT  list_price from production.products where list_price > 1000)

-- check subquery with EXISTS or NOT EXISTS
SELECT * FROM sales.customers c
where not exists (select customer_id from sales.orders o where c.customer_id = o.customer_id AND YEAR(order_date)= 2018)
order BY first_name, last_name

--  Subquery in from (trong 1 câu lệnh select)
SELECT staff_id, COUNT (order_id) order_countid
FROM sales.orders
GROUP BY staff_id

SELECT
 AVG(order_countid) avg_order_countid
  FROM (SELECT staff_id, COUNT (order_id) order_countid
FROM sales.orders
GROUP BY staff_id) t;

-- Subquery in expression
SELECT  order_id,
        order_date, 
        (select max(list_price) 
           from sales.order_items i 
           Where i.order_id = o.order_id)
            as max_price
FROM sales.orders o 
order BY order_date DESC;

CREATE VIEW view_orderPrice
AS
   SELECT  order_id,
        order_date, 
        (select max(list_price) 
           from sales.order_items i 
           Where i.order_id = o.order_id)
            as max_price
FROM sales.orders o 
