-- Produce a report that determines the most popular vehicle model that is leased.

SELECT
	vmd.name AS "Model",
	st.name AS "Sales Type",
	Count (s.sale_id) AS "Number of Sales"
FROM vehiclemodels vmd
JOIN vehicletypes vt ON vt.vehicle_model_id = vmd.vehicle_model_id
JOIN vehicles v ON vt.vehicle_type_id = v.vehicle_type_id
LEFT JOIN sales s ON v.vehicle_id = s.vehicle_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.name = 'Lease'
GROUP BY vmd.name, st.name
ORDER BY "Number of Sales" DESC
LIMIT 1;

-- What is the most popular vehicle make in terms of number of sales?

SELECT
	vm.vehicle_make_id,
	vm.name,
	COUNT(s.sale_id) AS "Number of Sales"
FROM vehiclemakes vm
JOIN vehicletypes vt ON vt.vehicle_make_id = vm.vehicle_make_id
JOIN vehicles v ON v.vehicle_type_id = vt.vehicle_type_id
JOIN sales s ON s.vehicle_id = v.vehicle_id
GROUP BY vm.name, vm.vehicle_make_id
ORDER BY "Number of Sales" DESC
LIMIT 1;

-- Which employee type sold the most of that make?
SELECT
	et.name AS "Employee Type",
	vm.name AS "Make",
	COUNT(s.sale_id) AS "Number of Units Sold"
FROM employeetypes et
JOIN employees e ON e.employee_type_id = et.employee_type_id
LEFT JOIN sales s ON s.employee_id = e.employee_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclemakes vm ON vt.vehicle_make_id = vm.vehicle_make_id
WHERE vm.vehicle_make_id = 3
GROUP BY et.name, vm.name
ORDER BY "Number of Units Sold" DESC
LIMIT 1;
