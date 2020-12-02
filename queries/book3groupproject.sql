-- Provide a way for the accounting team to track all financial transactions by creating a new table called Accounts Receivable.
-- The table should have the following columns: credit_amount, debit_amount, date_received as well as a PK and a FK to associate a sale with each transaction.

-- Set up a trigger on the Sales table. When a new row is added, add a new record to the Accounts Receivable table with the deposit as credit_amount, the timestamp as date_received and the appropriate sale_id.
-- Set up a trigger on the Sales table for when the sale_returned flag is updated. Add a new row to the Accounts Receivable table with the deposit as debit_amount, the timestamp as date_received, etc.

CREATE TABLE accountsreceivable (
	accounts_receivable_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	credit_amount NUMERIC,
	debit_amount NUMERIC,
	date_received TIMESTAMP WITH TIME ZONE,
	sale_id INT REFERENCES sales (sale_id)
);

CREATE FUNCTION ar_credit()
	RETURNS TRIGGER
	LANGUAGE PlPGSQL
AS $$
BEGIN

INSERT INTO accountsreceivable
(credit_amount, debit_amount, date_received, sale_id)
VALUES (NEW.deposit, null, current_date, NEW.sale_id);

RETURN NULL;
END;
$$

CREATE FUNCTION ar_debit()
	RETURNS TRIGGER
	LANGUAGE PlPGSQL
AS $$
BEGIN

INSERT INTO accountsreceivable
(credit_amount, debit_amount, date_received, sale_id)
VALUES (null, NEW.deposit, current_date, NEW.sale_id);

RETURN NULL;
END;
$$

CREATE TRIGGER make_credit
  AFTER INSERT
  ON sales
  FOR EACH ROW
EXECUTE PROCEDURE ar_credit();
  
CREATE TRIGGER make_debit
  AFTER UPDATE
  OF sale_returned
  ON sales
  FOR EACH ROW
EXECUTE PROCEDURE ar_debit();
 
INSERT INTO sales
(sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method, sale_returned)
VALUES (2, 30, 5, 10, 33, 4556, 2000,'2020-08-01', null, '5566778888', 'Visa', false);
 
SELECT * FROM employees WHERE employee_id = 30;
SELECT * FROM customers WHERE customer_id = 5;

SELECT * FROM accountsreceivable;

DELETE FROM accountsreceivable
WHERE accounts_receivable_id > 0;

-- Help out HR fast track turnover by providing the following:

-- Create a stored procedure with a transaction to handle hiring a new employee. 
-- Add a new record for the employee in the Employees table and add a record to the Dealershipemployees table for the two dealerships the new employee will start at.

SELECT * FROM dealerships;

CREATE OR REPLACE PROCEDURE hire_employee(
	firstName VARCHAR,
	lastName VARCHAR,
	emailAddress VARCHAR,
	phoneNumber VARCHAR,
	dealership1 VARCHAR,
	dealership2 VARCHAR,
	employeeType VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
	employeeId integer;
BEGIN

INSERT INTO employees
(first_name, last_name, email_address, phone, employee_type_id)
SELECT
firstName, lastName, emailAddress, phoneNumber, employee_type_id
FROM employeetypes
WHERE name = employeeType
RETURNING employee_id INTO employeeId;

COMMIT;

INSERT INTO dealershipemployees
(dealership_id, employee_id)
SELECT dealership_id, employeeId
FROM dealerships
WHERE business_name = dealership1;

INSERT INTO dealershipemployees
(dealership_id, employee_id)
SELECT dealership_id, employeeId
FROM dealerships
WHERE business_name = dealership2;

COMMIT;

END;
$$;

CALL hire_employee('Test', 'Employee', 'test@employee.com', '333-444-5555', 'Macak Autos of California', 'Joddins Autos of Louisiana', 'Finance Manager');

SELECT * FROM employees WHERE first_name = 'Test';

SELECT * FROM dealershipemployees WHERE employee_id = 1003;

-- Create a stored procedure with a transaction to handle an employee leaving.
-- The employee record is removed and all records associating the employee with dealerships must also be removed.

CREATE OR REPLACE PROCEDURE remove_employee(
	firstName VARCHAR,
	lastName VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
	employeeId INT;
BEGIN

DELETE FROM employees
WHERE first_name = firstName AND last_name = lastName
RETURNING employee_id INTO employeeId;

DELETE FROM dealershipemployees
WHERE employee_id = employeeId;

COMMIT;

END;
$$;


CALL remove_employee('Test', 'Employee');
