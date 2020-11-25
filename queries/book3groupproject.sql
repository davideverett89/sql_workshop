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