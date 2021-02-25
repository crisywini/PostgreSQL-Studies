CREATE TABLE meat_poultry_egg_inspect (
              est_number varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
              company varchar(100),
              street varchar(100),
              city varchar(30),
              st varchar(2),
              zip varchar(5),
              phone varchar(14),
              grant_date date,
              activities text,
              dbas text);


\copy meat_poultry_egg_inspect
FROM '/home/crisisanchezp/prueba_psql/MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');


CREATE INDEX company_idx ON meat_poultry_egg_inspect (company);

SELECT company,
        street,
        city,
        st,
        count(*) AS address_count
FROM meat_poultry_egg_inspect
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;


SELECT st,count(*) AS st_count
FROM meat_poultry_egg_inspect
GROUP BY st
ORDER BY st;

SELECT est_number,
        company,
        city,
        st,
        zip
FROM meat_poultry_egg_inspect
WHERE st IS NULL;

SELECT company,
       count(*) AS company_count
FROM meat_poultry_egg_inspect
GROUP BY company
ORDER BY company ASC;

SELECT length(zip),
       count(*) AS length_count
FROM meat_poultry_egg_inspect
GROUP BY length(zip)
ORDER BY length(zip) ASC;


SELECT st,
count(*) AS st_count
FROM meat_poultry_egg_inspect
WHERE length(zip) < 5
GROUP BY st
ORDER BY st ASC;
-- Standard of ALERT TABLE
-- To add a column
ALTER TABLE table ADD COLUMN column data_type;

-- To remove a column
ALTER TABLE table DROP COLUMN column:

-- To change the type of a column
ALTER TABLE table ALTER COLUMN column SET DATA TYPE data_type;

--Adding not null
ALTER TABLE table ALTER COLUMN column SET NOT NULL;

--To modify Values of a column we can use UPDATE
--The new value to
--place in the column can be a string, number,
--the name of another
--column, or even a query or expression
--that generates a value.

UPDATE table
SET column = value;

UPDATE table
SET column_a = value
    column_b = value;


-- We can use filters

UPDATE table
SET column = value
WHERE criteria;

-- And Subqueries

UPDATE table
SET column = (SELECT column
              FROM table_b
              WHERE table.column = table_b.column)
WHERE EXISTS (SELECT column
              FROM table_b
              WHERE table.column = table_b.column);

--Between tables we can use in PostgreSQL
--this
UPDATE table
SET column = table_b.column
FROM table_b
WHERE table.column = table_b.column;

--Creating a back up table

CREATE TABLE meat_poultry_egg_inspect_back_up AS
SELECT * FROM meat_poultry_egg_inspect;

--Selecting the correct number of rows

SELECT
  (SELECT count(*) FROM meat_poultry_egg_inspect) AS original,
  (SELECT count(*) FROM meat_poultry_egg_inspect_back_up) AS back_up;
-- Indexes are not copied when we copy a table

--Adding a back_up column to the st in the og table

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN st_copy varchar(2);

UPDATE meat_poultry_egg_inspect
SET st_copy = st;

--
UPDATE meat_poultry_egg_inspect
SET st = 'MN'
WHERE est_number = 'V18677A';


UPDATE meat_poultry_egg_inspect
SET st = 'AL'
WHERE est_number = 'M45319+P45319';

UPDATE meat_poultry_egg_inspect
SET st = 'WI'
WHERE est_number = 'M263A+P263A+V263A';
--Some of the values are nor consistence like Hambuerger or hambuerger
--Backing up the column
ALTER TABLE meat_poultry_egg_inspect ADD COLUMN company_standard varchar(100);

UPDATE meat_poultry_egg_inspect
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE 'Armour%';

SELECT company, company_standard
FROM meat_poultry_egg_inspect
WHERE company LIKE 'Armour%';

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN zip_copy varchar(5);

UPDATE meat_poultry_egg_inspect
SET zip_copy = zip;

UPDATE meat_poultry_egg_inspect
SET zip = '00' || zip
WHERE st IN('PR','VI') AND length(zip) = 3;

UPDATE meat_poultry_egg_inspect
SET zip = '0' || zip
WHERE st IN('CT','MA','ME','NH','NJ','RI','VT') AND length(zip) = 4;

-- UPDATING VALUES ACROSS TABLES

CREATE TABLE state_regions (
      st varchar(2) CONSTRAINT st_key PRIMARY KEY,
      region varchar(20) NOT NULL);

\copy state_regions
FROM '/home/crisisanchezp/prueba_psql/state_regions.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN inspection_date date;

UPDATE meat_poultry_egg_inspect inspect
SET inspection_date = '2019-12-01'
WHERE EXISTS (SELECT state_regions.region
              FROM state_regions
              WHERE inspect.st = state_regions.st
              AND state_regions.region = 'New England');


SELECT st, inspection_date
FROM meat_poultry_egg_inspect
GROUP BY st, inspection_date
ORDER BY st;

--Deleting rows from a table

--Deleting all rows from a table
DELETE FROM table_name;
--To filter the rows to delete
DELETE FROM table_name WHERE expression;

DELETE FROM meat_poultry_egg_inspect
WHERE st IN('PR','VI');

--Removing a column from a table is
ALTER TABLE table_name DROP COLUMN column_name;

ALTER TABLE meat_poultry_egg_inspect DROP COLUMN zip_copy;

--Deleting a table from a database is
DROP TABLE table_name;

DROP TABLE meat_poultry_egg_inspect_back_up;
