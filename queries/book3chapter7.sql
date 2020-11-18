-- Write a transaction to:
-- Add a new role for employees called Automotive Mechanic
-- Add five new mechanics, their data is up to you
-- Each new mechanic will be working at all three of these dealerships: Meeler Autos of San Diego, Meadley Autos of California and Major Autos of Florida
  
BEGIN;
DECLARE
	employeeTypeId int;
	employeeID1 int;
	employeeID2 int;
	employeeID3 int;
INSERT INTO employeetypes
(name)
VALUES 'Automotive Mechanic'
RETURNING employee_type_id INTO employeeTypeId;

INSERT INTO employees
(first_name, last_name, email_address, phone, employee_type_id)
VALUES 
('David', 'Everett', 'davideverett1989@gmail.com', '21734341348', employeeTypeId)
('Tanner', 'Brainard', 'tanner@tanner.com', '5654556778', employeeTypeId)
('Anupama', 'Garg', 'anapuma@garg.com', '4445334556', employeeTypeId);

employeeID1 = (SELECT
	employee_id
FROM employees
WHERE email_address = 'davideverett1989@gmail.com');

employeeID2 = (SELECT
	employee_id
FROM employees
WHERE email_address = 'tanner@tanner.com');

employeeID3 = (SELECT
	employee_id
FROM employees
WHERE email_address = 'anapuma@garg.com');

INSERT INTO dealershipemployees
(dealership_id, employee_id)
SELECT d.dealership_id, employeeID1
FROM dealerships d
WHERE d.business_name = 'Meeler Autos of San Diego';

INSERT INTO dealershipemployees
(dealership_id, employee_id)
SELECT d.dealership_id, employeeID1
FROM dealerships d
WHERE d.business_name = 'Meadley Autos of California';