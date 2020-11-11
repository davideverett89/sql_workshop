-- Kristopher Blumfield an employee of Carnival has asked to be transferred to a different dealership location. She is currently at dealership 9. 
-- She would like to work at dealership 20. Update her record to reflect her transfer.

UPDATE dealershipemployees
SET dealership_id = 20
WHERE employee_id = (SELECT e.employee_id FROM employees e WHERE e.first_name = 'Kristopher' AND e.last_name = 'Blumfield');

-- A Sales associate needs to update a sales record because her customer want to pay with a Mastercard instead of JCB. 
-- Update Customer, Ernestus Abeau Sales record which has an invoice number of 9086714242.

UPDATE sales
SET payment_method = 'Mastercard'
WHERE customer_id = (
	SELECT
		c.customer_id
	FROM customers c
	WHERE c.first_name = 'Ernestus'
	AND c.last_name = 'Abeau'
)
AND invoice_number = '9086714242';

SELECT * FROM sales WHERE invoice_number = '9086714242';

-- A sales employee at carnival creates a new sales record for a sale they are trying to close. 
--The customer, last minute decided not to purchase the vehicle. 
-- Help delete the Sales record with an invoice number of '2436217483'.

DELETE FROM sales
WHERE invoice_number = '2436217483';

-- An employee was recently fired so we must delete them from our database. 
-- Delete the employee with employee_id of 35. 
-- What problems might you run into when deleting? How would you recommend fixing it?

ALTER TABLE dealershipemployees
DROP CONSTRAINT dealershipemployees_employee_id_fkey;

ALTER TABLE dealershipemployees 
ADD CONSTRAINT dealershipemployees_employee_id_fkey
FOREIGN KEY (employee_id)
REFERENCES employees (employee_id)
ON DELETE CASCADE;

ALTER TABLE sales
DROP CONSTRAINT sales_employee_id_fkey;

ALTER TABLE sales 
ADD CONSTRAINT sales_employee_id_fkey
FOREIGN KEY (employee_id)
REFERENCES employees (employee_id)
ON DELETE CASCADE;


DELETE FROM employees
WHERE employee_id = 35;
