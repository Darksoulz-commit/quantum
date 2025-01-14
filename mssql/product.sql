create database bikes;
use bikes;

/*
	create a seperate table of product name and product price
*/

CREATE TABLE Products(
	ProductId INT IDENTITY(1,1),
    ProductName VARCHAR(100) NOt NUll,
	PRIMARY KEY(ProductId)
);

INSERT INTO Products (ProductName)
SELECT 'Yamaha'
UNION
SELECT 'Hro'
UNION
SELECT 'Ktm'
UNION
SELECT 'Bajaj'

select * from Products;


-----------------------------------------------------------------------------------------------------------------


CREATE TABLE Price(
	PricetId INT IDENTITY(1,1),
	ProductId INT,
    ProductPrice INT NOt NUll,
	PRIMARY KEY(PricetId),
	CONSTRAINT FK_ProductColorID
	FOREIGN KEY(ProductId) REFERENCES Products(ProductId) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Price (ProductId,ProductPrice)
SELECT 1,1000
UNION
SELECT 2,2000
UNION
SELECT 3,3000
UNION
SELECT 4,4000
--UNION0
--SELECT 5,5000

select * from Price;

truncate table Price;

select * from Products;
select * from Price;

drop table Products;
drop table Price;

-- inner join
select *
from Products as t1
inner join Price as t2
on t1.ProductId = t2.ProductId



-- left outer join join
select *
from Products as t1
left outer join Price as t2
on t1.ProductId = t2.ProductId


-- right outer join join
select *
from Products as t1
right outer join Price as t2
on t1.ProductId = t2.ProductId


-- full outer join join
select *
from Products as t1
full outer join Price as t2
on t1.ProductId = t2.ProductId



select *
from Products as t1
full outer join Price as t2
on t1.ProductId = t2.ProductId
where t2.ProductId is null

select *
from Products as t1
full outer join Price as t2
on t1.ProductId = t2.ProductId
where t1.ProductId is null

exec sp_help Price

ALTER TABLE Price ADD CONSTRAINT UQ_Price UNIQUE (ProductId);

-- adding relationship
alter table Price add constraint fk_pid foreign key (ProductId ) references Products(ProductId)

-- adding primary key
alter table Price add primary key (ProductId) ;

-- seting not null 
alter table Price alter column ProductId INT NOT NULL


/*
alter table Price drop PK__Price__AE17121D1CF3D3E3
alter table Price drop FK_ProductColorID
alter table Price drop UQ_Price
*/

-- po.ProductId
--,po.ProductName
--,pr.PricetId
--,pr.ProductId
--,pr.ProductPricePricetId