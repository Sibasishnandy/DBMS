 
-- Create the following Database and insert at least 10 records for SCIENTIST  and 5 records for 
-- RESEARCH : 
            
 
 
 
 
 
 
 
 
 
 
--  COLUMN NAME   DATA TYPE (SIZE)           CONSTRAINTS   
 
-- sc_code                    varchar2 (5)         primary key, starts with ‘SR’ and ends with ‘A’ or ‘B’ or ‘C                           
-- scientist_name         varchar2 (15)                not null  
--  salary                                number (7, 2)      within 45000 and 80000 
--  birth_date                          date                     not later than   01/Jan/1980           
--   join_date                            date                    between year 2000 and 2008  
-- research_code             varchar2 (10)         foreign key referencing research, starts with ‘Ind_’  
--     city                           varchar2 (15)    among (Salt Lake,Noida,Gurgaon,Chennai,Bengaluru,Pune)           
                     
--   COLUMN NAME              DATA TYPE (SIZE)          CONSTRAINTS 
   
--        Unique_Research_No        varchar2 (10)                     primary key, starts with ‘Ind_’ 
--         reaserch_name                   varchar2 (10)                    unique 



create table research(
  Unique_Research_No varchar2(10) primary key check(Unique_Research_No like 'Ind_%'),
  research_name varchar2(10)
);
create table scientist(
  sc_code varchar2(5) check (sc_code like 'SR%A' or sc_code like 'SR%B' or sc_code like 'SR%C'),
  primary key (sc_code),
  scientist_name varchar2(15) not null,
  salary number(7,2) check(salary > 45000 and salary < 80000 ),
  birth_date date check(birth_date < '01-JAN-1980'),
  join_date date check(TO_NUMBER(TO_CHAR (join_date,'YYYY')) in (2000,2001,2002,2003,2004,2005,2006,2007,2008)),
  research_code varchar2(10) check( research_code like 'Ind_%'),
  foreign key (research_code) references research(Unique_Research_No),
  city varchar2(15) check( city in ('Salt Lake','Noida','Gurgaon','Chennai','Bengaluru','Pune'))
);

insert into research values('Ind_1','physics');
insert into research values('Ind_2','photon');
insert into research values('Ind_3','ray');
insert into research values('Ind_4','DIP');
insert into research values('Ind_5','maths');

insert into scientist values('SR1A','heliniski',46000,'01-FEB-1979','02-JAN-2005','Ind_1','Pune');
insert into scientist values('SR2A','sn dey',56000,'01-FEB-1970','03-JAN-2004','Ind_5','Gurgaon');
insert into scientist values('SR3B','prasunda',76000,'01-FEB-1969','02-JAN-2000','Ind_3','Chennai');
insert into scientist values('SR4B','jc bose',79000,'01-MAR-1960','11-DEC-2005','Ind_1','Noida');
insert into scientist values('SR5A','dr adren',56040,'01-FEB-1950','02-JAN-2001','Ind_4','Salt Lake');
insert into scientist values('SR6A','dr tom',56400,'01-OCT-1951','02-JUL-2008','Ind_2','Bengaluru');
insert into scientist values('SR1C','dr jimy',65000,'01-NOV-1952','02-DEC-2005','Ind_2','Pune');
insert into scientist values('SR2C','dr ash',51111,'01-FEB-1954','02-JUN-2006','Ind_4','Salt Lake');
insert into scientist values('SR3C','vidyut',71000,'14-FEB-1955','02-JUN-2007','Ind_5','Chennai');
insert into scientist values('SR4C','jamal',61111,'11-FEB-1944','12-AUG-2008','Ind_1','Bengaluru');
insert into scientist values('SR5C','Pipulpati',61101,'11-FEB-1944','12-FEB-2008','Ind_5','Bengaluru');

select * from scientist where to_number(to_char(birth_date,'MM'))=to_number(to_char(join_date,'MM'));

select substr(scientist_name,4,4) as "Abreviated Name",scientist_name from scientist;

create view youngerdate as select max(birth_date) as youngestdate,Unique_Research_No from scientist,research where research_code=Unique_Research_No group by Unique_Research_No;
select ceil((to_date(sysdate)-birth_date)/365) as age from youngerdate,scientist where research_code=Unique_Research_No and youngestdate=birth_date;

select to_char(join_date,'day') from scientist;
