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


-- Create a transaction for:
-- Creating a new dealership in Washington, D.C. called Felphun Automotive
-- Hire 3 new employees for the new dealership: Sales Manager, General Manager and Customer Service.
-- All employees that currently work at Nelsen Autos of Illinois will now start working at Cain Autos of Missouri instead.

BEGIN;
DECLARE
	dealershipId int;
	employeeID1 int;
	employeeID2 int;
	employeeID3 int;

INSERT INTO dealerships
(business_name, phone, city, state, website, tax_id)
VALUES 'Felphun Automotive', '345-232-1342', 'Nashville', 'Tennessee', 'gh-856-a8d5'
RETURNING dealership_id INTO dealershipId;

INSERT INTO employees
(first_name, last_name, email_address, phone, employee_type_id)
SELECT 'Bob', 'Johnson', 'bob@johnson.com', '334-564-5555', et.employee_type_id
FROM employeetypes et
WHERE et.name = 'Sales Manager'
RETURNING employee_id INTO employeeID1;

INSERT INTO employees
(first_name, last_name, email_address, phone, employee_type_id)
SELECT 'Steve', 'Stevens', 'steve@stevens.com', '444-555-6666', et.employee_type_id
FROM employeetypes et
WHERE et.name = 'General Manager'
RETURNING employee_id INTO employeeID2;

INSERT INTO employees
(first_name, last_name, email_address, phone, employee_type_id)
SELECT 'Mark', 'Jacobs', 'mark@jacobs.com', '332-334-5643', et.employee_type_id
FROM employeetypes et
WHERE et.name = 'Customer Service'
RETURNING employee_id INTO employeeID3;

INSERT INTO dealershipemployees
(dealership_id, employee_id)
VALUES (dealershipId, employeeID1);

INSERT INTO dealershipemployees
(dealership_id, employee_id)
VALUES (dealershipId, employeeID2);

INSERT INTO dealershipemployees
(dealership_id, employee_id)
VALUES (dealershipId, employeeID3);

UPDATE dealershipemployees
SET dealership_id = (SELECT dealership_id FROM dealerships d WHERE d.business_name = 'Cain Autos of Missouri')
WHERE dealership_id = (SELECT dealership_id FROM dealerships d WHERE d.business_name = 'Nelsen Autos of Illinois');

COMMIT;

