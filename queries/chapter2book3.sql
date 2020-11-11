-- Get a list of the sales that were made for each sales type.
SELECT
	s.invoice_number,
	s.price,
	st.name
FROM sales s
RIGHT JOIN salestypes st ON s.sales_type_id = st.sales_type_id
ORDER BY st.name;

-- Get a list of sales with the VIN of the vehicle, 
-- the first name and last name of the customer, first name and last name of the employee.

SELECT
	s.invoice_number AS "Invoice Number",
	s.price AS "Sales Price",
	st.name AS "Sales Type",
	v.vin AS "VIN",
	c.first_name AS "Customer First Name",
	c.last_name AS "Customer Last Name",
	e.first_name AS "Employee First Name",
	e.last_name AS "Employee Last Name",
	d.business_name AS "Business Name",
	d.city AS "City",
	d.state AS "State"
FROM sales s
JOIN salestypes st ON st.sales_type_id = s.sales_type_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN customers c ON s.customer_id = c.customer_id
JOIN employees e ON s.employee_id = e.employee_id
JOIN dealerships d ON s.dealership_id = d.dealership_id;

-- Get a list of all the dealerships and the employees, if any, working at each one.
SELECT
	d.business_name AS "Business Name",
	d.phone AS "Business Phone Number",
	d.city AS "City of Operation",
	d.state AS "State",
	e.first_name AS "Employee First Name",
	e.last_name AS "Employee Last Name",
	e.email_address AS "Employee Email Address",
	e.phone AS "Employee Phone Number"
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
JOIN employees e ON de.employee_id = e.employee_id
ORDER BY d.business_name;

-- Get a list of vehicles with the names of the body type, make, model and color.

SELECT * FROM vehicletypes;

SELECT
	v.vin AS "VIN",
	v.msr_price AS "MSR Price",
	v.miles_count AS "Miles",
	v.year_of_car AS "Release Year",
	vbt.name AS "Body Type",
	vm.name AS "Make",
	vmd.name AS "Model",
	v.exterior_color AS "Color"
FROM vehicles v
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
JOIN vehiclebodytypes vbt ON vbt.vehicle_body_type_id = vt.vehicle_body_type_id
JOIN vehiclemakes vm ON vm.vehicle_make_id = vt.vehicle_make_id
JOIN vehiclemodels vmd ON vmd.vehicle_model_id = vt.vehicle_model_id;
	