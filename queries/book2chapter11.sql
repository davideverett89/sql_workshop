--What are the top 5 US states with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?

SELECT
	c.state AS "State",
	COUNT(s.sale_id) AS "Number of Sales per State",
	SUM(s.price) AS "Total Sales"
FROM customers c
JOIN sales s ON s.customer_id = c.customer_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.name = 'Purchase'
GROUP BY "State"
ORDER BY "Number of Sales per State" DESC
LIMIT 5;

--What are the top 5 US zipcodes with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?

SELECT
	c.zipcode AS "Zip Code",
	COUNT(s.sale_id) AS "Number of Sales per Zip Code",
	SUM(s.price) AS "Total Sales"
FROM customers c
JOIN sales s ON s.customer_id = c.customer_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.name = 'Purchase'
GROUP BY "Zip Code"
ORDER BY "Number of Sales per Zip Code" DESC
LIMIT 5;

--What are the top 5 dealerships with the most customers?

SELECT
	d.business_name AS "Dealership",
	COUNT(c.customer_id) AS "Number of Customers",
	SUM(s.price) AS "Total Sales"
FROM dealerships d
JOIN sales s ON s.dealership_id = d.dealership_id
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY "Dealership"
ORDER BY "Number of Customers" DESC
LIMIT 5;