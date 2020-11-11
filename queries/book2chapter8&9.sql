-- Write a query that shows the purchase sales income per dealership for the current month.

SELECT
	d.business_name AS "Business Name",
	st.name AS "Sales Type",
	SUM(s.price) AS "Total Sales"
FROM dealerships d
LEFT JOIN sales s ON s.dealership_id = d.dealership_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.name = 'Purchase' AND s.purchase_date BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY "Business Name", "Sales Type"
ORDER BY "Total Sales" DESC;

-- Write a query that shows the purchase sales income per dealership for the current year.

SELECT
	d.business_name AS "Business Name",
	st.name AS "Sales Type",
	SUM(s.price) AS "Total Sales"
FROM dealerships d
LEFT JOIN sales s ON s.dealership_id = d.dealership_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.name = 'Purchase' AND s.purchase_date::text LIKE '2020%'
GROUP BY "Business Name", "Sales Type"
ORDER BY "Total Sales" DESC;

-- Write a query that shows the total income (purchase and lease) per employee.

SELECT
	e.employee_id,
	e.first_name,
	e.last_name,
	SUM(s.price)
FROM employees e
JOIN sales s ON s.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, s.price
ORDER BY s.price DESC;

-- Which model of vehicle has the lowest current inventory? This will help dealerships know which models the purchase from manufacturers.

