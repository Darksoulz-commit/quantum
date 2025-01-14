/*
	set operators appending thr result set
		1. Union
		2. Union all
		3. INtersection
		4. Except

	merge -- joins 
	append -- set operators
*/

use BikeStores;5

select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id between 1 and 10
union
select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id between 11 and 20
union
select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id between 21 and 30
order by [fullname]


-- intersect
select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id =1
intersect
(
select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id = 1
union all
select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id = 1
union all
select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id = 2
union all
select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id = 3
)
order by [fullname];


-- Except
(
	select customer_id,first_name+' '+last_name as [fullname]
	from customers where customer_id = 1
	union all
	select customer_id,first_name+' '+last_name as [fullname]
	from customers where customer_id = 1
	union all
	select customer_id,first_name+' '+last_name as [fullname]
	from customers where customer_id = 2
	union all
	select customer_id,first_name+' '+last_name as [fullname]
	from customers where customer_id = 3
)
except
select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id =1
order by [fullname];



select customer_id,first_name+' '+last_name as [fullname]
from customers where customer_id =1
except
(
	select customer_id,first_name+' '+last_name as [fullname]
	from customers where customer_id = 1
	union all
	select customer_id,first_name+' '+last_name as [fullname]
	from customers where customer_id = 4
	union all
	select customer_id,first_name+' '+last_name as [fullname]
	from customers where customer_id = 2
	union all
	select customer_id,first_name+' '+last_name as [fullname]
	from customers where customer_id = 3
)
order by [fullname]


/*
	views -aka- virtual tables
	many thinbgs in a single view
*/
select top 10 * from products;
select * from brands;
select * from categories;

select  top 10
p.product_id
,p.product_name
,p.brand_id
,p.category_id
,b.brand_id
,b.brand_name
,c.category_id
,c.category_name
from products as p
left outer join
brands as b on p.brand_id = b.brand_id
left outer join
categories AS c on p.category_id = c.category_id;


create or alter view vm_sample_top_10 as 
select
		p.product_id
		,p.product_name
		,p.brand_id
		,p.category_id
		,p.list_price as [list price]
		,DENSE_RANK() over (order by p.list_price desc) as lp
		,b.brand_name
		,c.category_name
		from products as p
		left outer join brands as b on p.brand_id = b.brand_id
		left outer join categories AS c on p.category_id = c.category_id;


select * from vm_sample_top_10
where lp<=10

create or alter view vm_sample_bottom_10 as 
select
		p.product_id
		,p.product_name
		,p.brand_id
		,p.category_id
		,p.list_price as [list price]
		,DENSE_RANK() over (order by p.list_price) as lp
		,b.brand_name
		,c.category_name
		from products as p
		left outer join brands as b on p.brand_id = b.brand_id
		left outer join categories AS c on p.category_id = c.category_id;

select  * from vm_sample_bottom_10
where lp<=10




select * from order_items
select * from products


create or alter view vw_performance
as
select 
		p.product_id As [Product ID],
		p.product_name as [Product Name],
		sum(oi.list_price*oi.quantity) AS [Total],
		p.model_year as [Model year]
 
from order_items as oi 
Right Outer Join  products as p on oi.product_id=p.product_id 
group by p.product_id,
		 p.product_name,
		 p.model_year,
		 oi.order_id
 
with cte_top5 as(
select 
	[Product ID],
	[Product Name],
	sum([Total])as [Order value],
	DENSE_RANK() over(order by sum([Total]) desc) as xrank
from vw_performance
where [Model year] =2016
group by  [Product ID],
		  [Product Name])
 
select  * from cte_top5
where xrank <=5

/*
T sql Transaction sql
	stored procedures

*/
 
create or alter proc sample_data
as
begin
	select * from customers
end;
exec sample_data
 
declare @FirstName as varchar(100)
set @FirstName = 'sudhar'
print 'name: '+ @FirstName;
select @FirstName
 
declare @a as int =100
declare @b as int =9
declare @result as int = null
set @result = @a % @b
print @result;
select @FirstName;
 
use BikeStores
 
select * from customers order by 1 desc
 
create or alter proc i(
	@fname as varchar(100),
	@lname as varchar(100),
	@mobile as char(10) =null,
	@email as varchar(100)
)
as 
begin
	begin try
	insert into customers(first_name,last_name,phone,email)
	select @fname,@lname,@mobile,@email
	print cast(@@rowcount as varchar(100))+ ' rows are inserted'
	print 'new customer' + cast(scope_identity() as varchar(100))
	end try
 
	begin catch
		select 'Error occured during insert'
	end catch
end
 
declare @result as varchar(100) = 'sudh',
		@lastName as varchar(100) = 'quantum',
		@mobileno as char(10) = null,
		@emailid as varchar(100) = 'test@test.com'
 
exec i @result,@lastName,@mobileno,@emailid

create or alter proc p(
	@bname as varchar(100),
	@cname as varchar(100),
	@pname as varchar(100),
	@modelyear as smallint,
	@price as decimal(9,2)
)
as 
begin
	declare
		@brandres as varchar(100) = null,
		@categoryres as varchar(100) = null
	begin try
 
	insert into brands(brand_name)
	select @bname
	print cast(@@rowcount as varchar(100))+ ' rows are inserted'
	print 'new customer' + cast(scope_identity() as varchar(100))
	set @brandres = SCOPE_IDENTITY()
 
	insert into categories(category_name)
	select @cname
	print cast(@@rowcount as varchar(100))+ ' rows are inserted'
	print 'new customer' + cast(scope_identity() as varchar(100))
	set @categoryres = SCOPE_IDENTITY()
 
	insert into products(product_name,brand_id,category_id,model_year,list_price)
	select @pname,@brandres,@categoryres,@modelyear,@price
	print cast(@@rowcount as varchar(100))+ ' rows are inserted'
	print 'new customer' + cast(scope_identity() as varchar(100))
	set @categoryres = SCOPE_IDENTITY()
	end try
 
	begin catch
		select 'Error occured during insert'
	end catch
end
 
declare @brandname as varchar(100) = 'bullet',
		@categoryname as varchar(100) = 'bike',
		@productname as varchar(100) = 'bullet 199',
		@modelyears as smallint = 2020,
		@listprice  as decimal(9,2) = 50000.00

 
exec p @brandname,@categoryname,@productname,@modelyears,@listprice
 
 
select * from brands order by 1 desc
select * from categories order by 1 desc
select * from products order by 1 desc

 
---------------------------------------------------------------------------------------------
 
CREATE OR ALTER PROCEDURE procedure_pro(
    @bname AS VARCHAR(100),
    @brandres AS INT OUT
)
AS
BEGIN
    BEGIN TRY
        -- Insert the brand into the 'brands' table
        INSERT INTO brands(brand_name)
        VALUES (@bname);

        -- Set the output parameter to the newly inserted brand_id
        SET @brandres = SCOPE_IDENTITY();

        -- Print success messages
        PRINT CAST(@@ROWCOUNT AS VARCHAR(100)) + ' rows are inserted';
        PRINT 'New brand ID: ' + CAST(@brandres AS VARCHAR(100));
    END TRY
    BEGIN CATCH
        -- Handle any errors that occur during the insertion
        SELECT 'Error occurred during insert: ' + ERROR_MESSAGE();
    END CATCH
END

-- Step 1: Declare the variable for brand_id and insert the brand
DECLARE @brandres AS INT;
EXEC procedure_pro 'hero honda', @brandres = @brandres OUT;

 --------------------------------------

CREATE OR ALTER PROCEDURE category_pro(
    @cname AS VARCHAR(100),
    @categoryres AS INT OUT
)
AS
BEGIN
    BEGIN TRY
        -- Insert the category into the 'categories' table
        INSERT INTO categories(category_name)
        VALUES (@cname);

        -- Set the output parameter to the newly inserted category_id
        SET @categoryres = SCOPE_IDENTITY();

        -- Print success messages
        PRINT CAST(@@ROWCOUNT AS VARCHAR(100)) + ' rows are inserted';
        PRINT 'New category ID: ' + CAST(@categoryres AS VARCHAR(100));
    END TRY
    BEGIN CATCH
        -- Handle any errors that occur during the insertion
        SELECT 'Error occurred during insert: ' + ERROR_MESSAGE();
    END CATCH
END

-- Step 2: Declare the variable for category_id and insert the category
DECLARE @categoryres AS INT;
EXEC category_pro 'bikes', @categoryres = @categoryres OUT;


-----------------------------------------------------------

CREATE OR ALTER PROCEDURE product_pro(
    @pname AS VARCHAR(100),
    @brandid AS INT,
    @categoryid AS INT,
    @modelyears AS SMALLINT,
    @listprice AS DECIMAL(9, 2)
)
AS
BEGIN
    BEGIN TRY
        -- Insert the product into the 'products' table using the provided brand_id and category_id
        INSERT INTO products(product_name, brand_id, category_id, model_year, list_price)
        VALUES (@pname, @brandid, @categoryid, @modelyears, @listprice);

        -- Print success messages
        PRINT CAST(@@ROWCOUNT AS VARCHAR(100)) + ' rows are inserted';
        PRINT 'New product ID: ' + CAST(SCOPE_IDENTITY() AS VARCHAR(100));
    END TRY
    BEGIN CATCH
        -- Handle any errors that occur during the insertion
        SELECT 'Error occurred during insert: ' + ERROR_MESSAGE();
    END CATCH
END



-- Step 3: Insert the product using the brand_id and category_id
EXEC product_pro 'splender plus', @brandres, @categoryres, 2020, 50000.00;


-------------------------------------------------------------------------


CREATE OR ALTER PROCEDURE brand_pro(
    @bname AS VARCHAR(100),
    @brandres AS INT OUT
)
AS
BEGIN
    BEGIN TRY
        -- Insert the brand into the 'brands' table
        INSERT INTO brands(brand_name)
        VALUES (@bname);

        -- Set the output parameter to the newly inserted brand_id
        SET @brandres = SCOPE_IDENTITY();

        -- Print success messages
        PRINT CAST(@@ROWCOUNT AS VARCHAR(100)) + ' rows are inserted';
        PRINT 'New brand ID: ' + CAST(@brandres AS VARCHAR(100));
    END TRY
    BEGIN CATCH
        -- Handle any errors that occur during the insertion
        SELECT 'Error occurred during insert: ' + ERROR_MESSAGE();
    END CATCH
END




select * from products
select * from customers






--Insert valuues into products using stored procedure (Using Multiple Procedure)
 
 
--STORED PROCEDURE TO INSERT VALUES IN BRANDS
Create or alter procedure INSERTBRANDS(
		@BRANDNAME AS VARCHAR(100),
		@YBRANDID AS INT OUT
)
AS 
BEGIN
	BEGIN TRY
 
	Insert into brands(brand_name) 
	Select @BRANDNAME
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	set @YBRANDID=SCOPE_IDENTITY()
	print 'New Brand: '+ cast( @YBRANDID as Varchar(50))
 
	END TRY
 
	BEGIN CATCH
		Select 'Error Occured during Insert into Brand'
	END CATCH
END;
 
 
DECLARE @BID AS INT
exec INSERTBRANDS 'YAHAMA',@YBRANDID=@BID OUT
PRINT @BID
 
SELECT * FROM brands
SELECT * FROM categories
 
 
--STORED PROCEDURE TO INSERT VALUES IN CATEGORIES
Create or alter procedure INSERTCATEGORIES(
		@CATEGORYNAME AS VARCHAR(100),
		@YCATEGORYID AS INT OUT
)
AS 
BEGIN
	BEGIN TRY
 
	Insert into categories(category_name) 
	Select @CATEGORYNAME
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	set @YCATEGORYID=SCOPE_IDENTITY()
	print 'New Category: '+ cast( @YCATEGORYID as Varchar(50))
 
	END TRY
 
	BEGIN CATCH
		Select 'Error Occured during Insert into Brand'
	END CATCH
END;
 
DECLARE @CID AS INT
exec INSERTCATEGORIES 'ELECTRONICS',@YCATEGORYID=@CID OUT
PRINT @CID
 
--STORED PROCEDURE TO INSERT VALUES IN PRODUCTS
 
Create or alter procedure INSERTPRODUCTS(
	@BRAND_NAME AS VARCHAR(50),
	@CATEGORY_NAME AS VARCHAR(50),
	@PRODUCTNAME AS VARCHAR(100),
	@MODELYEAR AS Smallint,
	@LISTPRICE AS DECIMAL(9,2)
 
)
AS 
BEGIN
	declare @BID as int,
			@CID as int
	BEGIN TRY
	exec INSERTBRANDS @BRAND_NAME,@YBRANDID=@BID OUT
	exec INSERTCATEGORIES @CATEGORY_NAME,@YCATEGORYID=@CID OUT
 
 
	insert into products(product_name,brand_id,category_id,model_year,list_price)
	select @PRODUCTNAME,@BID,@CID,@MODELYEAR,@LISTPRICE
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	print 'New Product: '+ cast(SCOPE_IDENTITY() as Varchar(50))
 
	END TRY
 
	BEGIN CATCH
		Select 'Error Occured during Insert into Brand'
	END CATCH
END;
 
 brandres = 1

exec INSERTPRODUCTS 'APACHE','BIKE','Two wheeler',2018,290000;
 
select * from brands order by 1 desc;
select * from categories order by 1 desc;
select * from products order by 1 desc;



 










