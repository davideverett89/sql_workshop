-- Carnival would like to create a stored procedure that handles the case of updating their vehicle inventory when a sale occurs. 
-- They plan to do this by flagging the vehicle as is_sold which is a field on the Vehicles table. 
-- When set to True this flag will indicate that the vehicle is no longer available in the inventory. 
-- Why not delete this vehicle? We don't want to delete it because it is attached to a sales record.

SELECT * FROM vehicles
WHERE vehicle_id = 1;


CREATE PROCEDURE sell_vehicle(IN a int)
LANGUAGE plpgsql
AS $$
BEGIN

UPDATE vehicles v
SET is_sold = true
WHERE v.vehicle_id = a;

END
$$;

CALL sell_vehicle(1);

-- Carnival would also like to handle the case for when a car gets returned by a customer. 
-- When this occurs they must add the car back to the inventory and mark the original sales record as sale_returned = TRUE.
-- Carnival staff are required to do an oil change on the returned car before putting it back on the sales floor. 
-- In our stored procedure, we must also log the oil change within the OilChangeLogs table.

SELECT * FROM sales s WHERE s.vehicle_id = 233;


CREATE PROCEDURE return_vehicle(IN a INT)
LANGUAGE plpgsql
AS $$
BEGIN

UPDATE vehicles v
SET is_sold = false
WHERE v.vehicle_id = a;

UPDATE sales s
SET sale_returned = true
WHERE s.vehicle_id = a;

INSERT INTO oilchangelogs
(date_occured, vehicle_id)
SELECT NOW()::timestamp, a;

END
$$;

CALL return_vehicle(1);

SELECT * FROM oilchangelogs;
SELECT * FROM sales WHERE vehicle_id = 1;
SELECT * FROM vehicles WHERE vehicle_id = 1;