select * from INFORMATION_SCHEMA.TABLES;
select * from customers;
select * from orders;
use BikeStores
/*
	-- DQL select
*/

/*
	-- SCENARIO: Retrive Customers, who city is New York
*/

SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where t1.city = 'New York'

/*
	-- SCENARIO: Retrive Customers, who customer id is 518
*/

SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where t1.customer_id = 518


/*
	-- SCENARIO: Retrive how many number of Customers are there
*/

SELECT  count(*) as [Total Customers]
from customers;


/*
	-- SCENARIO: Retrive Total customers, email, phone
*/

SELECT  
	   count(*) as [Total Customers ea=mail]
	 , count(t.email) as [Email ID]
	 , count(t.phone) as [Phone Number]
from customers as t;


/*
	-- SCENARIO: Retrive Customers who dont have the mobile number
*/

SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where t1.phone IS NULL


/*
	-- SCENARIO: Retrive total Customers who have the mobile number
*/

SELECT
	count(*) as [with number]
from customers as t1
where t1.phone IS NOT NULL


/*
	-- SCENARIO: list of orders 2017-03-15
*/

SELECT 
	  o.order_id
	, o.customer_id
	, o.order_status
	, o.order_date
	, o.required_date
	, o.shipped_date
	, o.store_id
	, o.staff_id
from orders as o where o.order_date = '2017-03-15';


/*
	-- SCENARIO: list customers who belons to state - NY, CA, TX
*/

-- Solution 1:
SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where t1.state IN ('NY','CA','TX') ;

-- Solution 2:
SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where t1.state = 'NY' OR t1.state = 'CA' OR t1.state = 'TX' ;


/*
	-- SCENARIO: list customers who not belongs to state - NY
*/

-- SOlution 2:
SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where t1.state != 'NY' ; -- we can use <>

-- SOlution 2:
SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where NOT (t1.state = 'NY');


/*
	-- SCENARIO: list customers who not belongs to state - NY and CA
*/

--solution 1:
SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where t1.state NOT IN('NY','CA');

--solution 2:
SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where t1.state != 'NY' and t1.state <> 'CA';

--solution 3
SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where NOT (t1.state = 'NY') AND NOT (t1.state = 'NY');

--solution 4
SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where NOT (t1.state IN ('NY','CA'));

--solution 5
SELECT 
	  t1.customer_id as [Customer ID]
	, t1.first_name [First Name]
	, t1.last_name [Last Name]
	, t1.phone [Phone Number]
	, t1.email [Email Address]
	, t1.street [Street]
	, t1.city [City]
	, t1.state [State]
	, t1.zip_code [Zip Code]
from customers as t1
where t1.state IN (SELECT distinct state FROM customers where state NOT IN ('NY','CA'));



/*
	-- SCENARIO: total customers in each state
*/

select
c.state
,count(*) as [Number of customers]
from customers as c
group by state

/*
	-- SCENARIO: total customers in each state in each city
*/

select
c.state
,c.city
,count(*) as [Number of customers]
from customers as c
group by c.state,c.city;


/*
	-- SCENARIO: total customers in each state in each city in an ascending
*/

--solution 1
select
c.state
,c.city
,count(*) as [Number of customers]
from customers as c
group by c.state,c.city order by state;

--solution 2: order by position
select
c.state
,c.city
,count(*) as [Number of customers]
from customers as c
group by c.state,c.city order by 1,3 asc;


--solution 2: order by position
select
c.state
,count(*) as [Number of customers]
from customers as c
group by c.state
having count(*) > 1000
order by 1,2;