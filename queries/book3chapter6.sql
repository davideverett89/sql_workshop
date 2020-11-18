-- Because Carnival is a single company, we want to ensure that there is consistency in the data provided to the user. 
-- Each dealership has it's own website but we want to make sure the website URL are consistent and easy to remember. 
-- Therefore, any time a new dealership is added or an existing dealership is updated, we want to ensure that the website URL has the following format: 
-- http://www.carnivalcars.com/{name of the dealership with underscores separating words}.

CREATE FUNCTION set_website_url()
  RETURNS TRIGGER 
  LANGUAGE PlPGSQL
AS $$
BEGIN

	UPDATE dealerships d
	SET website = CONCAT('http://www.carnivalcars.com/', '',
		REPLACE(
			LOWER(NEW.business_name),
			' ',
			'_'
		)
	)
	WHERE d.dealership_id = NEW.dealership_id;

 	RETURN NULL;
END;
$$

CREATE TRIGGER on_dealership_insert
  AFTER INSERT
  ON dealerships
  FOR EACH ROW
  EXECUTE PROCEDURE set_website_url();


-- CREATE TRIGGER on_dealership_update
--   AFTER UPDATE
--   ON dealerships
--   FOR EACH ROW
--   EXECUTE PROCEDURE set_website_url();
  
 UPDATE dealerships
 SET phone = '1'
 WHERE dealership_id = 8;
  
 SELECT * FROM dealerships
 WHERE dealership_id = 8;