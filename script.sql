-- Table/s creation ; Value Insertion; Write the query ; Show the Result; Draw ER diagram of your 
-- database  and if possible write discussion on your work 
-- Employee (person-name, street, city, company-name, salary, manager-name) 
-- Company (company-name, city) 
-- Consider the database, where the primary keys  
-- are underlined. (company-name in Employee is foreign key  
-- referencing table Company) 
-- Insert 10 records for Employee and 4 records for Company.  
-- (keeping eye on queries for the specific insertion). 
-- Give an expression in SQL for each of the following queries. 
-- a. Find all employees in the database who do not work for First Bank Corporation. 
-- b. Give all managers of First Bank Corporation a 10 percent raise. 
-- c. Find the names, street addresses, and cities of residence of all employees 
-- who work for First Bank Corporation and earn more than $10,000. 
-- d. Find all employees in the database who live in the same cities as the companies 
-- for which they work. 
-- e. Find all employees in the database who live in the same cities and on the 
-- same streets as do their managers. 
-- f. Define a view consisting of manager-name and the average salary of all employees who work for 
-- that manager. 
-- g. Find all employees in the database who earn more than each employee of 
-- Small Bank Corporation. 


create table Company(
  company_name varchar(30),
  primary key (company_name),
  city varchar(10)
);

create table Employee(
  person_name varchar(10),
  primary key (person_name),
  street varchar(20),
  city varchar(10),
  company_name varchar(30),
  salary int,
  manager_name varchar(10),
  foreign key (company_name) references Company(company_name)
);


insert into Company values('First Bank Corporation','Kolkata');
insert into Company values('Small Bank Corporation','Pune');
insert into Company values('Second Bank Corporation','Delhi');
insert into Company values('Big Bank Corporation','Bangalore');

insert into Employee values('Ram','A road','Kolkata','First Bank Corporation',20000,null);
insert into Employee values('Shyam','A road','Kolkata','First Bank Corporation',10000,'Ram');
insert into Employee values('Jodu','CR road','Delhi','First Bank Corporation',1100,'Nakul');
insert into Employee values('Nakul','B road','Pune','First Bank Corporation',21000,null);
insert into Employee values('Rahim','A road','Kolkata','Big Bank Corporation',11000,null);
insert into Employee values('Raktim','Virat road','Bangalore','Big Bank Corporation',11000,'Rahim');
insert into Employee values('Dilip','L road','Pune','Second Bank Corporation',10000,null);
insert into Employee values('Kesto','MC road','Kolkata','Second Bank Corporation',9000,'Dilip');
insert into Employee values('Bapi','A road','Kolkata','First Bank Corporation',1100,'Ram');
insert into Employee values('Ramkanta','BL road','Delhi','Small Bank Corporation',11000,null);

select * from Employee,Company where Employee.company_name=Company.company_name and Employee.company_name='First Bank Corporation';

update Employee set salary=salary*1.1 where person_name in (select person_name from employee where manager_name is null and company_name='First Bank Corporation');

select * from employee where company_name='First Bank Corporation' and salary>10000;

select * from Employee,Company where Employee.company_name=Company.company_name and Employee.city=Company.city;

select e1.person_name from Employee e1,Employee e2 where e1.manager_name=e2.person_name and e1.city=e2.city and e1.street=e2.street;


create view edited as select * from employee where manager_name is not null;
create view xyz as select manager_name,avg(salary) as average_salary from edited group by manager_name;

select * from employee where salary>(select max(salary) from employee where company_name='Small Bank Corporation');



select distinct(company_name) from Employee where salary=(select min(salary) from Employee,Company where Employee.company_name=Company.company_name);