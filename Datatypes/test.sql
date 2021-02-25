SELECT e.lastname, el.description
FROM APPX_employee e
JOIN APPX_department d
ON e.department_id = d.id
JOIN APPX_educationlevel el
ON e.educationlevel_id = el.id
HAVING 
ORDER BY e.lastname;

SELECT d.department_name, count(e.id) AS people, sum(e.salary) AS salary 
FROM APPX_department d
JOIN APPX_employee e
ON e.department_id = d.id
GROUP BY d.department_name
ORDER BY sum(e.salary) ASC;


-- DOING THIS
SELECT e.lastname, el.description
FROM APPX_employee e
JOIN APPX_department d
ON e.department_id = d.id
JOIN APPX_educationlevel el
ON e.educationlevel_id = el.id
WHERE e.salary IN (SELECT sum(e.salary)
	   FROM APPX_employee e
	   JOIN APPX_department d
	   	ON e.department_id = d.id
	   GROUP BY d.id
	   HAVING sum(e.salary) > 250000)
ORDER BY e.lastname ASC;
