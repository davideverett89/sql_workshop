-- This view is so that all vehicle information can be pulled together all at once without having to alwasy write a complex query.

CREATE VIEW full_vehicle_info AS
	SELECT
		v.vehicle_id,
		v.vin,
		v.engine_type,
		v.exterior_color,
		v.interior_color,
		v.floor_price,
		v.msr_price,
		v.miles_count,
		v.year_of_car,
		v.is_sold,
		v.is_new,
		vm.name "Make",
		vmd.name "Model",
		vbt.name "Body Type",
		d.business_name "Dealership"
	FROM vehicles v
	JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
	JOIN vehiclemakes vm ON vm.vehicle_make_id = vt.vehicle_make_id
	JOIN vehiclemodels vmd ON vmd.vehicle_model_id = vt.vehicle_model_id
	JOIN vehiclebodytypes vbt ON vbt.vehicle_body_type_id = vt.vehicle_body_type_id
	JOIN dealerships d ON d.dealership_id = v.dealership_id;
	
SELECT * FROM full_vehicle_info;

SELECT COUNT(*)
FROM vehicles;

CREATE INDEX vehicle_index
ON vehicles (vehicle_id);

CREATE INDEX vehicle_type_index
ON vehicletypes (vehicle_type_id);

CREATE INDEX sales_purchase_date_idx
ON sales (purchase_date);

SELECT * FROM sales
WHERE purchase_date = '2017-04-30';

SELECT * FROM accountsreceivable;

SELECT COUNT(*), purchase_date "DATE"
FROM sales
GROUP BY purchase_date
ORDER BY purchase_date ASC;

-- Created indexes for sales and vehicles.
-- Performance wasn't affected too much, but might be more noticiable with millions of rows.

CREATE VIEW dealership_roster AS
	SELECT
		d.business_name "Dealership",
		e.first_name "First Name",
		e.last_name "Last Name",
		e.email_address "Email",
		e.phone "Phone Number"
	FROM dealerships d
	JOIN dealershipemployees de ON de.dealership_id = d.dealership_id
	JOIN employees e ON e.employee_id = de.employee_id
	ORDER BY "Dealership", "Last Name";
	
SELECT * FROM dealership_roster;

CREATE VIEW employee_sales_performance AS
	SELECT
		e.first_name || ' ' || e.last_name "Employee Name",
		e.email_address "Email",
		e.phone "Phone Number",
		s.invoice_number "Invoice Number",
		s.payment_method "Payment Method",
		s.purchase_date "Sale Date",
		s.price "Purchase Price",
		v.vin "VIN"
	FROM employees e
	JOIN sales s ON s.employee_id = e.employee_id
	JOIN vehicles v ON v.vehicle_id = s.vehicle_id
	ORDER BY "Employee Name";

SELECT * FROM employee_sales_performance;

CREATE VIEW employee_sales_performance_nums AS
	SELECT
		e.first_name || ' ' || e.last_name "Employee Name",
		e.email_address "Email",
		e.phone "Phone Number",
		COUNT(s.invoice_number) "Number of Sales"
	FROM employees e
	JOIN sales s ON s.employee_id = e.employee_id
	GROUP BY "Employee Name", "Email", "Phone Number"
	ORDER BY "Number of Sales" DESC, "Employee Name" ASC;
	
SELECT * FROM employee_sales_performance_nums;