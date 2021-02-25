--Transactions allows to make a change not so deep
START TRANSACTION signals the start of the transaction block. In
PostgreSQL, you can also use the non-ANSI SQL BEGIN keyword.

COMMIT signals the end of the block and saves all changes.

ROLLBACK signals the end of the block and reverts all changes.


START TRANSACTION;

UPDATE meat_poultry_egg_inspect
SET company = 'AGRO Merchantss Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC';

SELECT company
FROM meat_poultry_egg_inspect
WHERE company LIKE 'AGRO%'
ORDER BY company;

ROLLBACK;


CREATE TABLE meat_poultry_egg_inspect_backup AS
    SELECT *,
    '2018-02-07'::date AS reviewed_date
    FROM meat_poultry_egg_inspect;


ALTER TABLE meat_poultry_egg_inspect RENAME TO meat_poultry_egg_inspect_temp;

ALTER TABLE meat_poultry_egg_inspect_back_up RENAME TO meat_poultry_egg_inspect;

ALTER TABLE meat_poultry_egg_inspect_temp RENAME TO meat_poultry_egg_inspect_backup;
