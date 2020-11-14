SHOW DATABASES;


SELECT * FROM students WHERE (age > 6 AND firstname <> 'John');

SELECT * FROM students WHERE (age > 6 OR firstname <> 'John');

SELECT * FROM students WHERE (age > 6 || firstname <> 'John');

SELECT * FROM students WHERE age IN(5, 6);

SELECT * FROM employees WHERE EXISTS (SELECT * FROM projects WHERE projects.employeeid = employees.employeeid);

SELECT * FROM employees WHERE EXISTS (SELECT * FROM projects WHERE projects.employeeid = employees.employeeid AND projectid = 3);

SELECT * FROM students WHERE age BETWEEN 6 AND 10

SELECT CONCAT(firstname, ' ',lastname) AS FULLNAME FROM students;

SELECT CURRENT_DATE + INTERVAL 7 AS week;

SELECT CURRENT_DATE +INTERVAL 1 AS tomorrow;

SELECT class, COUNT(*) FROM students GROUP BY class;

SELECT categoryid, COUNT(*) AS 'Total Items' FROM items GROUP BY categoryid;

SELECT class, COUNT(*) FROM students GROUP BY class HAVING count(*) <20;

SELECT jobtitle, salary, COUNT(*) FROM employees GROUP BY salary;
/*
- This returned this for some reason. I have only tested this in mysql
ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'company.employees.jobtitle' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

but the below sql query worked without jobtitle

Answer from stackovwerflow says i need to have both in the groupby clause as well so it should be

SELECT jobtitle, salary, COUNT(*) FROM employees GROUP BY salary, jobtitle;

*/
SELECT salary, COUNT(*) FROM employees GROUP BY salary;

SELECT * FROM students ORDER BY firstname, lastname;

/*
Will be useful on the assessment
*/
SELECT * FROM employees LIMIT 10;

SELECT * FROM students WHERE firstname LIKE 'Jo_';
SELECT * FROM students WHERE firstname LIKE 'Jo__';
SELECT * FROM students WHERE firstname LIKE '%_y';

/*
Helpful for joining
*/

SELECT s.firstname, s.lastname FROM students AS s;

SELECT CONCAT(firstname, ' ',lastname) AS 'Fullname' FROM students;

insert into students2 select * students;

insert into students2 (firstname, lastname) select firstname, lastname from students;

delete from students2 where studentid = 60;

delete from students2;

SELECT NOW();
SELECT CURRENT_DATE();
