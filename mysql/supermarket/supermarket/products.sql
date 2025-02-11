DROP TABLE IF EXISTS  Products;

CREATE TABLE IF NOT EXISTS Products (
ProductId int PRIMARY KEY ,
ProductName varchar(50) NOT NULL,
ProductDescription varchar(100) NOT NULL,
ProductPrice decimal(7,2) NOT NULL
);

INSERT INTO Products(ProductId, ProductName, ProductDescription, ProductPrice) VALUES
(100,'milk','Thirumala milk 500ml' , 60.60),
(101,'paneer','milkmist paneer 500mg' , 120.60),
(102,'curd','arokya curd 500ml' , 40.60),
(103,'yogut','amul yogut 500ml' , 180.60),
(104,'batham','KRM batham 500mg' , 200.60),
(105,'ghee','VMT ghee 500ml' , 220.60),
(106,'fresh cream','amul fresh-cream 500ml' , 90.60);

SELECT * FROM Products;

DESC products;