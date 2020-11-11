-- Get a list of sales records where the sale was a lease.
SELECT
	st.name,
	s.price,
	s.purchase_date,
	s.invoice_number,
	s.deposit,
	s.payment_method
FROM sales s
JOIN salestypes st ON st.sales_type_id = s.sales_type_id
WHERE st.name = 'Lease';
	

-- Get a list of sales where the purchase date is within the last two years.
SELECT
	st.name,
	s.price,
	s.purchase_date,
	s.invoice_number,
	s.deposit,
	s.payment_method
FROM sales s
JOIN salestypes st ON st.sales_type_id = s.sales_type_id
WHERE s.purchase_date BETWEEN '2018-11-01' AND '2020-11-30'
ORDER BY s.purchase_date;

-- Get a list of sales where the deposit was above 5000 or the customer payed with American Express.

SELECT
	st.name,
	s.price,
	s.purchase_date,
	s.invoice_number,
	s.deposit,
	s.payment_method
FROM sales s
JOIN salestypes st ON st.sales_type_id = s.sales_type_id
WHERE s.deposit > 5000
OR s.payment_method = 'americanexpress';

-- Get a list of employees whose first names start with "M" or ends with "E".

SELECT
	e.first_name,
	e.last_name,
	e.email_address,
	e.phone
FROM employees e
WHERE e.first_name LIKE '%E'
OR e.first_name LIKE 'M%';

-- Get a list of employees whose phone numbers have the 600 area code.

SELECT
	e.first_name,
	e.last_name,
	e.email_address,
	e.phone
FROM employees e
WHERE e.phone Like '6%';




