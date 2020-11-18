/*Going to PRactice running full queries for a database of users to log into a website*/

select * from table1 left outer join table2 on table1.column1 = table2.column2 union select * from table1 right outer join table2 on table1.column1 = table2.column2;
