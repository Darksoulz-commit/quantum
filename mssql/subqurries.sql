/*
	sub query - query residing inside another query
		1. Subquery should be in paranthesis(
		2. Subquery should executed independently
        3. Subquery can be used in WHERE, FROM, SELECT
        FROM - Alice name
        SELECT - Subquery ,must return single value
*/
use BikeStores;
select * from customers;
select * from orders;
EXEC SP_HELP customers;

select
 c.customer_id
--,concat(c.first_name + ' ' + c.last_name)
from customers as c
where c.customer_id in (SELECT distinct o.customer_id FROM orders as o)


select
 o.customer_id as [Customer]
,count(*) as [Customer count]
from orders as o
group by o.customer_id
order by 2 

select
 c.customer_id
, c.first_name
 ,o.order_id
from customers as c
inner join orders as o 
on c.customer_id = o.customer_id


/*
	insert colums
*/

insert into customers(first_name,last_name,email)
select 'sudharsan','varma','sudhar@varma.com'

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
where t1.customer_id not in (SELECT distinct o.customer_id FROM orders as o)


-----------------------------------------------------------------------------------------------------------------------
select * from production.categories;
select * from production.products;

/*
list the max price of each category
*/

select p.product_id,product_name,c.category_id,c.category_name,max(list_price) as [Max Price] from production.products as p
inner join production.categories as c
on p.category_id = c.category_id
group by p.product_id,p.product_name,c.category_id,c.category_name
order by 3


select c.category_id,c.category_name,max(list_price) as [Max Price] from production.products as p
inner join production.categories as c
on p.category_id = c.category_id
group by c.category_id,c.category_name
order by 3


SELECT c.category_name, p.product_name,p.list_price AS max_price
FROM production.categories c
JOIN production.products p ON c.category_id = p.category_id
WHERE p.list_price = (
        SELECT MAX(p2.list_price)
        FROM production.products p2
        WHERE p2.category_id = c.category_id
    )
order by 1