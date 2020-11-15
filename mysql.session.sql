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

/*
Joining

inner join: Reurns all data rows where at least one match in both tables
    select <columns or all> from table Inner join <table> on <table.column> = <table2.column>;

    can also use alias for the columns if they are ambiguous so that they are distinct

outer join:Returns matched as well as unmatched data


left outer: All data rows from left table are returned. Left table is the table after from to left of outer join clause

        select * from table1 left outer join table2 on table1.column1 = table2.column2;

        so table2 is limited by how many entries are in table1

right outer: essentially the opposite left and joins on the right table or the table after the right outer join clause

        select * from table1 left outer join table2 on table1.column1 = table2.column2;

        so table1 is limited by how many entries are in table 2

full outer: shows all data rows are written. MYSQL Does not support it so I have to use union instead

        select * from table1 left outer join table2 on table1.column1 = table2.column2 union select * from table1 right outer join table2 on table1.column1 = table2.column2;

crossjoin: does not use on clause and all rows are written joined to evrywhere regardless of if they match

        Should yield similar results despite which is first 


*/
select * from table1 inner join table2 on table1.column1 = table2.column2;

select customers.userid, name, phone, items, total from customers inner join orders on customers.userid = orders.userid;

select c.userid, c.name, c.phone, o.items, o.total from customers as c inner join orders as o on c.userid = o.userid;


/*
Left outer join
*/
select * from table1 left outer join table2 on table1.column1 = table2.column2;

 select name, jobtitle, title from employees left outer join projects on employees.employeeid = projects.employeeid order by title desc;

 select c.userid, c.name, c.phone, o.items, o.total from customers as c left outer join orders as o on c.userid = o.userid;

/*
Right outer join
*/


 select * from table1 right outer join table2 on table1.column1 = table2.column2;

select c.userid, c.name, c.phone, o.items, o.total from customers as c right outer join orders as o on c.userid = o.userid order by name desc;

select name, jobtitle, title from employees right outer join projects on employees.employeeid = projects.employeeid;


/*
full outer join

Because MYSQL does not support this we will have to left and right join in conjunction with a union
*/

/*
Can't use this in MYSQL
*/
select * from table1 full outer join table2 on table1.column1 = table2.column2;
/*
Instead
*/
select * from table1 left outer join table2 on table1.column1 = table2.column2 union select * from table1 right outer join table2 on table1.column1 = table2.column2;


/*
Cross join
*/

select e.name, e.jobtitle, p.title from employees as e cross join projects as p;

/*
Union: must have similar number of columns

union also joins two select statements adn we display duplicates
*/
select * from table1 union select * from table2;

select * from table1 union all select * from table2 order by column1;


/*
SQL VIEWs is a virtual table and can be used to restrict data from user for security purposes

views are created and viewed as selected

create view test ...;

select * from test;


You can update the view as well wit the create or replace

Can be deleted as well with delete keyword

*/

create view active_projects as select e.name, e.jobtitle, p.title from employees as e inner join projects as p on e.employeeid = p.employeeid;

select * from active_projects;

create view purchase_history as select c.userid, c.name, c.phone, o.items, o.total from customers as c left outer join orders as o on c.userid = o.userid order by name desc;

select * from purchase_history;

create or replace view purchase_history as select c.userid, c.name, c.phone, o.items, o.total from customers as c right outer join orders as o on c.userid = o.userid order by name desc;

select * from purchase_history;