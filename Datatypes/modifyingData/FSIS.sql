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
