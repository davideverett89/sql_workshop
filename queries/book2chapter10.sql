-- How many emloyees are there for each role?

SELECT
	et.name AS "Role",
	COUNT(e.employee_id) AS "Number of Employees"
FROM employeetypes et
JOIN employees e ON e.employee_type_id = et.employee_type_id
GROUP BY "Role"
ORDER BY "Number of Employees" DESC;

-- How many finance managers work at each dealership?

SELECT
	d.business_name AS "Business Name",
	COUNT(et.name) AS "Number of Finance Managers"
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
JOIN employees e ON de.employee_id = e.employee_id
JOIN employeetypes et ON e.employee_type_id = et.employee_type_id
WHERE et.name = 'Finance Manager'
GROUP BY "Business Name"
ORDER BY "Number of Finance Managers" DESC;

-- Get the names of the top 3 employees who work shifts at the most dealerships?

SELECT
	e.employee_id,
	e.first_name || ' ' || e.last_name AS "Employee Name",
	COUNT(d.business_name) AS "Number of Places Worked"
FROM employees e
JOIN dealershipemployees de ON de.employee_id = e.employee_id
JOIN dealerships d ON de.dealership_id = d.dealership_id
GROUP BY e.employee_id, "Employee Name"
ORDER BY "Number of Places Worked" DESC
LIMIT 3;

-- Get a report on the top two employees who has made the most sales through leasing vehicles.

SELECT
	e.first_name || ' ' || e.last_name AS "Employee Name",
	SUM(s.price) AS "Total Income",
	COUNT(s.sale_id) AS "Number of Transactions"
FROM employees e
JOIN sales s ON s.employee_id = e.employee_id
GROUP BY "Employee Name"
ORDER BY "Number of Transactions" DESC
LIMIT 2;