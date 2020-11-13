SHOW DATABASES;


SELECT * FROM students WHERE (age > 6 AND firstname <> 'John');

SELECT * FROM students WHERE (age > 6 OR firstname <> 'John');

SELECT * FROM students WHERE (age > 6 || firstname <> 'John');

SELECT * FROM students WHERE age IN(5, 6);

SELECT * FROM employees WHERE EXIST (SELECT * FROM projects WHERE projects.employeeid = employees.employeeid);

SELECT * FROM employees WHERE EXIST (SELECT * FROM projects WHERE projects.employeeid = employees.employeeid AND projectid = 3);

SELECT * FROM students WHERE age BETWEEN 6 AND 10

SELECT CONCAT (firstname, ' ',lastname) AS FULLNAME FROM students;

SELECT CURRENT_DATE + INTERVAL 7 AS week;

SELECT CURRENT_DATE +INTERVAL 1 AS tomorrow;

SELECT class, COUNT(*) FROM students GROUP BY class;

SELECT categoryid, COUNT(*) AS 'Total Items' FROM items GROUP BY categoryid;

SELECT class, COUNT(*) FROM students GROUP BY class HAVING count(*) <20;

SELECT jobtitle, salary, COUNT(*) FROM employees GROUP BY salary;
- This returned this for some reason. I have only tested this in mysql
ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'company.employees.jobtitle' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

but the below sql query worked without jobtitle
SELECT salary, COUNT(*) FROM employees GROUP BY salary;