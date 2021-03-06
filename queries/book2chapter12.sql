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

CREATE VIEW sales2018 AS
	SELECT
		st.name AS "Sales Type",
		COUNT(s.sale_id) AS "Number of Transactions in 2018",
		CAST(SUM(s.price) AS money) AS "Total Sales in 2018"
	FROM salestypes st
	JOIN sales s ON s.sales_type_id = st.sales_type_id
	WHERE s.purchase_date::text LIKE '2018%'
	GROUP BY "Sales Type"
	ORDER BY "Number of Transactions in 2018" DESC;
	
-- Drop the view so it can be reset and reflect changes
DROP VIEW IF EXISTS sales2018;

SELECT * FROM sales2018;

-- Create a view that shows the employee at each dealership with the most number of sales.
-- TO BE CONTINUED....
CREATE VIEW star_employee AS
	SELECT
		d.business_name AS "Business Name",
		e.first_name || ' ' || e.last_name AS "Employee Name",
		COUNT(s.sale_id) AS "Number of Sales",
		CAST(SUM(s.price) AS money) AS "Total Earned"
	FROM dealerships d
	LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
	JOIN employees e ON e.employee_id = de.employee_id
	JOIN sales s ON s.employee_id = e.employee_id
	GROUP BY "Business Name", "Employee Name"
	ORDER BY "Number of Sales" DESC;