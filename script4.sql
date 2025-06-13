--  PERSON and 4 records for 
-- PROJECT : 
            
 
 
 
 
 
 
 
 
 
 
--  COLUMN NAME              DATA TYPE (SIZE)           CONSTRAINTS   
 
--     PERSON_NO                     VARCHAR2 (5)                PRIMARY KEY                                     
-- PERSON_NAME                    VARCHAR2 (10)                  NOT NULL  
--   SALARY                                NUMBER (7, 2)          WITHIN 5000 AND 30000 
--    BIRTH_DATE                          DATE                               - 
--     JOIN_DATE                            DATE                                -  
--       P_NO                                NUMBER (4)          FOREIGN KEY REFERENCING PROJECT 
--     CITY                           VARCHAR2 (15)        STARTS WITH  ‘Ind_’      (eg Ind_Pune)           
                     
--   COLUMN NAME              DATA TYPE (SIZE)          CONSTRAINTS 
   
--                PROJECT_NO                      NUMBER (4)                        PRIMARY KEY 
--                PROJECT_NAME                VARCHAR2 (10)                    UNIQUE 

create table person(
  person_no varchar2(5) primary key,
  person_name varchar2(10) not null,
  salary number(7,2) check (salary between 5000 and 30000),
  birth_date date,
  join_date date,
  p_no number(4),foreign key (p_no) references project(project_no),
  city varchar2(15) check(city like 'Ind_%')
);
create table project(
  project_no number(4) primary key,
  project_name varchar2(10) unique
);

insert into project values (10,'alpha');
insert into project values(20,'beta');
insert into project values (30,'gamma');
insert into project values(40,'delta');

insert into person values('A1','adil',5200,'23-JAN-1989','23-JAN-2004',10,'Ind_Kolkata');
insert into person values('A2','adi',29000,'23-JAN-1979','23-JUN-2000',20,'Ind_Pune');
insert into person values('A3','pranar',5200,'03-FEB-1959','23-FEB-2000',30,'Ind_Bangalore');
insert into person values('A4','ram',20200,'02-JUN-1960','23-JAN-2001',40,'Ind_Mumbai');
insert into person values('A5','ramesh',5200,'23-JUN-1963','14-JAN-2000',10,'Ind_Pune');
insert into person values('A6','antik',5001,'03-MAR-1984','31-JAN-2002',40,'Ind_Kolkata');
insert into person values('A7','prakhar',30000,'23-NOV-1989','03-NOV-2004',20,'Ind_Bangalore');
insert into person values('A8','ashik',6450,'23-JAN-1967','23-JAN-2003',30,'Ind_Mumbai');
insert into person values('A9','dildar',10000,'23-AUG-1989','21-DEC-2004',40,'Ind_Pune');
insert into person values('A10','adil',7200,'23-MAR-1980','23-APR-2004',20,'Ind_Bangalore');


select project_name,"Total No of Employees" from project,(select p_no,count(*) as "Total No of Employees" from person group by p_no ) where project_no=p_no;

select '###'||person_name||'###' as edited_name from person;

-- EDITED_NAME
-- ----------------
-- ###adil###
-- ###adi###
-- ###ram###
-- ###ramesh###
-- ###antik###
-- ###ashik###
-- ###dildar###
-- ###adil###
-- ###pranar###
-- ###prakhar###