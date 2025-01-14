create database sample
use sample;
drop database sample
use master

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
select  2,'Taylor Swift', 'F', 1234562890, 'America'
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



CREATE OR ALTER TRIGGER ALL_Students
ON Students
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Handling DELETE operation
    -- This captures rows that are deleted from the Students table
    IF EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO copy_student (StudentID, StudentName, Gender, mobile, City, Created, Updated, Operation)
        SELECT 
            d.StudentID,
            d.StudentName,
            d.Gender,
            d.mobile,
            d.City,
            d.Created,
            d.Updated,
            'DEL' -- Operation type for DELETE
        FROM DELETED AS d;
    END

    -- Handling INSERT operation
    -- This captures rows that are inserted into the Students table
    IF EXISTS (SELECT 1 FROM INSERTED)
    BEGIN
        INSERT INTO copy_student (StudentID, StudentName, Gender, mobile, City, Created, Updated, Operation)
        SELECT 
            i.StudentID,
            i.StudentName,
            i.Gender,
            i.mobile,
            i.City,
            i.Created,
            i.Updated,
            'INS' -- Operation type for INSERT
        FROM INSERTED AS i;
    END

    -- Handling UPDATE operation
    -- This captures rows that are updated, checking if any fields are changed
    IF EXISTS (SELECT 1 FROM INSERTED i INNER JOIN DELETED d ON i.StudentID = d.StudentID 
               WHERE 
                   (i.StudentName <> d.StudentName OR
                    i.Gender <> d.Gender OR
                    i.mobile <> d.mobile OR
                    i.City <> d.City OR
                    i.Created <> d.Created OR
                    i.Updated <> d.Updated))
    BEGIN
        INSERT INTO copy_student (StudentID, StudentName, Gender, mobile, City, Created, Updated, Operation)
        SELECT
            i.StudentID,
            i.StudentName,
            i.Gender,
            i.mobile,
            i.City,
            i.Created,
            i.Updated,
            'UPD' -- Operation type for UPDATE
        FROM INSERTED i
        INNER JOIN DELETED d ON i.StudentID = d.StudentID
        WHERE 
            (i.StudentName <> d.StudentName OR
             i.Gender <> d.Gender OR
             i.mobile <> d.mobile OR
             i.City <> d.City OR
             i.Created <> d.Created OR
             i.Updated <> d.Updated);
    END
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
--------------------------------------------------------------------
update Students set StudentName = 'quantum' where StudentID = 1
update Students set StudentName = 'Abdul Kalam' where StudentID = 4
