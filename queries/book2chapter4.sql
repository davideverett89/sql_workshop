-- Produce a report that lists every dealership, the number of purchases done by each, and the number of leases done by each.

SELECT
	d.business_name AS "Business Name",
	COUNT(CASE WHEN st.name = 'Lease' THEN st.name END) AS "Number of Leases",
	COUNT(CASE WHEN st.name = 'Purchase' THEN st.name END) AS "Number of Purchases"
FROM dealerships d
LEFT JOIN sales s ON s.dealership_id = d.dealership_id
JOIN salestypes st ON s.sales_type_id = st.sales_type_id
GROUP BY d.business_name;

-- Produce a report that determines the most popular vehicle model that is leased.

SELECT
	v.year_of_car AS "Year",
	vm.name AS "Make",
	vmd.name AS "Model",
	vbt.name AS "Body Type",
	v.vin AS "VIN",
	v.engine_type AS "Engine Type",
	Count(*) AS "Number of Sales"
FROM vehicles v
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclemakes vm ON vt.vehicle_make_id = vm.vehicle_make_id
JOIN vehiclemodels vmd ON vt.vehicle_model_id = vmd.vehicle_model_id
JOIN vehiclebodytypes vbt ON vt.vehicle_body_type_id = vbt.vehicle_body_type_id
JOIN sales s ON s.vehicle_id = v.vehicle_id
GROUP BY v.year_of_car, v.vin, v.engine_type, vm.name, vmd.name, vbt.name
ORDER BY "Number of Sales" DESC;

-- What is the most popular vehicle make in terms of number of sales?



	