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

-- Which model of vehicle has the lowest current inventory? 
-- This will help dealerships know which models the purchase from manufacturers.

SELECT
	vm.name AS "Model",
	COUNT(v.vehicle_id) AS "Number in Stock"
FROM vehiclemodels vm
JOIN vehicletypes vt ON vt.vehicle_model_id = vm.vehicle_model_id
JOIN vehicles v ON v.vehicle_type_id = vt.vehicle_type_id
GROUP BY vm.name
ORDER BY "Number in Stock" ASC
LIMIT 1;

-- Which model of vehicle has the highest current inventory? 
-- This will help dealerships know which models are, perhaps, not selling.

SELECT
	vm.name AS "Model",
	COUNT(v.vehicle_id) AS "Number in Stock"
FROM vehiclemodels vm
JOIN vehicletypes vt ON vt.vehicle_model_id = vm.vehicle_model_id
JOIN vehicles v ON v.vehicle_type_id = vt.vehicle_type_id
GROUP BY vm.name
ORDER BY "Number in Stock" DESC
LIMIT 1;

-- Which dealerships are currently selling the least number of vehicle models? 
-- This will let dealerships market vehicle models more effectively per region.

SELECT
	d.business_name AS "Business Name",
	COUNT(vm.vehicle_model_id) AS "Models Sold"
FROM dealerships d
JOIN sales s ON s.dealership_id = d.dealership_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclemodels vm ON vt.vehicle_model_id = vm.vehicle_model_id
GROUP BY "Business Name"
ORDER BY "Models Sold" ASC;

-- Which dealerships are currently selling the highest number of vehicle models? 
-- This will let dealerships know which regions have either a high population, or less brand loyalty.

SELECT
	d.business_name AS "Business Name",
	COUNT(vm.vehicle_model_id) AS "Models Sold"
FROM dealerships d
JOIN sales s ON s.dealership_id = d.dealership_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclemodels vm ON vt.vehicle_model_id = vm.vehicle_model_id
GROUP BY "Business Name"
ORDER BY "Models Sold" DESC;

