CREATE TABLE IF NOT EXISTS Product(
	ProductId INT AUTO_INCREMENT ,
	ProductName VARCHAR(30) NOT NULL,
    ProductPrice DECIMAL(7.2) NOT NULL,
    ProductDescription VARCHAR(30) NOT NULL,
    ProductStock VARCHAR(30) NOT NULL,
    ProductSizeId INT NOT NULL,
    ManufracturerId INT NOT NULL,
    ProductUsageId INT NOT NULL,
    CategoryId INT NOT NULL,
    ProductColorId INT NOT NULL,
    PRIMARY KEY(ProductId),
    FOREIGN KEY(ProductSizeId) REFERENCES ProductSize(ProductSizeId) ON UPDATE CASCADE ON DELETE CASCADE,
     FOREIGN KEY(ManufracturerId) REFERENCES ProductManufracturer(ManufracturerId) ON UPDATE CASCADE ON DELETE CASCADE,
      FOREIGN KEY(ProductUsageId) REFERENCES ProductUsage(ProductUsageId) ON UPDATE CASCADE ON DELETE CASCADE,
       FOREIGN KEY(CategoryId) REFERENCES Category(CategoryId) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY(ProductColorId) REFERENCES ProductColors(ProductColorId) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS ProductSize(
	ProductSizeId INT PRIMARY KEY AUTO_INCREMENT,
    ProductSizeName VARCHAR(30) NOT NULL,
	PRIMARY KEY(CategoryId)
);

CREATE TABLE IF NOT EXISTS ProductManufracturer(
	ManufracturerId INT PRIMARY KEY AUTO_INCREMENT,
    ManufracturerName VARCHAR(30) NOT NULL,
	PRIMARY KEY(CategoryId)
);

CREATE TABLE IF NOT EXISTS ProductUsage(
	ProductUsageId INT PRIMARY KEY AUTO_INCREMENT,
    ProductUsageName VARCHAR(30) NOT NULL,
	PRIMARY KEY(CategoryId)
);

CREATE TABLE IF NOT EXISTS Category(
	CategoryId INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(30) NOT NULL,
	PRIMARY KEY(CategoryId)
);

CREATE TABLE IF NOT EXISTS ProductColors(
	ProductColorId INT PRIMARY KEY AUTO_INCREMENT,
    ProductColorName VARCHAR(30) NOT NULL,
    PRIMARY KEY(ProductColorId)
);