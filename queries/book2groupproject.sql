-- Who are the top 5 employees for generating sales income?

SELECT
	e.first_name || ' ' || e.last_name employee,
	SUM(s.price) AS "Total Sales"
FROM employees e
JOIN sales s ON s.employee_id = e.employee_id
GROUP BY employee
ORDER BY "Total Sales" DESC
LIMIT 5;

-- Who are the top 5 dealership for generating sales income?

SELECT
	d.business_name,
	SUM(s.price) AS "Total Sales"
FROM dealerships d
JOIN sales s ON s.dealership_id = d.dealership_id
GROUP BY d.business_name
ORDER BY "Total Sales" DESC
LIMIT 5;

-- Which vehicle model generated the most sales income?

SELECT
	vm.name AS "Model",
	SUM(price) AS "Total Sales"
FROM vehiclemodels vm
JOIN vehicletypes vt ON vt.vehicle_model_id = vm.vehicle_model_id
JOIN vehicles v ON v.vehicle_type_id = vt.vehicle_type_id
JOIN sales s ON s.vehicle_id = v.vehicle_id
GROUP BY "Model"
ORDER BY "Total Sales" DESC
LIMIT 1;

-- Which employees generate the most income per dealership?

SELECT
	e.first_name || ' ' || e.last_name employee,
	d.business_name business,
	CAST(SUM(s.price) AS money) total_sales
FROM sales s
INNER JOIN dealerships d ON s.dealership_id = d.dealership_id
INNER JOIN dealershipemployees de ON s.employee_id = de.employee_id
INNER JOIN employees e ON e.employee_id = de.employee_id
GROUP BY employee, business
ORDER BY total_sales DESC;

