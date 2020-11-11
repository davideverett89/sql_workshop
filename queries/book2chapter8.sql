-- Write a query that shows the total purchase sales income per dealership.

SELECT
	d.business_name AS "Business Name",
	st.name AS "Sales Type",
	SUM(s.price) AS "Total Sales:"
FROM dealerships d
LEFT JOIN sales s ON s.dealership_id = d.dealership_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.name = 'Purchase'
GROUP BY d.business_name, st.name
ORDER BY "Total Sales:" DESC;

-- Write a query that shows the purchase sales income per dealership for the current month.

SELECT
	d.business_name AS "Business Name",
	st.name AS "Sales Type",
	SUM(s.price) AS "Total Sales:"
FROM dealerships d
LEFT JOIN sales s ON s.dealership_id = d.dealership_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.name = 'Purchase' AND (SELECT date_part('month', (SELECT current_timestamp))) = 11
GROUP BY d.business_name, st.name
ORDER BY "Total Sales:" DESC;