-- Lấy ra dữ liệu của bảng SAles.customers có Custumer_Id
SELECT * FROM sales.customers WHERE customer_id >= 100 AND customer_id <= 200
-- Lấy ra dl của bảng sales.customers có custumer_id trong khoảng[100, 200]
SELECT * FROM sales.customers WHERE customer_id BETWEEN 100 AND 200
-- Lấy ra những customer có last_name kếtthucs bởi kí tự e
SELECT * FROM sales.customers WHERE last_name LIKE '%e'
-- Lấy ra những customer  có last_name bắt đầu bởi kí tự R hoặc A kthuc bằng e
SELECT * FROM sales.customers WHERE last_name LIKE '[RA]%e'
-- Lấy những customer cố last name có 4 kí tự bắt đầu bởi kí tự R or A kthuc bơi kí tự e
SELECT * FROM sales.customers WHERE last_name LIKE '[RA]__e'
-- Sử dụng INNER JOIN
SELECT  sales.customers. *
FROM sales.customers INNER JOIN sales.orders ON
     sales.customers.customer_id=sales.orders.customer_id
SELECT customer_id, COUNT(*) [customer_id]
FROM sales.orders
WHERE customer_id LIKE '1%'
GROUP BY ALL customer_id
-- GROUP BY với HAVING : mệnh đề HAVING sẽ lọc kết quả trong lúc đc gộp nhóm
SELECT customer_id, COUNT(order_id) orders,YEAR(order_date) Year_order
FROM sales.orders -- WHERE customer_id IN (1, 4, 7, 99)
GROUP BY customer_id, Year(order_date)
ORDER BY customer_id
-- Lay ra sanr pham thuoc brand nao
SELECT product_name, brand_name
FROM production.products INNER JOIN production.brands ON
     production.products.brand_id = production.brands.brand_id
-- lấy ra sản phảm tên là gid , do ai bán , tên người mua
SELECT product_name,c.first_name Customer_firstName, c.last_name Customer_lastName,  s.first_name Staff_firstName, s.last_name Staff_lastName
	FROM sales.customers c
	INNER JOIN sales.orders o ON o.customer_id = c.customer_id
	INNER JOIN sales.order_items i ON i.order_id = o.order_id
	INNER JOIN sales.staffs s ON s.staff_id = o.staff_id
	INNER JOIN production.products p ON p.product_id = i.product_id
GO	
-- JOIN AND GROUP BY
SELECT brand_name,
MAX(list_price) max_price,
MIN(list_price) min_price
FROM production.products p 
JOIN production.brands b ON b.brand_id = p.brand_id
WHERE model_year = '2016'
GROUP BY brand_name
ORDER BY brand_name

-- Nhóm theo tên sản phẩm
SELECT product_name
FROM production.products
WHERE model_year = '2018'
GROUP BY product_name
ORDER BY product_name
-- EXEC sp_help production.brands
SELECT
product_name,
i.list_price price_order,
p.list_price price_product
FROM production.products p 
JOIN sales.order_items i ON p.category_id = i.product_id