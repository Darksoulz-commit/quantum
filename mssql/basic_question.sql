/*
	starts with a to p
*/

select * from customers
where first_name like '[a-p]%'

/*
	starts with a r j
*/
select * from customers
where first_name like '[a,r,j]%'


/*
	starts with not a to p
*/
select * from customers
--where first_name not like '[a-p]%'
where first_name like '[^a-p]%'

/*
	ends with nd only has 4 letters
*/
select * from customers
where city like '_____nd'

/*
	containing middle at @
*/

select * from customers
where email like '%@%'

/*
	conver 2025-01-04 as 4 jan 2025
*/
select convert(varchar(100),order_date,106) from orders as o


/*
	conver 2025-01-04 as 2025/01/04
*/
select convert(varchar(100),order_date,111) from orders as o


/*
	show only the time
*/
select convert(varchar(100),getdate(),108)

/*
	date format
*/
select format(getdate(),'yyyy')
select year(getdate()) as xyear,datepart(month,getdate()) as xmonth,datepart(day,getdate()) as xday
select convert(varchar(100),getdate(),108)

/*
	date difference
*/
declare @startdate as date = '2024-12-01'
select datediff(dd,@startdate,GETDATE())

select DATEPART(MM,getdate())
select FORMAT(getdate(),'MMM')

-- full outer join
select p.projectName, e.FirstName from projects as p
full outer join employees as e on p.employeedetailid = e.employeeid
where p.projectDetailid is null or e.employeeid is null

-- left and right join
SELECT p.projectName, e.FirstName
FROM projects AS p
LEFT JOIN employees AS e
ON p.employeedetailid = e.employeeid
WHERE p.projectDetailid IS NULL 
   OR e.employeeid IS NULL

UNION

SELECT p.projectName, e.FirstName
FROM projects AS p
RIGHT JOIN employees AS e
ON p.employeedetailid = e.employeeid
WHERE p.projectDetailid IS NULL 
   OR e.employeeid IS NULL;

-- using subquerry
   SELECT p.projectName, 
       (SELECT e.FirstName 
        FROM employees e
        WHERE e.employeeid = p.employeedetailid) AS FirstName
FROM projects p
WHERE p.projectDetailid IS NULL
   OR p.employeedetailid NOT IN (SELECT e.employeeid FROM employees e);





   create table employees (
    Employee_ID int not null primary key	
   ,FirstName	varchar(100)
   ,LastName	varchar(100)
   ,Salary	decimal(9,2)
   ,Joining_Date datetime 
   ,Department	varchar(50)
   ,Gender varchar(50)
   )

   create table projects(
    ProjectDetailId int primary key
   , EmployeeDetailID int
   ,ProjectName varchar(100)
   ) 

   select * from employees
   select * from projects


select * 
from 
    (select 1 as a
     union all
     select 1 as a) as t1
left outer join 
    (select 1 as a
     union all
     select 1 as a
     union all
     select 1 as a) as t2
on t1.a = t2.a;

SELECT 
	  A.ID 
	, A.Name
	,B.ID 
	, B.Name 
FROM table1 A 
INNER JOIN table2 B
ON A.ID = B.ID
SELECT COUNT(*) + COUNT(*)