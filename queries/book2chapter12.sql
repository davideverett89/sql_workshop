-- Create a view that lists all vehicle body types, makes and models.ABORT-- Create a view that lists all vehicle body types, makes and models.

CREATE VIEW vehicle_list AS
	SELECT
		v.vin AS "Vin",
		vbt.name AS "Body Type",
		vm.name AS "Make",
		vmd.name AS "Model",
		v.engine_type
	FROM vehicles v
	JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
	JOIN vehiclebodytypes vbt ON vt.vehicle_body_type_id = vbt.vehicle_body_type_id
	JOIN vehiclemakes vm ON vt.vehicle_make_id = vm.vehicle_make_id
	JOIN vehiclemodels vmd ON vt.vehicle_model_id = vmd.vehicle_model_id;
	
SELECT * FROM vehicle_list;

-- Create a view that shows the total number of employees for each employee type.

SELECT * FROM employeetypes;


CREATE VIEW employees_per_type AS
	SELECT
		et.name AS "Employee Type",
		COUNT(e.employee_id) AS "Number of Employees"
	FROM employeetypes et
	JOIN employees e ON e.employee_type_id = et.employee_type_id
	GROUP BY "Employee Type"
	ORDER BY "Number of Employees" DESC;
	
SELECT * FROM employees_per_type;

-- Create a view that lists all customers without exposing their emails, phone numbers and street address.

CREATE VIEW all_customers AS
	SELECT
		c.customer_id,
		c.first_name || ' ' || c.last_name AS "Customer Name",
		c.city || ', ' || c.state || ' ' || c.zipcode AS "Location",
		c.company_name
	FROM customers c;
	
SELECT * FROM all_customers;

-- Create a view named sales2018 that shows the total number of sales for each sales type for the year 2018.
-- Create a view that shows the employee at each dealership with the most number of sales.