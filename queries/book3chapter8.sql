-- Adding 5 brand new 2021 Honda CR-Vs to the inventory. 
-- they have I4 engines and are classified as a Crossover SUV or CUV. 
-- All of them have beige interiors but the exterior colors are Lilac, Dark Red, Lime, Navy and Sand.
-- The floor price is $21,755 and the MSR price is $18,999.
SELECT * FROM vehiclemakes;
SELECT * FROM vehiclemodels;
SELECT * FROM vehiclebodytypes;
SELECT * FROM vehicletypes;

DELETE FROM vehiclemakes WHERE name = 'Honda';

DO $$
DECLARE
	vehicleTypeId1 INT;
	vehicleTypeId2 INT;
BEGIN

INSERT INTO vehiclemakes
(name)
VALUES
('Honda');

INSERT INTO vehiclemodels
(name)
VALUES
('CR-V');

INSERT INTO vehiclebodytypes
(name)
VALUES
('Crossover SUV'),
('CUV');

INSERT INTO vehicletypes
(vehicle_body_type_id, vehicle_make_id, vehicle_model_id)
SELECT vbt.vehicle_body_type_id, vm.vehicle_make_id, vmd.vehicle_model_id
FROM vehiclebodytypes vbt, vehiclemakes vm, vehiclemodels vmd
WHERE vm.name = 'Honda'
AND vmd.name = 'CR-V'
AND vbt.name = 'Crossover SUV'
RETURNING vehicle_type_id into vehicleTypeId1;

INSERT INTO vehicletypes
(vehicle_body_type_id, vehicle_make_id, vehicle_model_id)
SELECT vbt.vehicle_body_type_id, vm.vehicle_make_id, vmd.vehicle_model_id
FROM vehiclebodytypes vbt, vehiclemakes vm, vehiclemodels vmd
WHERE vm.name = 'Honda'
AND vmd.name = 'CR-V'
AND vbt.name = 'CUV'
RETURNING vehicle_type_id into vehicleTypeId2;

INSERT INTO vehicles
(vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car, is_sold, is_new, dealership_id)
VALUES
('111111111111', 'I4', vehicleTypeId1, 'Lilac', 'Beige', 21755, 18999, 500, 2021, false, true, 5),
('222222222222', 'I4', vehicleTypeId1, 'Dark Red', 'Beige', 21755, 18999, 550, 2021, false, true, 5),
('333333333333', 'I4', vehicleTypeId2, 'Lime', 'Beige', 21755, 18999, 300, 2021, false, true, 5),
('444444444444', 'I4', vehicleTypeId1, 'Navy', 'Beige', 21755, 18999, 150, 2021, false, true, 5),
('555555555555', 'I4', vehicleTypeId2, 'Sand', 'Beige', 21755, 18999, 600, 2021, false, true, 5);

EXCEPTION WHEN others THEN
ROLLBACK;

END;

$$ language plpgsql;

-- For the CX-5s and CX-9s in the inventory that have not been sold, change the year of the car to 2021 since we will be updating our stock of Mazdas.
-- For all other unsold Mazdas, update the year to 2020.
-- The newer Mazdas all have red and black interiors.

-- The vehicle with VIN KNDPB3A20D7558809 has been brought in for servicing.
-- Document that the service department did a tire change, windshield wiper fluid refill and an oil change.