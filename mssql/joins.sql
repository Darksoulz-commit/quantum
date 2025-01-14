/*
	joins merge table or result set
		1. inner join
		2. outer join
			a. left outer join
			b. right outer join
			c. full outer join
		3. self join
		4. cross join
			one record in 1st table is maped to all records in 2nd table
			each single record in the 1st table is maped to all the record in the 2nd table
*/
use BikeStores
select * from customers
select * from orders
select * from staffs
select * from stores
select * from products
select * from brands
select * from order_items
/*
	list of customers who placed orders
*/

select
 c.customer_id
,concat(c.first_name,' ', c.last_name) as [Customer Name]
,o.order_id
,s.store_name
,concat(sf.first_name,' ', sf.last_name) as [Staff Name]
from customers as c

inner join orders as o 
on c.customer_id = o.customer_id

inner join stores as s
on o.store_id= s.store_id

inner join staffs as sf
on o.staff_id = sf.staff_id


/*
	customers who not placed the orders using left join
*/

select
 c.customer_id
,concat(c.first_name,' ', c.last_name) as [Customer Name]
,o.order_id
,o.order_date
from customers as c
left outer join orders as o 
on c.customer_id = o.customer_id
where o.order_date is null


--select * from customers where customer_id = 1446
--select * from orders  where customer_id = 1446


/*
	customers who not placed the orders using right join
*/

select
 c.customer_id
,concat(c.first_name,' ', c.last_name) as [Customer Name]
,o.order_id
,o.order_date
from orders as o
right outer join customers as c
on o.customer_id = c.customer_id 
where o.order_date is null


/*
	get everything from 2 tables
*/

select
 *
from customers as c
full outer join orders as o
on c.customer_id = o.customer_id 


/*
	show the manager and employee using self join 
*/

-- solution 1: by left outer join
select 
emp.staff_id as [Employee ID]
,emp.first_name + ' ' + emp.last_name as [employee]
,mgr.first_name + ' ' + mgr.last_name as [manager]
,mgr.staff_id as [Manager ID]
from staffs as emp 
left outer join staffs as mgr
on emp.manager_id = mgr.staff_id;

-- solution 1: by left outer join
select 
emp.staff_id as [Employee ID]
,emp.first_name + ' ' + emp.last_name as [employee]
,mgr.first_name + ' ' + mgr.last_name as [manager]
,mgr.staff_id as [Manager ID]
from staffs as mgr 
right outer join staffs as emp
on emp.manager_id = mgr.staff_id;



/* 
	one record in one table maped to all records in the 2 nd table aka cartesion
*/

--select * from products
--select * from brands

select 
* 
from products as p, brands as b
where p.product_id = 1 and b.brand_id in(1,5)


select * from customers
select * from orders
select * from order_items
select * from products
select *from brands
select * from stocks


select
  c.customer_id as [Customer ID]
, c.first_name + ' ' + c.last_name as [Full Name]
, oi.order_id as [Order ID]
, sum(oi.quantity * oi.list_price) as [Order Values]
from customers as c
inner join orders as o
on c.customer_id = o.customer_id
inner join order_items as oi
on o.order_id = oi.order_id
group by  
 c.customer_id 
,c.first_name + ' ' + c.last_name
,oi.order_id
having sum(oi.quantity * oi.list_price) > 20000
order by [Order Values] desc



select
  c.customer_id as [Customer ID]
, c.first_name + ' ' + c.last_name as [Full Name]
, oi.order_id as [Order ID]
, sum(oi.quantity * oi.list_price) as [Order Values]
, p.brand_id as [Brand ID]
, b.brand_name as [Brand Name]
from order_items as oi
inner join orders as o
on oi.order_id = o.order_id
inner join customers as c
on o.customer_id = c.customer_id
inner join products as p
on oi.product_id = p.product_id
left outer join brands as b
on p.brand_id = b.brand_id
group by  
 p.brand_id 
, b.brand_name 
order by [Order Values] desc

/*
	order values by brands
*/

select 
b.brand_id,
b.brand_name
,p.product_id
--,sum(oi.list_price * oi.quantity) as [sum of order values]
from brands as b
left outer join products as p on b.brand_id = p.brand_id
select * from order_items
inner join order_items as oi on p.product_id = oi.product_id
group by b.brand_id,b.brand_name
order by 3 desc

/*
year wise total sales
*/

select year(order_date) from orders
select * from orders


select
year(o.order_date) ,
 format(o.order_date,'MMMM'),
 sum(oi.list_price * oi.quantity) as [order values]
from orders as o
inner join order_items as oi
on o.order_id = oi.order_id
group by year(o.order_date),format(o.order_date,'MMMM'), MONTH(o.order_date)
order by 1 ,MONTH(o.order_date)


select 
b.brand_id as [Brand ID],
b.brand_name as [Brand Name],
rs = [sum of order values]
from brands as b
left outer join 
(select 
	p.brand_id as [brand id],
	sum(oi.list_price * oi.quantity) as [sum of order values]
from products as p 
inner join order_items as oi on p.product_id = oi.product_id
group by p.brand_id
) as rs
on b.brand_id= rs.[brand id]
order by 3 desc;


select 
oi.order_id
,oi.item_id
,oi.product_id
,oi.quantity
,oi.list_price
,oi.dis                                    
from order_items as oi
group by oi.order_id
,oi.item_id
,oi.product_id
,oi.quantity
,oi.list_price
,oi.discount

select *from brands
insert into brands(brand_id,brand_name)
select 12,'Hero'
insert into brands(brand_name)
select 13'Hero'

SELECT 
    b.brand_name AS [name]
	,count(b.brand_name) as [count of duplicates]
FROM brands AS b
GROUP BY b.brand_name
HAVING COUNT(b.brand_name) > 1;


select distinct * from brands

/*
	select the distinct records by using min and 
*/

select min(b.brand_id),min(b.brand_name)
FROM brands AS b
group by b.brand_name



drop table if exists brand2 ;

-- this one copies data and structure
select * into brand2  from(select * from brands) as t1 
where 1=1;

-- thisonle will copy only the structure
select * into brand2  from(select * from brands) as t1 
where 1=2

select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where TABLE_NAME = 'brand2'
   

SELECT
   TABLE_NAME,
    COLUMN_NAME

FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    TABLE_NAME = 'brand2'
    AND CONSTRAINT_NAME = 'PRIMARY';


insert into brand2(brand_name)
select 'Hero'
insert into brand2(brand_name)
select 'Hero'
select * from brand2

/*
this will delete the dups but it will delete the og recd too
*/
DELETE FROM brand2
WHERE brand_name IN (
    SELECT brand_name
    FROM brand2
    GROUP BY brand_name
    HAVING COUNT(brand_name) > 1
);


/*
	using the rownumbers to delete the dups
*/
with cte_duplicates as(
select 
t1.brand_id
,t1.brand_name
,ROW_NUMBER() over (partition by t1.brand_name order by t1.brand_name) as xRows
from brand2 as t1
)

delete from cte_duplicates
where xRows >1
select * from brand2
/*
	THIS WILL DELETE THE DUPS AND JOIN 
*/
--DELETE b
select *
FROM brand2 b
JOIN (
    SELECT MIN(brand_id) AS brand_id, brand_name
    FROM brand2
    GROUP BY brand_name
    HAVING COUNT(*) > 1
) dup
ON b.brand_name = dup.brand_name
WHERE b.brand_id > dup.brand_id;


/*
	second highest list price
*/

select *from products;

with cte_duplicates as(
select 
t1.product_id
,t1.list_price
--,row_number() over (order by t1.list_price desc) as rowk_nums
,dense_rank() over (order by t1.list_price desc) as dense_nums
--,rank() over (order by t1.list_price desc) as rank_nums
--,ntile(10) over (order by t1.list_price desc) as ntile_nums
from products as t1
)
select * from cte_duplicates
where dense_nums<=10


/*
	top 10 orders by customers
*/
select * from order_items;
select * from orders;

with cte_duplicates as(
select 
oi.order_id
,sum(oi.quantity * oi.list_price) as [Sales]
,dense_rank() over (order by sum(oi.quantity * oi.list_price) desc) as dense_nums
from order_items as oi
)
select * from cte_duplicates
where dense_nums<=10


/*
	top 10 orders by customers with ct
*/

with cte_sales as(
	select 
	oi.order_id
	,sum(oi.quantity * oi.list_price) as [Sales]
	from order_items as oi
	group by oi.order_id)
, cte_customers as (
select 
c.customer_id
,c.first_name + ' ' + c.last_name as Customers
,s.Sales as Sales
,DENSE_RANK() over (order by s.Sales desc) as dense_nums
from customers as c 
inner join orders as o 
on c.customer_id = o.customer_id 
inner join cte_sales as s on o.order_id = s.order_id
)

select * from cte_customers
--where dense_nums <=10



SELECT 
    o.order_id,
	c.first_name + ' ' + c.last_name as name
    ,SUM(oi.list_price * oi.quantity) AS total
FROM orders AS o
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
INNER JOIN customers AS c ON c.customer_id = o.customer_id
GROUP BY o.order_id, c.first_name + ' ' + c.last_name
ORDER BY total desc;




select 
oi.order_id
,sum(oi.quantity * oi.list_price) as [Sales]
from order_items as oi
inner join orders as o 
on oi.order_id = o.order_id
inner join customers as c
on o.customer_id = c.customer_id
group by oi.order_id
order by 2 ;





/*
	bottom 10 orders by customers with ct
*/

with cte_sales as(
	select 
	oi.order_id
	,sum(oi.quantity * oi.list_price) as [Sales]
	from order_items as oi
	group by oi.order_id)
, cte_customers as (
select 
c.customer_id
,c.first_name + ' ' + c.last_name as Customers
,s.Sales as Sales
,DENSE_RANK() over (order by s.Sales ) as dense_nums
from customers as c 
inner join orders as o 
on c.customer_id = o.customer_id 
inner join cte_sales as s on o.order_id = s.order_id
)

select * from cte_customers
where dense_nums <=10

select oi.order_id, sum(oi.quantity * oi.list_price) as [Sales]
from order_items as oi
group by oi.order_id
order by 2 desc


/*
	calculate the year wise month wise sales with present previous and next month sales
	the 1 in the lag mentions the number of steps
*/


with cte_yearsales as(
select 
year(o.order_date) as [year]
 ,format(o.order_date,'MMMM') as [month]
,LAG(sum(oi.list_price * oi.quantity),1 ) over (order by year(o.order_date),MONTH(o.order_date) ) as [previous values]
 ,sum(oi.list_price * oi.quantity) as [current sales]
,LEAD(sum(oi.list_price * oi.quantity) ) over (order by year(o.order_date),MONTH(o.order_date) ) as [next sales]
from orders as o
inner join order_items as oi
on o.order_id = oi.order_id
group by year(o.order_date),format(o.order_date,'MMMM'), MONTH(o.order_date)
)
select * from cte_yearsales

/*
	display the last traction in a day
*/
Create table Trans(
		id int,
		amount money,
		trans_date DATETIME);
 
insert into Trans(id,amount,trans_date)
values
(1,1000,'2024-03-11 10:30:45'),
(2,2000,'2024-03-11 11:00:00'),
(3,500,'2024-03-11 12:15:10'),
(4,1500,'2024-03-12 12:20:15'),
(5,5400,'2024-03-12 13:00:00'),
(6,3500,'2024-03-12 14:25:40'),
(7,1750,CURRENT_TIMESTAMP),
(8,890,'2024-03-21 16:30:00'),
(9,725,'2024-03-21 13:38:45'),
(10,1040,'2024-03-22 12:15:08'),
(11,500,'2024-03-22 14:05:10'),
(12,2600,'2024-03-22 14:05:20');
 
--select * from Trans
 
 
WITH cte_secondduplicates2 AS (
    SELECT distinct
		FIRST_VALUE(id) OVER (PARTITION BY CAST(trans_date AS DATE) ORDER BY trans_date desc) AS ID	,
        FIRST_VALUE(trans_date) OVER (PARTITION BY CAST(trans_date AS DATE) ORDER BY trans_date desc) AS FirstTransDate,
		FIRST_VALUE(amount) OVER (PARTITION BY CAST(trans_date AS DATE) ORDER BY trans_date desc) AS Amount
    FROM Trans
)
SELECT * FROM cte_secondduplicates2;

select * from customers
where customer_id not between 1 and 10




