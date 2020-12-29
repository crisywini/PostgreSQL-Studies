
--To export basically is the same thing, the difference is the FROM to TO

COPY us_counties_2010
TO 'C:\YourDirectory\us_counties_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

--It could export some coluns, like this
COPY us_counties_2010 (geo_name, internal_point_lat, internal_point_lon)
  TO 'C:\YourDirectory\us_counties_latlon_export.txt'
  WITH (FORMAT CSV, HEADER, DELIMITER '|');
--And you can export a query like this

COPY (SELECT geo_name, state_us_abbreviation
  FROM us_counties_2010
  WHERE geo_name ILIKE '%mill')
  TO '/home/ruta/nombreArchivo.extension'
  WITH (FORMAT CSV, HEADER, DELIMITER ',');
