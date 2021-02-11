CREATE TABLE pls_fy2014_pupld14a (
    stabr varchar(2) NOT NULL,
    fscskey varchar(6) CONSTRAINT fscskey2014_key PRIMARY KEY,
    libid varchar(20) NOT NULL,
    libname varchar(100) NOT NULL,
    obereg varchar(2) NOT NULL,
    rstatus integer NOT NULL,
    statstru varchar(2) NOT NULL,
    statname varchar(2) NOT NULL,
    stataddr varchar(2) NOT NULL,
    longitud numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    fipsst varchar(2) NOT NULL,
    fipsco varchar(3) NOT NULL,
    address varchar(35) NOT NULL,
    city varchar(20) NOT NULL,
    zip varchar(5) NOT NULL,
    zip4 varchar(4) NOT NULL,
    cnty varchar(20) NOT NULL,
    phone varchar(10) NOT NULL,
    c_relatn varchar(2) NOT NULL,
    c_legbas varchar(2) NOT NULL,
    c_admin varchar(2) NOT NULL,
    geocode varchar(3) NOT NULL,
    lsabound varchar(1) NOT NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    master numeric(8,2) NOT NULL,
    libraria numeric(8,2) NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    locgvt integer NOT NULL,
    stgvt integer NOT NULL,
    fedgvt integer NOT NULL,
    totincm integer NOT NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer NOT NULL,
    elmatexp integer NOT NULL,
    totexpco integer NOT NULL,
    totopexp integer NOT NULL,
    lcap_rev integer NOT NULL,
    scap_rev integer NOT NULL,
    fcap_rev integer NOT NULL,
    cap_rev integer NOT NULL,
    capital integer NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl float NOT NULL,
    video_ph integer NOT NULL,
    video_dl float NOT NULL,
    databases integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    referenc integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    elmatcir integer NOT NULL,
    loanto integer NOT NULL,
    loanfm integer NOT NULL,
    totpro integer NOT NULL,
    totatten integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    yr_sub integer NOT NULL
);

CREATE INDEX libname2014_idx ON pls_fy2014_pupld14a (libname);
CREATE INDEX stabr2014_idx ON pls_fy2014_pupld14a (stabr);
CREATE INDEX city2014_idx ON pls_fy2014_pupld14a (city);
CREATE INDEX visits2014_idx ON pls_fy2014_pupld14a (visits);

\copy pls_fy2014_pupld14a
FROM '/home/crisisanchezp/prueba_psql/pls_fy2014_pupld14a.csv'
WITH (FORMAT CSV, HEADER);

CREATE TABLE pls_fy2009_pupld09a (
    stabr varchar(2) NOT NULL,
    fscskey varchar(6) CONSTRAINT fscskey2009_key PRIMARY KEY,
    libid varchar(20) NOT NULL,
    libname varchar(100) NOT NULL,
    address varchar(35) NOT NULL,
    city varchar(20) NOT NULL,
    zip varchar(5) NOT NULL,
    zip4 varchar(4) NOT NULL,
    cnty varchar(20) NOT NULL,
    phone varchar(10) NOT NULL,
    c_relatn varchar(2) NOT NULL,
    c_legbas varchar(2) NOT NULL,
    c_admin varchar(2) NOT NULL,
    geocode varchar(3) NOT NULL,
    lsabound varchar(1) NOT NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    master numeric(8,2) NOT NULL,
    libraria numeric(8,2) NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    locgvt integer NOT NULL,
    stgvt integer NOT NULL,
    fedgvt integer NOT NULL,
    totincm integer NOT NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer NOT NULL,
    elmatexp integer NOT NULL,
    totexpco integer NOT NULL,
    totopexp integer NOT NULL,
    lcap_rev integer NOT NULL,
    scap_rev integer NOT NULL,
    fcap_rev integer NOT NULL,
    cap_rev integer NOT NULL,
    capital integer NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio integer NOT NULL,
    video integer NOT NULL,
    databases integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    referenc integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    loanto integer NOT NULL,
    loanfm integer NOT NULL,
    totpro integer NOT NULL,
    totatten integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    yr_sub integer NOT NULL,
    obereg varchar(2) NOT NULL,
    rstatus integer NOT NULL,
    statstru varchar(2) NOT NULL,
    statname varchar(2) NOT NULL,
    stataddr varchar(2) NOT NULL,
    longitud numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    fipsst varchar(2) NOT NULL,
    fipsco varchar(3) NOT NULL
);


CREATE INDEX libname2009_idx ON pls_fy2009_pupld09a (libname);
CREATE INDEX stabr2009_idx ON pls_fy2009_pupld09a (stabr);
CREATE INDEX city2009_idx ON pls_fy2009_pupld09a (city);
CREATE INDEX visits2009_idx ON pls_fy2009_pupld09a (visits);


\copy pls_fy2009_pupld09a
FROM '/home/crisisanchezp/prueba_psql/pls_fy2009_pupld09a.csv'
WITH (FORMAT CSV, HEADER);

SELECT count(salaries)
FROM pls_fy2009_pupld09a;

SELECT count(libname)
FROM pls_fy2014_pupld14a;

SELECT count(DISTINCT libname)
FROM pls_fy2014_pupld14a;


SELECT max(visits) AS Max_visits, min(visits) AS Min_visits
FROM pls_fy2014_pupld14a
WHERE visits > 0;


--Grouping and Ordering

SELECT stabr
FROM pls_fy2014_pupld14a
GROUP BY stabr
ORDER BY stabr;


--Grouping and Ordering is not only for one column, at least one
--But you can add as much as you want

SELECT city, stabr
FROM pls_fy2014_pupld14a
GROUP BY city, stabr
ORDER BY city, stabr;



SELECT stabr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY stabr
ORDER BY count(*) DESC;


--Also, when we select individual columns along with an aggregate function, we must
--include the columns in a GROUP BY clause
--If we don’t, the database will
--return an error telling us to do so. The reason is that you can’t group
--values by aggregating and have ungrouped column values in the same
--query


--This next code counts the number of agencies in
--each state that moved, had a minor address change, or had no change

SELECT stabr, stataddr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY stabr, stataddr
ORDER BY stabr ASC, count(*) DESC;


SELECT sum(visits) AS visits_2014
FROM pls_fy2014_pupld14a
WHERE visits >= 0;

SELECT sum(visits) AS visits_2009
FROM pls_fy2009_pupld09a
WHERE visits >= 0;


--Compare the anual visits from 2009 and 2014

SELECT sum(pls2009.visits) AS visits_2009, sum(pls2014.visits) AS visits_2014
FROM pls_fy2009_pupld09a pls2009
JOIN pls_fy2014_pupld14a pls2014
ON pls2009.fscskey = pls2014.fscskey
WHERE pls2009.visits >=0 AND pls2014.visits >=0;


SELECT pls14.stabr,
sum(pls14.visits) AS visits_2014,
sum(pls09.visits) AS visits_2009,
round( (CAST(sum(pls14.visits) AS decimal(10,1)) - sum(pls09.visits)) /
sum(pls09.visits) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0
GROUP BY pls14.stabr
ORDER BY pct_change DESC;

--aggregate functions, such as sum(), can’t be
--used within a WHERE clause because they operate at the row level, and
--aggregate functions work across rows
SELECT pls14.stabr,
        sum(pls14.visits) AS visits_2014,
        sum(pls09.visits) AS visits_2009,
        round( (CAST(sum(pls14.visits) AS decimal(10,1)) - sum(pls09.visits)) /
        sum(pls09.visits) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0
GROUP BY pls14.stabr
HAVING sum(pls14.visits) > 50000000
ORDER BY pct_change DESC;


--1. We saw that library visits have declined recently in most places.
--But what is the pattern in the use of technology in libraries?
--Both the 2014 and 2009 library survey tables contain the
--columns gpterms (the number of internet-connected computers
--used by the public) and pitusr (uses of public internet computers
--per year). Modify the code in Listing 8-13 to calculate the
--percent change in the sum of each column over time. Watch
--out for negative values!

SELECT min(pls14.gpterms),
       min(pls09.gpterms),
       min(pls14.pitusr),
       min(pls09.pitusr)
FROM pls_fy2009_pupld09a pls09
JOIN pls_fy2014_pupld14a pls14
ON pls09.fscskey = pls14.fscskey;
-- This means that there are negative numbers

SELECT pls14.stabr,
       sum(pls09.gpterms) AS internet_connected_2009,
       sum(pls09.pitusr) AS public_internet_computers_2009,
       sum(pls14.gpterms) AS internet_connected_2014,
       sum(pls14.pitusr) AS public_internet_computers_2014,
       round( (CAST(sum(pls14.gpterms) AS decimal(10,1)) - sum(pls09.gpterms)) /
       sum(pls09.gpterms) * 100, 2 ) AS pct_change
FROM pls_fy2009_pupld09a pls09
JOIN pls_fy2014_pupld14a pls14
ON pls09.fscskey = pls14.fscskey
WHERE pls09.gpterms >=0 AND pls09.pitusr >=0 AND pls14.gpterms >=0 AND pls14.pitusr >=0
GROUP BY pls14.stabr
ORDER BY pct_change DESC;

--Both library survey tables contain a column called obereg,
--a two digit Bureau of Economic Analysis Code that classifies each
--library agency according to a region of the United States, such
--as New England, Rocky Mountains, and so on. Just as we
--calculated the percent change in visits grouped by state, do the
--same to group percent changes in visits by U.S. region using
--obereg. Consult the survey documentation to find the meaning
--of each region code. For a bonus challenge, create a table with
--the obereg code as the primary key and the region name as text,
--and join it to the summary query to group by the region name
--rather than the code

SELECT pls14.obereg,
        sum(pls14.visits) AS visits_2014,
        sum(pls09.visits) AS visits_2009,
        round( (CAST(sum(pls14.visits) AS decimal(10,1)) - sum(pls09.visits)) /
        sum(pls09.visits) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.visits >= 0 AND pls09.visits >= 0
GROUP BY pls14.obereg
ORDER BY pct_change DESC;

--Thinking back to the types of joins you learned in Chapter 6,
--which join type will show you all the rows in both tables,
--including those without a match? Write such a query and add
--an IS NULL filter in a WHERE clause to show agencies not included
--in one or the other table.

SELECT pls09.libname,
       pls14.libname
FROM pls_fy2009_pupld09a pls09
FULL OUTER JOIN pls_fy2014_pupld14a pls14
ON pls09.fscskey = pls14.fscskey
WHERE pls09.libname IS NULL;

SELECT count(pls09.libname) AS n_09,
       count(pls14.libname) AS n_14
FROM pls_fy2009_pupld09a pls09
FULL OUTER JOIN pls_fy2014_pupld14a pls14
ON pls09.fscskey = pls14.fscskey
WHERE pls09.libname IS NULL;

SELECT count(pls09.libname) AS n_09,
       count(pls14.libname) AS n_14
FROM pls_fy2009_pupld09a pls09
FULL OUTER JOIN pls_fy2014_pupld14a pls14
ON pls09.fscskey = pls14.fscskey
WHERE pls14.libname IS NULL;
