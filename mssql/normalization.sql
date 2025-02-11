create database normalization;

use normalization;

-- Droping the table
DROP TABLE IF EXISTS Product;

-- PRODUCT TABLE CREATION
CREATE TABLE Product(
	ProductID TINYINT IDENTITY(1,1),
	ProductName VARCHAR(100),
	Price DECIMAL(7,4),
	ProductDescription VARCHAR(100),
	Stocks INT,
	ManufracturerId INT ,
    ProductUsageID INT ,
    ProductSizeID INT ,
    ProductColorID INT ,
	PRIMARY KEY(ProductId),
);




-- INSERTING VALUES INTO Porduct TABLA
select * from product;
--TRUNCATE TABLE Product;
INSERT INTO Product (
ProductName, Price, ProductDescription, Stocks) VALUES
('Nike air max', 575.15, 'A casual shooe for everyday wear', 15 ),
('Puma air max', 426.35, 'A casual shooe for everyday wear', 25 ),
('SkyLine air max', 695.65, 'A casual shooe for everyday wear', 35 ),
('Max air max', 965.85, 'A casual shooe for everyday wear', 45 );


-- To show the Description of the table
EXEC SP_HELP Product;
----------------------------------------------------------------------------------------------------------------
-- CAETEGORY TABLE CREATION
DROP TABLE IF EXISTS ProductCategory;
CREATE TABLE ProductCategory(
	ProductCategoryId INT IDENTITY(1000,1),
    CategoryName VARCHAR(100) NOt NUll,
	PRIMARY KEY(ProductCategoryId)
);


select * from ProductCategory;
--INSERT INTO ProductCategory (CategoryName)
--SELECT 'Women';
INSERT INTO ProductCategory (CategoryName)
VALUES ('Men'), ('Women'), ('Men'), ('Women');

---- This is used to set the identity to give the values manually
--SET IDENTITY_INSERT ProductCategory ON;
---- For Manuallly giving the id
--INSERT INTO ProductCategory (ProductCategoryId,CategoryName)
--SELECT 4,'Men';
---- After inserting the values must OFF to auto increment
--SET IDENTITY_INSERT ProductCategory OFF;
----------------------------------------------------------------------------------------------------------------


-- PRODUCT USAGE TABLE CREATION
DROP TABLE IF EXISTS ProductUsage;
CREATE TABLE ProductUsage (
	ProductUsageID INT IDENTITY(1000,1),
	ProductUsage VARCHAR(100) NOT NULL,
	PRIMARY KEY(ProductUsageID)
);
TRUNCATE TABLE ProductUsage;
select * from ProductUsage;
--SET IDENTITY_INSERT ProductUsage ON;
--INSERT INTO ProductUsage (ProductUsageID,ProductUsage)
--SELECT 001,'Casual'
--SET IDENTITY_INSERT ProductUsage OFF;
INSERT INTO ProductUsage (ProductUsage)
SELECT 'Casual'
UNION
SELECT 'Formal'
UNION
SELECT 'Office'
UNION ALL
SELECT 'Casual'


----------------------------------------------------------------------------------------------------------------


-- PRODUCT COLOR TABLE CREATION
DROP TABLE IF EXISTS ProductColor;
CREATE TABLE ProductColor (
	ProductColorID INT IDENTITY(1000,1),
	ProductColors VARCHAR(100) NOT NULL,
	PRIMARY KEY(ProductColorID)
);
TRUNCATE TABLE ProductColor;
select * from ProductColor;
--SET IDENTITY_INSERT ProductColor ON;
--INSERT INTO ProductColor (ProductColorID,ProductColors)
--SELECT 001,'Balck'
--SET IDENTITY_INSERT ProductColor OFF;
INSERT INTO ProductColor (ProductColors)
SELECT 'Green'
UNION
SELECT 'Red'
UNION
SELECT 'Blue'
UNION
SELECT 'Lime'

----------------------------------------------------------------------------------------------------------------


-- PRODUCT SIZE TABLE CREATION
DROP TABLE IF EXISTS ProductSize;
CREATE TABLE ProductSize (
	ProductSizeID INT IDENTITY(1000,1),
	ProductCategoryId INT,
	ProductSize VARCHAR(100) NOT NULL,
	PRIMARY KEY(ProductSizeID)
);
ALTER TABLE ProductSize
ALTER COLUMN ProductCategoryId INT;

TRUNCATE TABLE ProductSize;
select * from ProductSize;
--SET IDENTITY_INSERT ProductSize ON;
--INSERT INTO ProductSize (ProductSizeID,ProductSize)
--SELECT 001,'US Mens 9'
--SET IDENTITY_INSERT ProductSize OFF;
INSERT INTO ProductSize (ProductSize)
SELECT 'US Mens 9'
UNION
SELECT 'EU Womens 37'
UNION
SELECT 'UK Mens 8'
UNION
SELECT 'IN Mens 10'
----------------------------------------------------------------------------------------------------------------


--DROP TABLE ProductManufracturer;

DROP TABLE IF EXISTS ProductManufracturer;
CREATE TABLE  ProductManufracturer(
	ManufracturerId INT IDENTITY(1000,1),
    ManufracturerName VARCHAR(100) NOT NULL,
	PRIMARY KEY(ManufracturerId)
);
select * from ProductManufracturer;
--TRUNCATE TABLE ProductManufracturer;
--SET IDENTITY_INSERT ProductManufracturer ON;
--INSERT INTO ProductSize (ManufracturerId,ManufracturerName)
--SELECT 001,'Nike'
--SET IDENTITY_INSERT ProductManufracturer OFF;
INSERT INTO ProductManufracturer (ManufracturerName ) 
SELECT('Nike')
UNION
SELECT('Puma')
UNION
SELECT('Sky Line')
UNION
SELECT('Max');

----------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS  Product;
DROP TABLE IF EXISTS  ProductCategory;
DROP TABLE IF EXISTS  ProductUsage;
DROP TABLE IF EXISTS  ProductColor;
DROP TABLE IF EXISTS  ProductSize;
DROP TABLE IF EXISTS  ProductManufracturer;

SELECT * FROM Product;
SELECT * FROM ProductCategory;
SELECT * FROM ProductUsage;
SELECT * FROM ProductColor;
SELECT * FROM ProductSize;
SELECT * FROM ProductManufracturer;

EXEC SP_HELP Product;
EXEC SP_HELP ProductCategory;
EXEC SP_HELP ProductUsage;
EXEC SP_HELP ProductColor;
EXEC SP_HELP ProductSize;
EXEC SP_HELP ProductManufracturer;


-- ADDing FOREIGN KEYS to the Product TABLE BY ALTERING IT
ALTER TABLE Product
ADD 
CONSTRAINT FK_ManufracturerId
FOREIGN KEY(ManufracturerId) REFERENCES ProductManufracturer(ManufracturerId) ON UPDATE CASCADE ON DELETE CASCADE,

CONSTRAINT FK_ProductUsageID
FOREIGN KEY(ProductUsageID) REFERENCES ProductUsage(ProductUsageID) ON UPDATE CASCADE ON DELETE CASCADE,

CONSTRAINT FK_ProductSizeID
FOREIGN KEY(ProductSizeID) REFERENCES ProductSize(ProductSizeID) ON UPDATE CASCADE ON DELETE CASCADE,

CONSTRAINT FK_ProductColorID
FOREIGN KEY(ProductColorID) REFERENCES ProductColor(ProductColorID) ON UPDATE CASCADE ON DELETE CASCADE;


-- For 3 NF adding size to the category
ALTER TABLE ProductSize
ADD 
CONSTRAINT FK_ProductCategoryId
FOREIGN KEY(ProductCategoryId) REFERENCES ProductCategory(ProductCategoryId) ON UPDATE CASCADE ON DELETE CASCADE

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;

-- alter table for changing DATA TYPES
--ALTER TABLE Product ALTER COLUMN Prod_ID INT NOT NULL;

-- To ADD the CONSTRAINTS
--ALTER TABLE Product ADD CONSTRAINT PK_ProductID PRIMARY KEY(PROD_ID) 

-- DROPING THE specific column
--ALTER TABLE Product DROP COLUMN Prod_ID;

-- DROPING CONSTRAINTS
--ALTER TABLE Product DROP CONSTRAINT PK_ProductID;