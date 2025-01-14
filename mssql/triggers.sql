/*
	triggers 
		are special kind of stored procedures,
		executed/fired suring dml
		save as a seperate recors to 

*/


create database students

use students;

create table Students(
      StudentID TINYINT 
    , StudentName varchar(100) not null
    , Gender char check(Gender in ('M','F'))
    , Mobile char(10) unique
    , City varchar(100) not null
    , Created datetime default getdate()
    , Updated datetime
    , CONSTRAINT PK_primaryKeyName PRIMARY KEY (StudentID) 
);

drop table Students;
drop table copy_student;

insert into Students (StudentID,StudentName, Gender, mobile, City)
select  1,'Sudharsan', 'M', 1234567890, 'Karur'
union
select  2,'Vasunthara', 'F', 1234562890, 'Karur'
union
select  3,'Manoj', 'M', 4567912850, 'Salem'
union
select  4,'Abdul', 'M', 1234563890, 'Madurai'
union
select  5,'Bharath', 'M', 1234564890, 'Trichy'
union
select  6,'Hari', 'M', 1234565890, 'Erode'



-- coping table

select * into copy_student from Students where 1=2;


-- adding table copy_students
alter table copy_student add Operation char(3);
alter table copy_student add adt_created datetime default Getdate()
alter table copy_student add adt_updated datetime ;

drop trigger trg_del_students
create or alter trigger trg_del_students
on Students
after delete
as
begin
	insert into copy_student(StudentID,StudentName, Gender, mobile, City, Created, Updated, Operation)
	select
		  d.StudentID
		, d.StudentName
		, d.Gender
		, d.mobile
		, d.City
		, d.Created
		, d.Updated
		, 'Del'
		from deleted as d
end;

drop trigger trg_upd_students
create or alter trigger trg_upd_students
on Students
after update
as
begin
	insert into copy_student(StudentID,StudentName, Gender, mobile, City, Created, Updated, Operation)
	select
		  u.StudentID
		, u.StudentName
		, u.Gender
		, u.mobile
		, u.City
		, u.Created
		, u.Updated
		, 'Upd'
		from deleted as u
end;

drop trigger trg_ins_students;
create or alter trigger trg_ins_students
on Students
after insert
as
begin
	insert into copy_student(StudentID,StudentName, Gender, mobile, City, Created, Updated, Operation)
	select
		  i.StudentID
		, i.StudentName
		, i.Gender
		, i.mobile
		, i.City
		, i.Created
		, i.Updated
		, 'Ins'
		from inserted as i
end;


set identity_insert Students on
set identity_insert Students off


alter table copy_student alter column StudentID tinyint
alter table copy_student drop DF__copy_stud__adt_c__44FF419A 


alter table copy_student add id tinyint

alter table copy_student drop column StudentID

exec sp_rename 'copy_student.id' , 'StudentID','column'

-- deleting
delete from Students where StudentID=6;
-- updating
update Students set StudentName = 'Abdul Kalam' where StudentID = 4
update Students set StudentName = 'quantum' where StudentID = 1
--inserting
insert into Students(StudentID,StudentName, Gender, mobile, City)
select 6,'Karan','M',1597534562,'Dindukal'




--------------------------------------------------------------------------------------------------------


/*
	create a trigger with all the 3 operatrions

*/


CREATE or alter TRIGGER ALL_Students
ON Students 
AFTER Update,Insert,delete
AS 
BEGIN
 
		insert into copy_student(StudentID,StudentName, Gender, mobile, City, Created, Updated, Operation)
	select
		  d.StudentID
		, d.StudentName
		, d.Gender
		, d.mobile
		, d.City
		, d.Created
		, d.Updated
		, 'DEL'
			FROM DELETED AS d

full outer join 
		--SELECT
		--  u.StudentID
		--, u.StudentName
		--, u.Gender
		--, u.mobile
		--, u.City
		--, u.Created
		--, u.Updated
		--	  ,'UPD'
		--	FROM DELETED AS u
		(SELECT
		  i.StudentID
		, i.StudentName
		, i.Gender
		, i.mobile
		, i.City
		, i.Created
		, i.Updated
			  ,'INS'
			FROM inserted) as t1
on  t1.StudentID = d.StudentID
where Operation ='DEl'
END;

truncate table copy_student;

select * from Students;
select * from copy_student


--inserting
insert into Students(StudentID,StudentName, Gender, mobile, City)
select 7,'sidarth','M',9597534562,'chennai'
-- deleting
delete from Students where StudentID=7;
-- updating
update Students set StudentName = 'sudharsan' where StudentID = 1
update Students set StudentName = 'Abdul' where StudentID = 4

update Students set StudentName = 'quantum' where StudentID = 1
update Students set StudentName = 'Abdul Kalam' where StudentID = 4
-----------------------------------------------------------
create or alter trigger alltriger
on Students
after insert, update, delete
as
begin
insert into copy_student(StudentID,StudentName, Gender, mobile, City, Created, Updated, Operation)
select
   isnull(d.StudentID,i.StudentID) as StudentID,
   isnull(d.StudentName,i.StudentName) as StudentID,
   isnull(d.Gender,i.Gender) as StudentID,
   isnull(d.mobile,i.mobile) as StudentID,
   isnull(d.City,i.City) as StudentID,
   isnull(d.Created,i.Created) as StudentID,
   isnull(d.Updated,i.Updated) as StudentID,
	case when d.StudentID is null then 'INS'
       when i.StudentID is null then 'DEL'
       When i.StudentID = d.StudentID then 'UPD'
   end as Operation
   from inserted as i
   full outer join deleted as d
   on i.StudentID = d.StudentID
end;
---------------------------------------------------------
ALTER TABLE copy_student
ADD 
    Old_StudentName NVARCHAR(255) NULL,
    Old_Gender NVARCHAR(50) NULL,
    Old_mobile NVARCHAR(50) NULL,
    Old_City NVARCHAR(100) NULL,
    Old_Created DATETIME NULL,
    Old_Updated DATETIME NULL;


CREATE OR ALTER TRIGGER alltriger
ON Students
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO copy_student (StudentID, StudentName, Gender, mobile, City, Created, Updated, Operation, Old_StudentName, Old_Gender, Old_mobile, Old_City, Old_Created, Old_Updated)
    SELECT
        ISNULL(d.StudentID, i.StudentID) AS StudentID,
        ISNULL(i.StudentName, d.StudentName) AS StudentName,
        ISNULL(i.Gender, d.Gender) AS Gender,
        ISNULL(i.mobile, d.mobile) AS mobile,
        ISNULL(i.City, d.City) AS City,
        ISNULL(i.Created, d.Created) AS Created,
        ISNULL(i.Updated, d.Updated) AS Updated,
        CASE 
            WHEN d.StudentID IS NULL THEN 'INS'
            WHEN i.StudentID IS NULL THEN 'DEL'
            WHEN i.StudentID = d.StudentID THEN 'UPD'
        END AS Operation,
        
        -- Old values for 'UPDATE' operations
        CASE 
            WHEN i.StudentID IS NOT NULL AND d.StudentID IS NOT NULL AND i.StudentID = d.StudentID THEN d.StudentName
            ELSE NULL 
        END AS Old_StudentName,
        
        CASE 
            WHEN i.StudentID IS NOT NULL AND d.StudentID IS NOT NULL AND i.StudentID = d.StudentID THEN d.Gender
            ELSE NULL 
        END AS Old_Gender,
        
        CASE 
            WHEN i.StudentID IS NOT NULL AND d.StudentID IS NOT NULL AND i.StudentID = d.StudentID THEN d.mobile
            ELSE NULL 
        END AS Old_mobile,
        
        CASE 
            WHEN i.StudentID IS NOT NULL AND d.StudentID IS NOT NULL AND i.StudentID = d.StudentID THEN d.City
            ELSE NULL 
        END AS Old_City,
        
        CASE 
            WHEN i.StudentID IS NOT NULL AND d.StudentID IS NOT NULL AND i.StudentID = d.StudentID THEN d.Created
            ELSE NULL 
        END AS Old_Created,
        
        CASE 
            WHEN i.StudentID IS NOT NULL AND d.StudentID IS NOT NULL AND i.StudentID = d.StudentID THEN d.Updated
            ELSE NULL 
        END AS Old_Updated

    FROM inserted AS i
    FULL OUTER JOIN deleted AS d
    ON i.StudentID = d.StudentID;
END;
