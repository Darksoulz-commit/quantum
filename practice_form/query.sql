--create database BikeStores;
--use BikeStores;
/*
	Retrieve all records from the brands table
*/

select * from production.brands;

/*
List all products with a list price greater than $1000
*/
select * from production.products as p where p.list_price > 1000

/*
Find all customers who live in New York (NY).
*/
select c.first_name + ' ' + c.last_Name, c.city  from sales.customers as c where c.city = 'New York'
select c.first_name + ' ' + c.last_Name, c.state  from sales.customers as c where c.state = 'NY'

/*
	Display the names and email addresses of all customers.
*/

select c.first_name+ '' + c.last_Name as [Name], c.email from sales.customers as c

/*
Retrieve all orders placed in the year 2016.
*/
select * from sales.orders as o where year(o.order_date) = 2016

/*
	List all products that belong to the 'Mountain Bikes' category.
*/

select p.product_id,p.product_name,c.category_id,c.category_name from production.products as p
inner join production.categories as c
on p.category_id = c.category_id
where c.category_name = 'Mountain Bikes'

/*
	Find the total number of products in each category.
*/

select count(p.product_id) as [Products], c.category_id, c.category_name from production.products as p
inner join production.categories as c
on p.category_id = c.category_id
group by c.category_id,c.category_name 


/*
	Retrieve the details of the product with the highest list price.
*/
select top 1 * from production.products order by list_price desc


/*
	List all orders along with the customer names who placed them.
*/
SELECT * FROM sales.customers
SELECT * FROM sales.orders

SELECT c.customer_id, c.first_name + ' ' + c.last_name as Name,o.order_id, o.order_date from sales.customers as c
inner join sales.orders as o
on c.customer_id = o.customer_id


/*
	Find all products that were listed in the year 2017.
*/
select * from production.products where model_year = '2017'
------------------------------------------------------------------------------------------------------------------------

/*
	Calculate the average list price of all products.
*/

SELECT AVG(list_price) AS [Average]
FROM production.products;


/*
Find the total quantity of each product sold.
*/

select p.product_id,p.product_name,count(oi.quantity) as [Quantity] from production.products as p
inner join sales.order_items as oi
on p.product_id = oi.product_id
group by p.product_id,p.product_name
order by 3 desc


/*
	Calculate the total sales amount for each store.
*/


select  
	s.store_id
	,s.store_name
	,sum(oi.quantity* oi.list_price* oi. discount) as [sales amount]
from sales.orders as o 
inner join sales.order_items as oi 
on o.order_id = oi.order_id 
inner join sales.stores as s 
on o.store_id = s.store_id
group by 	s.store_id
	,s.store_name

/*
Find the number of orders placed by each customer.
*/




SELECT c.customer_id, c.first_name + ' ' + c.last_name as Name, count(o.order_id) as [Orders] from sales.customers as c
inner join sales.orders as o
on c.customer_id = o.customer_id
group by c.customer_id, c.first_name + ' ' + c.last_name
order by 1

/*
5. Calculate the total discount given on all orders.
*/

SELECT order_id, SUM(quantity * list_price * discount ) AS total_discount
FROM sales.order_items group by order_id;

/*
6. Find the average list price of products in each category.
*/



select c.category_name ,avg(p.list_price) as [Average]
from production.products as p
inner join production.categories as c
on p.category_id = c.category_id
group by c.category_name


/*
7. Retrieve the total number of orders placed in each month of 2016.
*/

select  DATENAME(MONTH, o.order_date) AS [MonthName], count(o.order_id) from sales.orders as o WHERE 
    YEAR( o.order_date) = 2016 group by   DATENAME(MONTH, o.order_date) 


/*
	8. Calculate the total revenue generated from each product category
*/


SELECT 
	c.category_id
    ,c.category_name
    ,SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM sales.order_items as oi
inner join production.products as p 
ON oi.product_id = p.product_id
inner join production.categories as c 
ON p.category_id = c.category_id
GROUP BY c.category_id,c.category_name
order by 1


/*
9.Find the total number of customers in each state.
*/
select state,count(customer_id) as customers from sales.customers group by state


/*
10.Calculate the total quantity of products sold in each year
*/

select year(order_date) as [year],count(oi.quantity ) [Total quantity]
from sales.orders as o
inner join sales.order_items as oi
on o.order_id = oi.order_id
group by year(order_date)
order by 1
-----------------------------------------------------------------------------------------------------
/*
1. Retrieve all orders along with the product details.
*/


select
    o.order_id,
    o.order_date,
    p.product_name,
    c.category_name,
    b.brand_name
from sales.orders o
inner join sales.order_items oi 
ON o.order_id = oi.order_id
inner join production.products p 
ON oi.product_id = p.product_id
inner join production.categories c 
ON p.category_id = c.category_id
inner join production.brands b ON 
p.brand_id = b.brand_id
order by o.order_id

/*
2. List all customers along with the orders they have placed.
*/

select 
c.customer_id,  c.first_name + ' ' + c.last_name as Name, o.order_id, o.order_date
from sales.customers as c
left outer  join sales.orders as o
on c.customer_id = o.customer_id

/*
3. Find all products that have never been ordered
*/

select * from production.products
select * from sales.orders

select * from sales.order_items

select p.product_id,p.product_name,oi.order_id 
from production.products as p
full outer join sales.order_items as oi
on p.product_id = oi.product_id 
where oi.order_id is null
order by 1

/*
	4. Retrieve the details of all orders along with the store and staff details
*/

select * from sales.orders
select * from sales.staffs
select * from sales.stores

select o.order_id, stf.staff_id, stf.first_name + ' '+ stf.last_name as [Staff Name], sto.store_id, sto.store_name
from sales.orders as o
left outer join sales.staffs as stf
on o.staff_id = stf.staff_id
left outer join sales.stores as sto
on o.store_id  = sto.store_id

/*
5. List all products along with their brand and category names.
*/
select * from production.products
select * from production.brands
select * from production.categories

select 
p.product_name,b.brand_name,c.category_name
from production.products p
inner join production.brands b 
ON p.brand_id = b.brand_id
inner join production.categories c 
ON p.category_id = c.category_id
ORDER BY p.product_name;

/*
6. Find all customers who have placed more than 5 orders.
*/

select c.customer_id,c.first_name + ' ' + c.last_name as name, count(o.order_id) AS total_orders
from sales.customers c
inner join sales.orders o ON c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name, c.email, c.phone
having COUNT(o.order_id) > 5

/*
7. Retrieve the details of all orders placed by customers from California (CA).
*/

select c.customer_id,c.first_name + ' ' + c.last_name as name, c.state
from sales.customers c
inner join sales.orders o ON c.customer_id = o.customer_id
where c.state = 'CA'


/*
8. List all products along with the total quantity sold for each product.
*/

select p.product_id, p.product_name, SUM(oi.quantity) AS [total quantity sold]
from production.products p
inner join sales.order_items as oi 
on p.product_id = oi.product_id
group by p.product_id, p.product_name
order by [total quantity sold] desc;


/*
9. Find all orders that include products from the 'Electric Bikes' category.
*/

SELECT 
    o.order_id,o.order_date,p.product_id,p.product_name,c.category_name
from sales.orders o
inner join sales.order_items oi 
on o.order_id = oi.order_id
inner join production.products p 
on oi.product_id = p.product_id
inner join production.categories c 
on p.category_id = c.category_id
where c.category_name = 'Electric Bikes'

/*
10. Retrieve the details of all orders along with the total discount applied.
*/

select o.order_id,o.order_date,SUM(oi.quantity * oi.list_price * (oi.discount)) AS total_discount
from sales.orders o
inner join sales.order_items oi ON o.order_id = oi.order_id
group by o.order_id, o.order_date, o.required_date, o.shipped_date, o.order_status
order by 1,3 desc;

------------------------------------------------------------------------------------
/*
1. Find the product with the second highest list price.
*/
select list_price from production.products order by 1 desc

select  p.product_id,p.product_name,p.list_price
from production.products p
where p.list_price = ( select max(list_price) from production.products where list_price not in (select max(list_price) from production.products))


/*
2. Retrieve the details of the most expensive product in each category.
*/

select p.product_id,p.product_name,p.list_price,c.category_name
from production.products p
inner join production.categories c on p.category_id = c.category_id
where p.list_price = (select max(list_price) from production.products where category_id = p.category_id)
order by c.category_name;


/*
3. Find all customers who have never placed an order.
*/


select c.customer_id,c.first_name,o.order_id, o.customer_id from sales.customers as c
right outer join sales.orders as o
on c.customer_id = o.customer_id

select c.customer_id,c.first_name,c.last_name
from sales.customers as c
left join sales.orders as o on c.customer_id = o.customer_id
where o.order_id IS NULL;

SELECT 
    c.customer_id,c.first_name,c.last_name
FROM sales.customers as c
WHERE NOT EXISTS (SELECT 1 FROM sales.orders as o WHERE o.customer_id = c.customer_id);

SELECT c.customer_id,c.first_name,c.last_name
FROM sales.customers as c
WHERE c.customer_id NOT IN (SELECT o.customer_id FROM sales.orders o);

/*
4. List all products that have been ordered more than 10 times.
*/


SELECT p.product_id,p.product_name
FROM production.products p
WHERE p.product_id IN 
(SELECT oi.product_id FROM sales.order_items oi GROUP BY oi.product_id HAVING count(oi.order_id) > 10);

/*
5. Retrieve the details of the latest order placed by each customer.
*/


WITH LatestOrders AS (
SELECT o.order_id as order_id,o.customer_id as customer_id,o.order_date as order_date,
ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date DESC) AS rn
FROM sales.orders o
)
SELECT  order_id,customer_id,order_date  FROM LatestOrders as lo
WHERE lo.rn = 1
order by order_id;

/*
6. Find the total revenue generated from orders placed in the first quarter of 2016.
*/

SELECT SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM sales.order_items as oi
WHERE oi.order_id IN (SELECT o.order_id FROM sales.orders as o WHERE o.order_date BETWEEN '2016-01-01' AND '2016-03-31');


/*
7. List all products that have a list price higher than the average list price.
*/

SELECT p.product_id,p.product_name, p.list_price
FROM production.products p
WHERE p.list_price > (SELECT AVG(list_price) FROM production.products);

/*
8. Retrieve the details of all orders placed in the last month.
*/

select  order_id,convert(varchar(20),order_date,106) as [month]
from sales.orders
where month(order_date)=12
order by 1


/*
9. Find the customer who has placed the highest number of orders.
*/




select 
c.customer_id,c.first_name,c.last_name,
count(o.order_id) as total_orders
from sales.customers c
inner join sales.orders as o on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name
having count(o.order_id) = (
select max(order_count)
from(select count(*) as order_count
from sales.orders
group by customer_id) as subquery);

/*
10. List all products that belong to brands that have more than 5 products
*/

select p.product_id,p.product_name,p.list_price,p.brand_id
from production.products p
where p.brand_id IN (select brand_id from production.products group by brand_id having count(*) > 5);
-------------------------------------------------------------------------------------------------------------------------

/*
1. Calculate the total revenue generated from each customer
*/

select 
o.customer_id,c.first_name+' '+c.last_name as [Full name],sum(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
from sales.orders o
inner join sales.order_items oi on o.order_id = oi.order_id
inner join production.products p on oi.product_id = p.product_id
inner join sales.customers c on o.customer_id = c.customer_id
group by o.customer_id, c.first_name+' '+c.last_name 



/*
2. Find the top 5 products with the highest total sales.
*/

with cte_duplicates as (
select oi.product_id,p.product_name,
sum(oi.quantity * oi.list_price * (1 - oi.discount)) as Sales,
DENSE_RANK() over (order by sum(oi.quantity * oi.list_price * (1 - oi.discount)) desc) as dense_nums
from sales.order_items oi
inner join production.products p on oi.product_id = p.product_id
group by oi.product_id, p.product_name
)
select * 
from cte_duplicates
where dense_nums <= 5;

/*
3. Retrieve the details of all orders that include more than 3 different products.
*/
select  o.order_id,o.customer_id,o.order_date
from sales.orders o
inner join sales.order_items oi on o.order_id = oi.order_id
group by o.order_id, o.customer_id, o.order_date
having count(distinct oi.product_id) > 3;

/*
4. Calculate the total discount given to each customer.
*/
select 
o.customer_id,c.first_name,c.last_name,
sum(oi.quantity * oi.list_price * oi.discount) as total_discount
from  sales.orders o
inner join sales.order_items oi on o.order_id = oi.order_id
inner join sales.customers c on o.customer_id = c.customer_id
group by o.customer_id, c.first_name, c.last_name;

/*
5. Find the average list price of products for each brand.
*/

select b.brand_name,AVG(p.list_price) as average_list_price
from production.products p
inner join production.brands b on p.brand_id = b.brand_id
group by b.brand_name
order by 2

/*
6. Retrieve the details of all orders placed in the last 7 days
*/
select top 7 * from sales.orders order by order_date desc

/*
7. Find the total quantity of products sold in each store.
*/
select s.store_id,s.store_name,sum(oi.quantity) as total_quantity_sold
from sales.stores s
inner join sales.orders o on s.store_id = o.store_id
inner join sales.order_items oi on o.order_id = oi.order_id
group by s.store_id, s.store_name
order by 1;

/*
8. Calculate the total revenue generated from each product in each year
*/
select
p.product_name,p.model_year,sum(ot.quantity * ot.list_price * (1-ot.discount)) as [Revenue]
from [production].[products] as p
inner join  sales.order_items as ot 
on p.product_id = ot.product_id
group by p.product_name,p.model_year

/*
9. Find the top 3 customers with the highest total order value.
*/

select top 3 customer_id,count(order_id) as [count]   from sales.orders 
group by customer_id

/*
10. Retrieve the details of all orders that include products from more than one category
*/


with cte_ord as ( select order_id ,count(product_id) as [count]  from sales.order_items
group by order_id)
select * from cte_ord
where [count]  > 3
--------------------------------------------------------------------------------------

/*
1. Insert a new product into the products table.
*/
insert into production.products (product_name, brand_id, category_id, model_year, list_price)
select 'tesla 1177', 1, 3, 2025, 799.99


/*
2. Update the list price of all products in the 'Road Bikes' category by 10%
*/

update production.products
set list_price = list_price * 1.10
where category_id = (select category_id from production.categories where category_name = 'Road Bikes');

/*
3. Delete all orders placed before 2016.
*/

delete from sales.orders
where order_date < '2016-01-01';

/*
4. Insert a new customer into the customers table
*/

insert into sales.customers (first_name, last_name, phone, email, street, city, state, zip_code)
select'neil', 'tyson', '1234567890', 'neil.tyson@example.com', '123 Main St', 'Anytown', 'CA', '12345'
select * from sales.customers order by 1 desc
/*
5. Update the email address of a customer.
*/

update sales.customers
set email = 'newemail@example.com'
where customer_id = 1445;

/*
6. Delete a product from the products table
*/
select * from production.products

delete from production.products where product_id = 322

/*
7. Insert a new order into the orders table.
*/

insert into sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id)
select  1, 1, '2025-01-07', '2025-01-14', 2, 3

/*
8. Update the quantity of a product in an order
*/
update sales.order_items
set quantity = 5
where order_id = 1 ;

select * from sales.order_items

/*
9. Delete a customer from the customers table
*/
delete from sales.customers
where customer_id = 1;

/*
10. Insert a new category into the categories table.
*/
insert into production.categories (category_name)
select 'Electric cars'
-----------------------------------------------------------------------------------------------------------------
/*
1. Create a function to calculate the total sales for a given product.
*/
create proc CalculateTotalSalesForProduct
    @ProductID int
as
begin
    -- Declare a variable to store the total sales
    declare @TotalSales decimal(18, 2);
    
    -- Calculate the total sales for the given product
    select @TotalSales = sum(oi.quantity * oi.list_price)
    from sales.order_items oi
    where oi.product_id = @ProductID;

    -- Return the total sales
    select @TotalSales as TotalSales;
end;

EXEC CalculateTotalSalesForProduct @ProductID = 1;

/*
2. Write a stored procedure to retrieve all orders for a given customer
*/
CREATE or alter PROCEDURE GetAllOrders
AS
BEGIN
    SELECT 
        o.order_id,
        o.customer_id,
        c.first_name AS customer_first_name,
        c.last_name AS customer_last_name,
        o.order_date
       
    FROM 
        sales.orders o
    INNER JOIN 
        sales.customers c ON o.customer_id = c.customer_id
    ORDER BY 
        o.order_date DESC;
END;

EXEC GetAllOrders;

/*
3. Create a function to calculate the average list price of products in a given category.
*/
CREATE or alter PROCEDURE avg_lp
AS
BEGIN
    SELECT 
        c.category_name,
        AVG(p.list_price) AS average_list_price
    FROM 
        production.categories c
    LEFT JOIN 
        production.products p ON c.category_id = p.category_id
    GROUP BY 
        c.category_name
    ORDER BY 
        c.category_name;
END;


EXEC avg_lp;


/*
4. Write a stored procedure to insert a new order.
*/
CREATE OR ALTER PROCEDURE i(
    @customer_id AS INT,
    @order_status AS TINYINT,
    @order_date AS DATE,
    @required_date AS DATE,
    @store_id AS INT,
    @staff_id AS INT
)
AS
BEGIN
    BEGIN TRY

        INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id)
        VALUES (@customer_id, @order_status, @order_date, @required_date, @store_id, @staff_id);

        PRINT CAST(@@ROWCOUNT AS VARCHAR(100)) + ' rows are inserted.';
        PRINT 'New order ID: ' + CAST(SCOPE_IDENTITY() AS VARCHAR(100));
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred during insert: ' + ERROR_MESSAGE();
    END CATCH
END;
DECLARE @xcustomer_id AS INT = 136,
        @xorder_status AS TINYINT = 3,
        @xorder_date AS DATE = '2025-01-14',
        @xrequired_date AS DATE = '2025-02-14',
        @xstore_id AS INT = 1,
        @xstaff_id AS INT = 7;


EXEC i @xcustomer_id, @xorder_status, @xorder_date, @xrequired_date, @xstore_id, @xstaff_id;

/*
5. Create a function to calculate the total discount given on all orders.
*/

select * from sales.order_items

select oi.order_id,sum(oi.quantity* oi.list_price * (1-oi.discount)) as Discount from sales.order_items as oi
group by oi.order_id;

DROP FUNCTION IF EXISTS dbo.order_discount;

CREATE OR ALTER FUNCTION dbo.order_discount()
RETURNS TABLE
AS
RETURN
(
    SELECT
        oi.order_id,
        SUM(oi.quantity * oi.list_price * (1-oi.discount)) AS total_discount
    FROM sales.order_items AS oi
    GROUP BY oi.order_id
);

SELECT * FROM dbo.order_discount();


/*
6. Write a stored procedure to update the list price of a product.
*/
CREATE OR ALTER PROCEDURE dbo.UpdateProductPrice
    @product_id INT,
    @new_list_price DECIMAL(10, 2)
AS
BEGIN
    -- Start a transaction (optional, for consistency)
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Update the list price for the given product
        UPDATE production.products
        SET list_price = @new_list_price
        WHERE product_id = @product_id;

        -- Commit the transaction
        COMMIT TRANSACTION;
        PRINT 'Product price updated successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors and roll back the transaction
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
        ROLLBACK TRANSACTION;
    END CATCH
END;

EXEC dbo.UpdateProductPrice @product_id = 101, @new_list_price = 49.99;

/*
7. Create a function to calculate the total quantity sold for a given product.
*/
select * from sales.order_items as oi
select oi.product_id,count(oi.quantity) from sales.order_items as oi
group by oi.product_id order by 1


CREATE OR ALTER FUNCTION dbo.product_quantity()
RETURNS TABLE
AS
RETURN
(
    
    SELECT
       oi.product_id,count(oi.quantity)  as [count]
   from sales.order_items as oi
   group by oi.product_id

);

SELECT * FROM dbo.product_quantity();


/*
8. Write a stored procedure to delete an order.
*/

select * from sales.orders

CREATE OR ALTER PROCEDURE dbo.deleteorder
    @order_id INT
   
AS
BEGIN
    -- Start a transaction (optional, for consistency)
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Update the list price for the given product
        delete from  sales.orders 
		WHERE order_id = @order_id;

        -- Commit the transaction
        COMMIT TRANSACTION;
        PRINT 'order deleted successfully.';
    END TRY
    BEGIN CATCH
        -- Handle errors and roll back the transaction
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
        ROLLBACK TRANSACTION;
    END CATCH
END;

EXEC dbo.deleteorder @order_id = 1680

/*
9. Create a function to calculate the total revenue generated from a given category.
*/
SELECT  p.category_id,SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as revenue
    FROM sales.order_items AS oi
    JOIN production.products AS p ON oi.product_id = p.product_id
    WHERE p.category_id = p.category_id
	group by p.category_id



CREATE OR ALTER FUNCTION dbo.category_revenue()
RETURNS table
AS
return
    (
    SELECT  p.category_id,SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as revenue
    FROM sales.order_items AS oi
    JOIN production.products AS p ON oi.product_id = p.product_id
    WHERE p.category_id = p.category_id
	group by p.category_id
   )

select * from dbo.category_revenue()


/*
10. Write a stored procedure to retrieve all products in a given category.
*/

select p.product_id,p.product_name,c.category_id,c.category_name from production.products as p
inner join production.categories as c
on p.category_id = c.category_id

CREATE OR ALTER PROCEDURE dbo.deleteorder
AS
BEGIN
   select p.product_id,p.product_name,c.category_id,c.category_name from production.products as p
inner join production.categories as c
on p.category_id = c.category_id
END;

EXEC dbo.deleteorder

select * from production.products

---------------------------------------------------------------

/*
1. Create an index on the products table for the list_price column.
*/

CREATE INDEX idx_list_price
ON production.products (list_price);

select * from production.products

/*
2. Analyze the query execution plan for retrieving all orders.
*/
SET SHOWPLAN_ALL ON;

SELECT * 
FROM sales.orders;

SET SHOWPLAN_ALL OFF;

SET STATISTICS PROFILE ON;

SELECT * 
FROM sales.orders;

SET STATISTICS PROFILE OFF;

/*
3. Optimize a query to retrieve the top 10 most expensive products.
*/
CREATE INDEX idx_list_price_desc ON production.products (list_price DESC);

WITH RankedProducts AS (
    SELECT 
        product_id,
        product_name,
        list_price,
        ROW_NUMBER() OVER (ORDER BY list_price DESC) AS row_num
    FROM production.products
)
SELECT 
    product_id,
    product_name,
    list_price
FROM RankedProducts
WHERE row_num <= 10;

/*
4. Create an index on the orders table for the order_date column.
*/


CREATE INDEX idx_order_date
ON sales.orders(order_date);

/*
5. Analyze the query execution plan for calculating the total sales for each store.
*/

SET SHOWPLAN_ALL ON;
go
 
SELECT 
    s.store_id,
    s.store_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM 
    sales.stores s
JOIN 
    sales.orders o ON s.store_id = o.store_id
JOIN 
    sales.order_items oi ON o.order_id = oi.order_id
JOIN 
    production.products p ON oi.product_id = p.product_id
GROUP BY 
    s.store_id, s.store_name
ORDER BY 3 DESC;
go
 
SET SHOWPLAN_ALL OFF;


/*
6. Optimize a query to retrieve all customers who have placed more than 5 orders.
*/

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(o.order_id) AS order_count
FROM 
    sales.customers c
JOIN 
    sales.orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, c.email
HAVING 
    COUNT(o.order_id) > 5
ORDER BY 
    order_count DESC;

/*
7. Create an index on the customers table for the state column.
*/

CREATE INDEX idx_state
ON sales.customers(state);

/*
8. Analyze the query execution plan for retrieving all products in a given category
*/
SET SHOWPLAN_ALL ON;
select p.product_id,p.product_name,c.category_id,c.category_name from production.products as p
inner join production.categories as c 
on p.category_id = c.category_id
go
SET STATISTICS PROFILE ON;
select p.product_id,p.product_name,c.category_id,c.category_name from production.products as p
inner join production.categories as c 
on p.category_id = c.category_id
SET SHOWPLAN_ALL OFF
go
SET STATISTICS PROFILE OFF;

/*
9. Optimize a query to calculate the total revenue generated from each product.
*/
CREATE INDEX idx_order_items_product_id ON sales.order_items (product_id);
CREATE INDEX idx_products_product_id ON production.products (product_id);

SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM 
    sales.order_items oi
JOIN 
    production.products p ON oi.product_id = p.product_id
GROUP BY 
    p.product_id, p.product_name
ORDER BY 
    total_revenue DESC;

/*
10.Create an index on the orders table for the customer_id column.
*/
CREATE INDEX idx_customer_id ON sales.customers (customer_id);

-------------------------------------------------------------------------------------
--Data Analysis

/*
1. Find the trend of total sales over the years.
*/

SELECT 
    YEAR(o.order_date) AS year,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM 
    sales.orders o
JOIN 
    sales.order_items oi ON o.order_id = oi.order_id
GROUP BY 
    YEAR(o.order_date)
ORDER BY 
    year;

/*
2. Analyze the distribution of product prices.
*/
select p.product_id,p.product_name,p.list_price from production.products as p
order by 3 desc

SELECT 
    MIN(list_price) AS min_price,
    MAX(list_price) AS max_price,
    AVG(list_price) AS avg_price,
    STDEV(list_price) AS price_std_dev
FROM 
    production.products;

/*
3. Find the correlation between product price and quantity sold.
*/
select * from production.products
select * from sales.order_items
WITH Price_Quantity AS (
    SELECT 
        p.product_id,
        p.list_price AS price,
        SUM(oi.quantity) AS total_quantity
    FROM 
        production.products p
    JOIN 
        sales.order_items oi ON p.product_id = oi.product_id
    GROUP BY 
        p.product_id, p.list_price
)
SELECT 
    SUM(price) AS sum_price,
    SUM(total_quantity) AS sum_quantity,
    SUM(price * total_quantity) AS sum_price_quantity,
    SUM(price * price) AS sum_price_squared,
    SUM(total_quantity * total_quantity) AS sum_quantity_squared,
    COUNT(*) AS N
FROM Price_Quantity;

/*
4. Analyze the sales performance of each store
*/
WITH Sales_Performance AS (
    SELECT 
        o.store_id, 
        SUM(oi.quantity * oi.list_price) AS total_sales,
        SUM(oi.quantity) AS total_quantity_sold,
        COUNT(DISTINCT o.order_id) AS number_of_orders 
    FROM 
        sales.orders o
    JOIN 
        sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        o.store_id
)

SELECT 
    sp.store_id,
    s.store_name,
    sp.total_sales,
    sp.total_quantity_sold,
    sp.number_of_orders,
    sp.total_sales / sp.number_of_orders AS average_order_value
FROM 
    Sales_Performance sp
JOIN 
    sales.stores s ON sp.store_id = s.store_id
ORDER BY 
    sp.store_id;  

/*
5. Find the most popular product category
*/


select c.category_name,sum(oi.quantity) as popular_category from sales.order_items as oi
inner join production.products as p
on oi.product_id = p.product_id
inner join production.categories as c
on p.category_id = c.category_id
group by c.category_name
order by 2 desc

/*
6. Analyze the purchasing behavior of customers from different states.
*/


WITH sta AS (
    SELECT 
        c.state, 
        SUM(oi.quantity * oi.list_price) AS total_sales,
        SUM(oi.quantity) AS total_quantity_sold,
        COUNT(DISTINCT o.order_id) AS number_of_orders,
        SUM(oi.quantity * oi.list_price * oi.discount) AS total_discount
    FROM 
        sales.customers c
    JOIN 
        sales.orders o ON c.customer_id = o.customer_id
    JOIN 
        sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        c.state
)

SELECT 
    state,
    total_sales,
    total_quantity_sold,
    number_of_orders,
    total_sales / number_of_orders  AS average_order_value,
    total_discount
FROM 
    sta
ORDER BY 
    total_sales DESC; 

/*
7. Find the trend of total orders placed each month.
*/
SELECT 
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    COUNT(o.order_id) AS total_orders
FROM 
    sales.orders o
GROUP BY YEAR(o.order_date),MONTH(o.order_date)
ORDER BY order_year ASC

/*
8. Analyze the impact of discounts on total sales
*/

WITH Sales_Impact AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.list_price) AS total_sales,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS discounted_sales,
        SUM(oi.quantity * oi.list_price * oi.discount) AS total_discount,
        COUNT(o.order_id) AS total_orders
    FROM sales.orders o
    JOIN sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
)

SELECT 
    COUNT(order_id) AS total_orders,
    SUM(total_sales) AS total_sales,
    SUM(discounted_sales) AS discounted_sales,
    SUM(total_discount) AS total_discount,
    (SUM(total_sales) - SUM(discounted_sales)) AS lost_revenue_due_to_discount,
	(SUM(total_sales) - SUM(discounted_sales)) / SUM(total_sales) * 100 AS percentage_lost_due_to_discount
FROM Sales_Impact;

/*
9. Find the most frequently ordered product.
*/
SELECT TOP 1 p.product_id,p.product_name,SUM(oi.quantity) AS total_quantity_ordered
FROM sales.order_items oi
JOIN production.products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_ordered DESC;

/*
10. Analyze the sales performance of each brand.
*/
SELECT 
    b.brand_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.quantity * oi.list_price) AS total_sales,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.list_price * oi.discount) AS total_discount_given,
    AVG(oi.list_price) AS average_price
FROM sales.order_items oi
JOIN production.products p ON oi.product_id = p.product_id
JOIN production.brands b ON p.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY total_sales DESC;
 -----------------------------------------------------------------------------------------------------
/*
 Miscellaneous
*/

/*
1. Retrieve the details of all orders that were shipped late
*/

SELECT 
	 *
FROM sales.orders
WHERE shipped_date > required_date;

 /*
2. Find the total number of products that have been discontinued.
*/

select * from production.products 
where product_id not in (select product_id from sales.order_items)
 
/*
3. Retrieve the details of all customers who have not placed an order in the last year.
*/

select c.*
      ,year(o.order_date) as [year]
      from sales.customers as c 
          left join sales.orders as o on c.customer_id = o.customer_id
      where year(o.order_date) = 2018
 
/*
4. Find the total revenue generated from orders placed on weekends.
*/

SELECT SUM(soi.quantity * soi.list_price * (1 - soi.discount)) AS TotalWeekendRevenue
FROM sales.order_items AS soi
INNER JOIN sales.orders AS so
ON soi.order_id = so.order_id
WHERE DATEPART(dw, order_date) = 1;

/*
5. Retrieve the details of all products that have been ordered in the last month.
*/

select * from sales.orders 
where month(order_date) = 12
 
/*
6. Find the total quantity of products sold in each quarter.
*/

SELECT 
    DATEPART(YEAR, so.order_date) AS Year,
    DATEPART(QUARTER, so.order_date) AS Quarter,
    SUM(soi.quantity) AS TotalQuantitySold
FROM sales.orders AS so
INNER JOIN sales.order_items AS soi
ON so.order_id = soi.order_id
GROUP BY DATEPART(YEAR, order_date), DATEPART(QUARTER, order_date)
ORDER BY Year, Quarter;
 
/*
7. Retrieve the details of all orders that include products from the 'Children Bicycles' category.
*/
select o.*,p.category_id from sales.orders as o 
inner join  sales.order_items as ot 
on o.order_id = ot.order_id
inner join production.products as p 
on ot.product_id = p.product_id
where p.category_id = (select category_id from production.categories
where category_name = 'Children Bicycles')
 
/*
8. Find the total revenue generated from each customer in each year.
*/

select year(o.order_date),c.first_name+' '+c.last_name as full_name ,
    sum((ot.list_price*ot.quantity)*(1-(ot.discount)))  as total_sales
from sales.customers as c 
left join sales.orders as o on c.customer_id = o.customer_id
inner join sales.order_items as ot on o.order_id = ot.order_id
group by year(o.order_date),c.first_name+' '+c.last_name
 
/*
9. Retrieve the details of all orders that were placed but not shipped.\
*/

select * from sales.orders where shipped_date is null

/* 
10. Find the total number of products that belong to each brand
*/
select c.category_name,count(p.product_id) as [number of products] from production.categories as c 
left join production.products as p on c.category_id = p.category_id
group by c.category_name

-----------------------------------------------------------------------------------------------------------------

/*
Joins (Set 2)
*/
/*
1. Retrieve all orders along with the customer and store details.
*/

select o.order_id,o.order_date,c.customer_id,c.first_name,s.store_id,s.store_name from sales.orders as o
inner join sales.customers as c
on o.customer_id = c.customer_id
inner join sales.stores as s
on o.store_id = s.store_id

/*
2. List all products along with their brand, category, and the total quantity sold.
*/
SELECT 
    p.product_id,
    p.product_name,
    b.brand_name,
    c.category_name,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold
FROM 
    production.products p
JOIN 
    production.brands b ON p.brand_id = b.brand_id
JOIN 
    production.categories c ON p.category_id = c.category_id
LEFT JOIN 
    sales.order_items oi ON p.product_id = oi.product_id
GROUP BY 
    p.product_id, p.product_name, b.brand_name, c.category_name
ORDER BY 
    p.product_name;


/*
3. Find all customers who have placed orders for products from more than one category.
*/
SELECT c.customer_id,c.first_name,c.last_name,c.email
FROM sales.customers c
JOIN sales.orders o 
ON c.customer_id = o.customer_id
JOIN sales.order_items oi 
ON o.order_id = oi.order_id
JOIN production.products p 
ON oi.product_id = p.product_id
JOIN production.categories cat
ON p.category_id = cat.category_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(DISTINCT cat.category_id) > 1;

/*
4. Retrieve the details of all orders along with the product, brand, and category details.
*/
SELECT 
    o.order_id,o.order_date,oi.item_id,p.product_id,p.product_name,b.brand_name,c.category_name,oi.quantity,oi.list_price,oi.discount,
    (oi.quantity * oi.list_price * (1 - oi.discount)) AS total_price
from sales.orders as o
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN production.products p ON oi.product_id = p.product_id
JOIN production.brands b ON p.brand_id = b.brand_id
JOIN production.categories c ON p.category_id = c.category_id

/*
5. List all customers along with the total value of orders they have placed.
*/

SELECT 
    c.customer_id,c.first_name,c.last_name,c.email,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_order_value
FROM sales.customers c
JOIN sales.orders o ON c.customer_id = o.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email

/*
6. Find all stores that have sold products from the 'Electric Bikes' category
*/
SELECT DISTINCT s.store_id,s.store_name,s.city,s.state,s.zip_code
FROM sales.stores s
JOIN production.stocks st ON s.store_id = st.store_id
JOIN production.products p ON st.product_id = p.product_id
JOIN production.categories c ON p.category_id = c.category_id
WHERE c.category_name = 'Electric Bikes';

/*
7. Retrieve the details of all orders along with the customer and product details, sorted by order date
*/
SELECT 
    o.order_date,
    c.first_name + ' ' + c.last_name as Name,
    (oi.quantity * oi.list_price * (1 - oi.discount)) AS total_price,
    p.product_name,
    b.brand_name,
    ca.category_name
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN production.products p ON oi.product_id = p.product_id
JOIN production.brands b ON p.brand_id = b.brand_id
JOIN production.categories ca ON p.category_id = ca.category_id
ORDER BY o.order_date DESC

/*
8. List all products that have been ordered by customers from California (CA).
*/
select p.product_name,o.order_date,c.state from sales.orders as o
inner join sales.order_items as oi
on o.order_id = oi.order_id
inner join production.products as p
on oi.product_id = p.product_id
inner join sales.customers as c
on o.customer_id = c.customer_id
where c.state = 'CA'

/*
9. Find all orders that include products from brands that have more than 10 products.
*/
select * from sales.orders 
select * from sales.order_items
select * from production.products
select * from production.categories

WITH a AS (
    SELECT p.brand_id,COUNT(p.product_id) AS product_count
    FROM production.products p
    GROUP BY p.brand_id
    HAVING COUNT(p.product_id) > 10
)
SELECT 
    o.order_id,o.order_date,c.customer_id,c.first_name,c.last_name,oi.item_id,oi.quantity,oi.list_price,oi.discount,
    (oi.quantity * oi.list_price * (1 - oi.discount)) AS total_price,
    p.product_id,p.product_name,b.brand_name,ca.category_name
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN production.products p ON oi.product_id = p.product_id
JOIN production.brands b ON p.brand_id = b.brand_id
JOIN production.categories ca ON p.category_id = ca.category_id
JOIN a bpc ON p.brand_id = bpc.brand_id
ORDER BY o.order_date DESC, o.order_id, oi.item_id;

/*
10. Retrieve the details of all orders along with the total quantity and total price for each order.
*/
SELECT o.order_date,c.first_name,c.last_name,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_price
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN production.products p ON oi.product_id = p.product_id
GROUP BY o.order_date,c.first_name,c.last_name

-----------------------------------------------------------------------------------------------------------
--Joins (Set 3)
/*
1. List all customers who have ordered products from the 'Mountain Bikes' category.
*/
select 	 so.customer_id as [all customers],pp.product_id as [all products],pc.category_name as [category name] 
from sales.orders as so 
inner join sales.order_items as soi 
on so.order_id=soi.order_id 
inner join production.products as pp 
on soi.product_id=pp.product_id 
inner join production.categories as pc 
on pp.category_id=pc.category_id 
where pc.category_name='mountain bikes' 
order by 1;

/*
2. Find the total revenue generated from each store, including store details.
*/
select
	 ss.store_id as [store id]
	,ss.store_name as [store name]
	,sum((soi.list_price*soi.quantity)*(1-soi.discount)) as [revenue]
from sales.stores as ss inner join sales.orders as so
on ss.store_id=so.store_id
inner join sales.order_items as soi
on so.order_id=soi.order_id
group by ss.store_id,ss.store_name
order by 1;

/*
3. Retrieve the details of all orders placed by customers who live in New York (NY).
*/

select sc.city as [city],so.*
from sales.customers as sc inner join sales.orders as so
on sc.customer_id=so.customer_id
where sc.city='ny';

/*
4. List all products along with the total quantity sold and the total revenue generated for each product.
*/
  select
	 pp.product_id as [proid]
	,soi.quantity as [totalsold]
	,sum((soi.list_price*soi.quantity)*(1-soi.discount))  as [total revenue]
from sales.order_items as soi inner join production.products as pp
on soi.product_id=pp.product_id
group by pp.product_id,soi.quantity;

/*
5. Find all orders that include products from more than one brand. 
*/

select
	 soi.order_id as [all orders]
	,count(pb.brand_id) as [count]
from sales.order_items as soi inner join production.products as pp
on soi.product_id =pp.product_id
inner join production.brands as pb
on pp.brand_id=pb.brand_id
group by soi.order_id
having count(pb.brand_id)>1
order by 1;

/*
6. Retrieve the details of all orders along with the customer, product, and store details.
*/

select SO.order_id as [orders],sc.*,pp.*,ss.*
from sales.customers as sc inner join sales.orders as so
on sc.customer_id =so.customer_id
inner join sales.stores as ss
on so.store_id=ss.store_id
inner join sales.order_items as soi
on so.order_id =soi.order_id
inner join production.products as pp
on soi.product_id=PP.product_id;
 
/*
7. List all customers who have placed orders for products from the 'Road Bikes' category
*/
select so.customer_id as [all customers],pc.category_name as [name]
from sales.orders as so inner join sales.order_items as soi
on so.order_id=soi.order_id
inner join production.products as pp
on soi.product_id=pp.product_id
inner join production.categories as pc
on pp.category_id=pc.category_id
where pc.category_name ='road bikes';

/*
8. Find the total quantity of products sold in each store, including store details
*/

select ss.store_id as [store],sum(soi.quantity) as [quantity]
from sales.stores as ss inner join sales.orders as so
on ss.store_id =so.store_id
inner join sales.order_items as soi
on so.order_id=soi.order_id
group by SS.store_id
ORDER BY 1;

/*
--9. Retrieve the details of all orders placed in the last year along with the customer and product details. 
*/

select 	 so.order_id as [allorders] 	
,sc.customer_id as [customer id] 	
,pp.product_id as [product id] 	
,year(so.order_date) as [year] 
from sales.customers as sc 
inner join sales.orders as so 
on sc.customer_id = so.customer_id 
inner join sales.order_items as soi 
on so.order_id =soi.order_id 
inner join production.products as pp 
on soi.product_id=pp.product_id 
group by so.order_id,sc.customer_id,pp.product_id,year(so.order_date)
order by 4 desc;

/*
10. List all products that have been ordered by customers from more than one state.
*/ 
select
	 soi.product_id as [proid]
	,count(sc.state) as [count]
from sales.customers as sc inner join sales.orders as so
on sc.customer_id =so.customer_id
inner join sales.order_items as soi
on so.order_id=soi.order_id
group by soi.product_id
having count(sc.state)>1;

/*
11. Find all orders that include products from the 'Children Bicycles' category.
*/
SELECT 
    o.order_id,o.order_date,c.first_name,c.last_name,p.product_name,p.list_price,oi.quantity,oi.discount,
    (oi.quantity * oi.list_price * (1 - oi.discount)) AS total_price
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN production.products p ON oi.product_id = p.product_id
JOIN production.categories cat ON p.category_id = cat.category_id
WHERE cat.category_name = 'Children Bicycles'
ORDER BY o.order_date DESC, o.order_id, oi.item_id;

/*
12. Retrieve the details of all orders along with the total discount applied and the customer details.
*/

SELECT 
    o.order_id,o.order_date,c.first_name,c.last_name,c.email,c.phone,
    SUM(oi.quantity * oi.list_price * oi.discount) AS total_discount
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN production.products p ON oi.product_id = p.product_id
GROUP BY o.order_id,o.order_date,c.first_name,c.last_name,c.email,c.phone
ORDER BY o.order_date DESC, o.order_id;

/*
13. List all customers who have placed orders for products from more than one brand.
*/
SELECT c.customer_id,c.first_name,c.last_name,c.email,c.phone
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN production.products p ON oi.product_id = p.product_id
JOIN production.brands b ON p.brand_id = b.brand_id
GROUP BY c.customer_id,c.first_name,c.last_name,c.email,c.phone
HAVING COUNT(DISTINCT b.brand_id) > 1
ORDER BY c.customer_id;

/*
14. Find the total revenue generated from each product category, including category details.
*/
SELECT cat.category_id,cat.category_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM sales.order_items oi
JOIN production.products p ON oi.product_id = p.product_id
JOIN production.categories cat ON p.category_id = cat.category_id
GROUP BY cat.category_id,cat.category_name
ORDER BY total_revenue DESC;

/*
15. Retrieve the details of all orders placed by customers who have ordered more than 5 different 
products
*/
WITH CustomerProductCount AS (
    SELECT o.customer_id,COUNT(DISTINCT oi.product_id) AS distinct_products_ordered
    FROM sales.orders o
    JOIN sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id
    HAVING COUNT(DISTINCT oi.product_id) > 5
)
SELECT o.order_id,o.order_date,c.first_name,c.last_name
	FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN CustomerProductCount cpc ON o.customer_id = cpc.customer_id
ORDER BY o.order_date DESC;
