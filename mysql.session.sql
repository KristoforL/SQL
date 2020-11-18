SHOW DATABASES;

describe <table> or explain <table>

Alter table rename/add/modify/drop

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


/*
Derived tables or inline views
- sub query in parenthesis
- shows the view upon execution of the query and with that you can see what rows you want to see
- you name the view/table at the in with the as clause
- 

*/

select name, title from (select e.name, e.jobtitle, p.title from employees as e inner join projects as p on e.employeeid = p.employeeid) as active_projects;

select * from active_projects;


/*
SQL Fucntions

aggregate functions: works on groups of rows to return single aggregate result value

scalar functions: works on a single input value to return single result value
*/


/*
Count()

does not count nulls
*/
select count(*) from students; /*Counts all the rows*/

select count(Distinct class) from students;/*Counts all thhe ditinct values in class row */


select count(p.title) from employees as e left outer join projects as p on e.employeeid = p.employeeid order by title desc;/*counts all the titles that the project table returns when left outer join in used*/




select * from students limit 1;/*Returns the first item from the query and can also be used to limit it to more as seen below*/
select * from students limit 5;

/*
You can reverse the above just by order by desc order before the limit clause
*/

select firstname, lastname from students order by firstname desc limit 5;


/*
Sum() function
sum used with stringcolumns will return 0 value
*/

select sum(age) from students;
select sum(salary) from employees;


/*
Min() function and Max() function

Unlike sum this works with strings as well. When useing it min on strings it sorts them dictionary style and then returns the string
*/

select min(firstname) from students;
select max(firstname) from students;
select max(age) from students;

/*
AVG() function: averages the amount from column and returns 0 from strings
*/

select avg(salary) as avg_salary from employees;


/*
UCASE AND LCASE()
UCASE(): turns all charcaters to upper case and only works with strings

Has to be seperate for multiplte columns in 

LCASE(): Turns all the characters to lowercase
*/

ucase(firstname) from students;
select ucase(firstname), ucase(lastname) from students;

select lcase(firstname), lcase(lastname) from students;

/*
MID(): extracts from strings
*/

select mid(firstname, 1, 3) from students;/*Declare function, starting point, ending point(length) when the second parameter is not included it will print the rest of the string after the starting point*/


/*
len() function: only available in windows azure
length() function for mysql

only works on strings
*/

select firstname, length(firstname) as name_length from students;


/*
Round() function: only works on numbers and rounds to nearest whole number

 also has a parameter where you can decide how many decimals to round to
*/

select round(10.0456789);
select round(10.5456789, 3)


/*
Format(): similar to round and only works on numbers
Format returns results as a string though and not a float or integer
*/

select format(10.0456789);
select format(10.5456789, 3)

/*
substring() function is similar to mid()
uses slightly differnt syntax
*/

select substring(firstname from 2 for 2) from students;


/*
COALESCE() function returns first none null value from given list
*/
select coalesce(1,2,3);
select coalesce(null,2,3);
select coalesce(null,null,3);


/*
Char_lenght() functions returns length of given string value
*/

select char_length(firstname) from students;
select firstname, char_length(firstname) as length from students;


/*
CAST() function: used to change the data type of a value
*/

select cast(10.456789 as signed);
select cast(10 as decimal);
select cast(10 as decimal(4,1));
select cast(10.456789 as char(4));)

/*
Case() function and returns a value or null by evaluating a series of condition

A do something while looking throuigh tables if condition is met else end the query

Can be used with numbers and strings

seimple case and searched case
*/
select case(3)
    when 1 then 'one'
    when 2 then 'two'
    when 3 then 'three'
    when 4 then 'four'
    when 5 then 'five'
    else 'no match'
    end;


select firstname, age, case
    when (age = 5) then 'five'
    when (age = 6) then 'six'
    when (age = 7) then 'seven'
    else null
    end
    as 'Age as text'
    from students;


/*
Nullif() returna null if 2 paramter values are equal
works with numbers and strings
if not equal it will return first arguement
*/

select nullif(10,20);
select nullif(10,10);
select nullif(20,10);

select nullif('xyz','abc');


select table1.column1, table2.column2, nullif(table1.column1, table2.column2) from table1 left outer join table2 on table1.column1 = table2.column2 order by column1;

/*
DATA TYPES
*/

/*
-Numerical, character, and temporal data types

signed numbers are numbers including negatives and unsigned numbers are positve numbers only

-numerical: numbers only
integer/int: second largest range
tinyint: -128>127
smallint: -32768>32767
mediumint: -8388608> 8388607
bigint: Biggest range


fixed point numbers: exact values floats, prices, small calculations and can be negative. Decimal and numeric data types are the only data types that use fixed numbers.

decimal and numeric data types are same for storing data types

floating point numbers: very very big or very very small numbers. Approximate values. Usually bigger than bigint or int values.
Decimal(25,0)

float, real and double precision:  float/real/double precision (M,D) m- number of digits and d- number digits in decimal

-character: alphabets symbols and numbers

char: required to enter the column width. Firstname char(20). Remaining spaces are just spaces behind the last character

varchar: similar to char and stores dynamic width character columns but does not fill the spaces behind the last charcater so only stores the amount of characters you have plus one byte

nchar/nvarchar: national and national variable character: similar to varchar and char but has a larger character set. Use unicode charcater sets like utf-8. 2 byte storage space for each charater as opposed to one byte in varchar and char

clob and blob: character large object and binary large objects. Used to store very large data that can not be stored in char or varchar. clob and blob are used to store source text of the post in plain text, html, or xml.

Clob used to store character data while blob is used to store binary data like images audio and video

Mysql TEXT data type is similar ro clob


-temporal: date time and timestamp

*/


/*
Ways to alter the table and he columns within it
*/
alter table students2 rename students_two;

alter table students_two add state varchar(20);

alter table students_two modify column state varchar(50);

alter table students_two drop column state;


/*
SQL contraints

not null can be used for characters and numbers

unique is useful to ensure duplicate data row value in given column is restricted.

primary key: to restict of duplicate data row value in given column and there can only be on primary key in a table and cannot be null uses basic add and drop to add or remove the primary key
*/

alter table students modify column firstname varchar(40) null, modify lastname varchar(40) null;

/*
To remove the unique constraint is a little different than expected
*/

alter table subjects DROP INDEX title;

/*
Should be able to delete and add the primary keys like below
*/
alter table subjects drop primary key (title);
alter table subjects add primary key title;

/*
Foreign key in a table always points to a primary key in another table



*/

alter table <table1> add constraint <FKcolumn1> foreign key (column1) references <table2>(column1)

alter table teachers add constraint fk_subjectid foreign key (subjectid) references subjects(subjectid);

update teachers set subjectid = 3 where teacherid =1;

update itemcodes set itemcode = 'code1236' where itemid = 3;

alter table teachers drop foreign key fk_subjectid;


/*
Check constraint: used to control value range that can be stored in a table column

example below for azure or db that is not mysql

ignored in mysql 
*/

create table <table1> (
        column1 datatype,
        column2 datatype,
        check(column>1)
);

alter table table1 add constraint chk_column1 check(column1>0);

/*
Deafult constraint: set default value for data column and data row is not defined, it will be added in
*/

alter table students alter age set default 5;

/*
auto increment or sequence: generates and saves a unique number wvery time a new data row is inserted into table

only used with numeric values

mysql auto increments by 1
*/

/*
Data control language:

Grant and revoke

*/

grant privileges on database to user;

grant all on *.* to kris;
grant select, create on school.* to maker;
 /*
 Must select all privileges on a user table to see what the permissions each user has
 */

 select user, select_priv, update_priv, delete_priv, Create_priv from user;


 /*
 Transaction control language

 ability to rollback

 in case transaction fails you can revert or start from save point


 start transaction: starts new transction

 commit: completes and saves changes permenantly
 insert update or delete
 only after transaction statement
 
 rollback:  must execute before commit. Reverts back the changes, after rollback

 savepoint: rollback the chnages to save points
 
 set autocommit: enable or disables default autocommit mode for current
 */

start transaction;
update students set age = 6 where studentid = 1;
commit;

/*
If you have not used commit then the changes will revert and can be checked by logging out and logging in to see if the information changed
*/

start transaction;
update students set age = 6 where studentid = 1;
rollback;


/*
Savepoint

cannot rollback to a save point after commit statement
*/

start transaction;
update clients set balance = (balance -100) where cid =1;
update clients set balance = (balance +100) where cid =2;
insert into t_details (t_message, t_Date) values ('John sent $100 to Mik' ,now());
select * from clients;
select * from t_details;
savepoint sp1;
update clients set balance = (balance -100) where cid =1;
insert into t_details (t_message, t_Date) values ('John sent $100 to Mik' ,now());
savepoint sp2;
select * from clients;
select * from t_details;
rollback to sp1;
select * from clients;
select * from t_details;

update clients set balance = 1000 where cid =1;
update clients set balance = 100 where cid =2;
insert into t_details (t_message, t_Date) values ('John sent $100 to Mik' ,now());
select * from clients;
select * from t_details;
savepoint sp1;
commit;


/*

set autocommit is enabled by default 

disabled when setart transaction is queried
0 is disabled 
1 is enabled


*/

set autocommit=0;
set autocommit=1;


/*
Database relationships

one to one: one data in one table to one data in another table
one id can only associate with one data in another table and are distinct to each other

one to many: one data in a table to many data in another table
one class can have many students so the class id will show up in many students agenda

many to many: many data in table to many data in another table


*/

/*
Database normalization: eliminates redundancies and store the data logically to make the data managament easier

1NF: each colum must contain only one value and no table should store repeating groups of related data

2NF: Must be in 1NF. It should not store duplicate rows in the same table. Duplicate values in the tow should be stored in their own separate tables and linked to the table using foreign keys. Create one to many relationship tables

3NF: The DB is already in third normal form if it is in second normal form and every non key column is mutally independent. identify iterdependent columns and store them in their own separate tables
*/

/*
SQL Export and import

Cant be written as below and saved to any place and as any extenstion but should probably be a csv, text file, or sql file for importing reasons


*/
 /*saves tablea from DB*/
mysqldump -uroot -p company > C:\backup\company.sql

/*Backups database structure only*/
mysqldump -uroot -p company > C:\backup\company.sql

/*Saves all DBs and information*/
mysqldump -uroot -p --all-databases > C:\BU\ALL.sql


/*Importing*/

/*Importing tables*/

mysql -uroot -p school < "C:\BU\students.sql"


