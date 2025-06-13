-- Consider the following database: 
-- StudentMaster(Roll, Class, Name, Total Marks, StreamID). 
-- Stream(StreamID, Name, Duration, Fees)  
-- Create the tables and insert at least 10 records in first table and 4 records in second table (keeping 
-- eye on queries for the specific insertion). 
-- * Primary keys are underlined. 
-- * StreamId in  StudentMaster is foreign key  
-- referencing Stream 
-- Do the queries: 
-- a. List those students who do not appear in the exam yet (i.e. Total Marks not applicable) 
-- b. Give student details that get highest marks stream wise. 
-- c. List student details who take admission in longest duration course. 
-- d. List details of each student who gets more than the average marks in stream. 
-- e. List student whose name contains seven letters and  fees between 30000 and 60000 
-- f. 
-- List those students whose middle letter and first letter same. 
-- g. Create a view for stream which contains stream id, stream name, duration, fees  
-- and number of students.  


create table stream(
  streamid int,
  name varchar(20),
  duration int,
  fees int,
  PRIMARY key (streamid)
);

create table studentmaster(
  roll int,
  class int,
  name varchar(20),
  total_marks int,
  streamid int,
  primary key (roll),
  FOREIGN KEY (streamid) REFERENCES stream(streamid)
);

insert into studentmaster values(1,4,'Rameshkanti',300,111);
insert into studentmaster values(2,6,'Ram',null,222);
insert into studentmaster values(3,12,'Ramesh',null,111);
insert into studentmaster values(4,10,'Kanti',180,333);
insert into studentmaster values(5,4,'Kantikumar',140,444);
insert into studentmaster values(6,8,'Lilla',427,111);
insert into studentmaster values(7,7,'Rahim',300,222);
insert into studentmaster values(8,6,'Ramalingam',300,222);
insert into studentmaster values(9,4,'Kumar',320,444);
insert into studentmaster values(10,4,'Desai',300,333);

INSERT into stream values(111,'CSE',4,400000);
INSERT into stream values(222,'ECE',4,100000);
INSERT into stream values(333,'EE',5,4000);
INSERT into stream values(444,'AI/ML',1,10000);

select * from studentmaster where total_marks is null;

create view helping as select max(total_marks) as highestmarks,streamid from studentmaster group by streamid;
select studentmaster.roll,studentmaster.class,studentmaster.name,studentmaster.total_marks,studentmaster.streamid from helping,studentmaster where helping.streamid=studentmaster.streamid and helping.highestmarks=studentmaster.total_marks;

select studentmaster.roll,studentmaster.class,studentmaster.name,studentmaster.total_marks,studentmaster.streamid from studentmaster,stream where studentmaster.streamid=stream.streamid and duration=(select max(duration) from stream);

create view helping1 as select avg(total_marks) as avgmarks,streamid from studentmaster group by streamid;
select studentmaster.roll,studentmaster.class,studentmaster.name,studentmaster.total_marks,studentmaster.streamid from helping1,studentmaster where helping1.streamid=studentmaster.streamid and helping1.avgmarks<studentmaster.total_marks;

select * from studentmaster,stream where studentmaster.name like '_____' and studentmaster.streamid=stream.streamid and fees between 2000 and 60000;

select * from studentmaster where SUBSTR(name,1,1)=SUBSTR(name,ceil(LENGTH(name)/2),1);