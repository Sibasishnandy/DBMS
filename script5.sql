-- EMPLOYEE 
-- (EName, SSN_No , DoB  Date, City , Sex Char, Salary , Manager_SSN , Dept_No) 
-- DEPARTMENT  (Dept_Name, Dept_Num , MGR_SSN ) 
-- WORKS_ON  (SSN_Num  ,  Porject  , Hours) 
-- Create the tables and insert at least  8 records in First Table, 5 records in Second table, 4 records in 
-- Third table (keeping eye on queries for the specific insertion). 
-- SSN_No is primary key in EMPLOYEE. 
-- Dept_Num is primary key in DEPARTMENT. 
-- (SSN_Num,Project) is primary key inWORKS_ON.    
-- Dept_No in EMPLOYEE is foreign key referencing 
-- DEPARTMENT and SSN_Num in WORKS_ON 
-- is foreign key referencing EMPLOYEE. 
-- Perform the following queries: 
-- a. Retrieve the social security numbers of all employees who work on project 
-- number 1, 2, or 3.  
-- b. Retrieve the names of all employees who do not have supervisors.  
-- c. Retrieve the name and city of every employee who works for the ‘Research’ department.  
-- (Using join operation in the FROM-clause preferable.)  
-- d. For each department, retrieve the department number, the number of employees in the 
-- department, and their average salary.  
-- e. select the social security numbers of all employees who work the same (project, hours) 
-- combination on some project that employee ‘John Smith’ (whose SSN =45978) works on.  
-- f. List employees whose salary is greater than the salary of all the employees in department 5.  
-- g. Show the system date-time in the format ‘22nd October TWO THOUSAND ONE:11:30 AM’ 


create table employee(
  ename varchar(20),
  ssn_no int primary key,
  dob date,
  city varchar(10),
  sex varchar(10),
  salary int,
  manager_ssn int,
  dept_no int,
  foreign key(dept_no) references department(dept_num)
);
create table department(
  dept_name varchar(10),
  dept_num int primary key,
  mgr_ssn int
);
create table works_on(
  ssn_num int,
  project int,
  hours int,
  foreign key (ssn_num) references employee(ssn_no),
  primary key(ssn_num,project)
);

insert into department values('Research',1,10000);
insert into department values('HR',2,21204);
insert into department values('RD',3,45980);
insert into department values('Sales',4,45984);
insert into department values('Feedback',5,45985);

insert into employee values('John Smith',45978,'12-JAN-2000','Kolkata','M',20000,10000,1);
insert into employee values('John Ash',10000,'12-JUN-2001','Pune','M',20000,null,1);
insert into employee values('Joey Smith',21204,'12-JUL-2000','Chennai','F',20000,null,2);
insert into employee values('Jacky Chan',45979,'02-AUG-2003','Delhi','M',25800,20000,2);
insert into employee values('John Roy',45980,'12-JAN-2001','Mumbai','M',20490,null,3);
insert into employee values('John Sen',45981,'22-JAN-2000','Pune','M',27300,45980,3);
insert into employee values('John SenRoy',45982,'12-NOV-2002','Mumbai','M',30000,10000,1);
insert into employee values('Johny Sen',45983,'12-DEC-2001','Pune','M',20000,10000,1);
insert into employee values('Johny SenDin',45984,'12-SEP-2001','Kolkata','M',30000,null,4);
insert into employee values('Johny Son',45985,'02-AUG-2001','Delhi','M',20500,null,5);

insert into works_on values(10000,1,8);
insert into works_on values(21204,2,7);
insert into works_on values(45980,4,8);
insert into works_on values(45984,3,4);

select dept_name,dept_num,x as total_no_of_employee,y as avg_salary from department,(select dept_no,count(*) as x,avg(salary) as y from employee group by dept_no) where dept_no=dept_num;