SELECT geo_name,
state_us_abbreviation AS "st",
p0010001 AS "Total Population",
p0010003 AS "White Alone",
p0010004 AS "Black or African American Alone",
p0010005 AS "Am Indian/Alaska Native Alone",
p0010006 AS "Asian Alone",
p0010007 AS "Native Hawaiian and Other Pacific Islander Alone",
p0010008 AS "Some Other Race Alone",
p0010009 AS "Two or More Races"
FROM us_counties_2010;
--The number of people who identifies as black alone or white alone
SELECT geo_name,state_us_abbreviation AS "st",
p0010003 AS "White Alone",
p0010004 AS "Black Alone",
p0010003 + p0010004 AS "Total White and Black"
FROM us_counties_2010;

--This is a more bigger
SELECT geo_name,state_us_abbreviation AS "st",
 p0010001 AS "Total",
 p0010003 + p0010004 + p0010005 + p0010006 + p0010007+ p0010008 + p0010009 AS "All Races",
 (p0010003 + p0010004 + p0010005 + p0010006 + p0010007+ p0010008 + p0010009) - p0010001 AS "Difference"
FROM us_counties_2010
ORDER BY "Difference" DESC;
--Percentage of each country of the population that reported to be Assian
SELECT geo_name,state_us_abbreviation AS "st",
(CAST (p0010006 AS numeric(8,1)) / p0010001) * 100 AS "pct_asian"
FROM us_counties_2010
ORDER BY "pct_asian" DESC;


--Change of the percentage is (new value- old value) / old value
CREATE TABLE percent_change (
department varchar(20),
spend_2014 numeric(10,2)
spend_2017 numeric(10,2));


INSERT INTO percent_change
VALUES('Building', 250000, 289000),
('Assessor', 178556, 179500),
('Library', 87777, 90001),
('Clerk', 451980, 650000),
('Police', 250000, 223000),
('Recreation', 199000, 195000);

SELECT department,spend_2014,spend_2017,
 round( (spend_2017 - spend_2014) /spend_2014 * 100, 1) AS "pct_change" --
FROM percent_change;


SELECT sum(p0010001) AS "County Sum",
round(avg(p0010001), 0) AS "County Average"
FROM us_counties_2010;

--Now using the dataset
SELECT sum(p0010001) AS "County Sum",
round(avg(p0010001), 0) AS "County Average",
percentile_cont(.5)
WITHIN GROUP (ORDER BY p0010001) AS "County Median"
FROM us_counties_2010;

--Using arrays to get the percentiles
SELECT percentile_cont(array[.25,.5,.75])
WITHIN GROUP (ORDER BY p0010001) AS "quartiles"
FROM us_counties_2010;
-- This will return an array, so, ussually we see the rows, to do a visualization of rows
-- We can use the unnest() function
SELECT unnest(
  percentile_cont(array[.25,.5,.75])
  WITHIN GROUP (ORDER BY p0010001)) AS "quartiles"
FROM us_counties_2010;

--CREATING A MEDIA function

CREATE OR REPLACE FUNCTION _final_median(anyarray)
RETURNS float8 AS
$$
WITH q AS
(
  SELECT val
  FROM unnest($1) val
  WHERE VAL IS NOT NULL
  ORDER BY 1
),
cnt AS
(
  SELECT COUNT(*) AS c FROM q
)
SELECT AVG(val)::float8
FROM
(
  SELECT val FROM q
  LIMIT 2 - MOD((SELECT c FROM cnt), 2)
  OFFSET GREATEST(CEIL((SELECT c FROM cnt) / 2.0) - 1,0)
) q2;
$$

LANGUAGE sql IMMUTABLE;

CREATE AGGREGATE median(anyelement) (
  SFUNC=array_append,
  STYPE=anyarray,
  FINALFUNC=_final_median,INITCOND='{}'
);


SELECT sum(p0010001) AS "County Sum",
round(AVG(p0010001), 0) AS "County Average",
median(p0010001) AS "County Median",
percentile_cont(.5)
WITHIN GROUP (ORDER BY p0010001) AS "50th Percentile"
FROM us_counties_2010;
-- Finding the mode with the mode() function

SELECT mode() WITHIN GROUP(ORDER BY p0010001)
FROM us_counties_2010;
--Excercises :
-- Using the 2010 Census county data, find out which New York
--state county has the highest percentage of the population that
--identified as “American Indian/Alaska Native Alone.”
-- where p0010004 integer,       -- American Indian and Alaska Native Alone

SELECT geo_name, state_us_abbreviation,
round(((p0010005::numeric(8,1))/p0010001)*100, 5) AS "% of American Indian/Alaska Native Alone"

FROM us_counties_2010
ORDER BY "% of American Indian/Alaska Native Alone" DESC
LIMIT 1;
-- Was the 2010 median county population higher in California or New York?

SELECT state_us_abbreviation,
median(p0010001) as "Median Population"
FROM us_counties_2010
WHERE state_us_abbreviation ILIKE 'ny' OR state_us_abbreviation ILIKE 'ca'
GROUP BY state_us_abbreviation ;
