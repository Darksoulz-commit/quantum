DROP TABLE Product;
CREATE TABLE IF NOT EXISTS Product(
	ProductId INT AUTO_INCREMENT ,
	ProductName VARCHAR(30) NOT NULL,		-- PARENT
    ProductPrice DECIMAL(7.2) NOT NULL,		-- PARENT
    ProductDescription VARCHAR(30) NOT NULL,	-- PARENT
    ProductStock VARCHAR(30) NOT NULL,	-- PARENT
    ManufracturerId INT NOT NULL,	-- CHILD
    ProductUsageId INT NOT NULL,	-- CHILD
    CategoryId INT NOT NULL,	-- CHILD
    ProductColorId INT NOT NULL,	-- CHILD
    PRIMARY KEY(ProductId),
	FOREIGN KEY(ManufracturerId) REFERENCES ProductManufracturer(ManufracturerId) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(ProductUsageId) REFERENCES ProductUsage(ProductUsageId) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(CategoryId) REFERENCES Category(CategoryId) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(ProductColorId) REFERENCES ProductColors(ProductColorId) ON UPDATE CASCADE ON DELETE CASCADE
);

DESC Product;
select * from product;

INSERT INTO Customer (
ProductId, ProductName, ProductPrice, ProductDescription, ProductStock, ManufracturerId, ProductUsageId, CategoryId, ProductColorId) VALUES
(),
(),
(),
();


-- -------------------------------------------------------------------------------------------------------


DROP TABLE ProductSize;
DESC ProductSize;
select * from ProductSize;

CREATE TABLE IF NOT EXISTS ProductSize(
	ProductSizeId INT PRIMARY KEY AUTO_INCREMENT,
    ProductSizeName VARCHAR(30) NOT NULL
);

INSERT INTO ProductSize (
ProductSizeName ) VALUES
(''),
(''),
(''),
('');


-- -------------------------------------------------------------------------------------------------------


DROP TABLE ProductManufracturer;
DESC ProductManufracturer;
select * from ProductManufracturer;
CREATE TABLE IF NOT EXISTS ProductManufracturer(
	ManufracturerId INT PRIMARY KEY AUTO_INCREMENT,
    ManufracturerName VARCHAR(30) NOT NULL
);

INSERT INTO ProductManufracturer (
ManufracturerName ) VALUES
('xxx'),
('yyy'),
('zzz'),
('qqq');

-- -------------------------------------------------------------------------------------------------------

DROP TABLE ProductUsage;
DESC ProductUsage;
select * from ProductUsage;
CREATE TABLE IF NOT EXISTS ProductUsage(
	ProductUsageId INT PRIMARY KEY AUTO_INCREMENT,
    ProductUsageName VARCHAR(30) NOT NULL
);

INSERT INTO ProductUsage (
ProductUsageName ) VALUES
(''),
(''),
(''),
('');

-- -------------------------------------------------------------------------------------------------------


DROP TABLE Category;
DESC Category;
select * from Category;
CREATE TABLE IF NOT EXISTS Category(
	CategoryId INT PRIMARY KEY AUTO_INCREMENT,
    ProductSizeId INT NOT NULL,
    CategoryName VARCHAR(30) NOT NULL,
    FOREIGN KEY(ProductSizeId) REFERENCES ProductSize(ProductSizeId) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Category (
CategoryName ) VALUES
(''),
(''),
(''),
('');
-- -------------------------------------------------------------------------------------------------------


DROP TABLE ProductColors;
DESC ProductColors;
select * from ProductColors;
CREATE TABLE IF NOT EXISTS ProductColors(
	ProductColorId INT PRIMARY KEY AUTO_INCREMENT,
    ProductColorName VARCHAR(30) NOT NULL
);

INSERT INTO ProductColors (
ProductColorName ) VALUES
('Red'),
('Green'),
('Blue'),
('Orange');

-- -------------------------------------------------------------------------------------------------------
