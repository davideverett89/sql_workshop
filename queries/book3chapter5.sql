-- Create a trigger for when a new Sales record is added, set the purchase date to 3 days from the current date.

CREATE FUNCTION set_purchase_date()
	RETURNS TRIGGER 
	LANGUAGE PlPGSQL
AS $$
BEGIN

	UPDATE sales s
	SET purchase_date = NEW.purchase_date + integer '3'
	WHERE s.sale_id = NEW.sale_id;

  	RETURN NULL;
END;
$$

CREATE TRIGGER update_purchase_date
	AFTER INSERT
	ON sales
	FOR EACH ROW
	EXECUTE PROCEDURE set_purchase_date();
	
INSERT INTO sales
(sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method, sale_returned)
SELECT st.sales_type_id, v.vehicle_id, e.employee_id, c.customer_id, d.dealership_id, 80000, 30000, '2020-11-12', '2020-11-20', '22222222222', 'Visa', false
FROM salestypes st, vehicles v, employees e, customers c, dealerships d
WHERE st.name = 'Purchase'
AND v.vin = '1N6AD0CU6FN889175'
AND e.employee_id = 1
AND c.customer_id = 1
AND d.business_name = 'Shelper Autos of Nevada';

SELECT * FROM sales;