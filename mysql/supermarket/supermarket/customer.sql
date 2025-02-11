DROP TABLE IF EXISTS  Customer;

CREATE TABLE IF NOT EXISTS Customer(
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
	CustomerName VARCHAR(30) NOT NULL,
    Mobile CHAR(10) UNIQUE CHECK(LENGTH(Mobile) = 10),
    EmailId VARCHAR(50) NOT NULL UNIQUE,
    Address VARCHAR(200) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL DEFAULT 'INDIA',
    Created DATETIME 
);

INSERT INTO Customer (CustomerId, CustomerName, Mobile,EmailId, Address, City, Country, Created) values 
(1, 'Sudharsan', '1234657890','sudhar@test.com', 'porur dlf', 'Chennai',DEFAULT,  current_timestamp()),
(2, 'abdul', '1234657891','abdul@test.com', 'porur dlf', 'London','Uk', current_timestamp()),
(3, 'Manoj', '1234657892','manoj@test.com', 'porur dlf', 'Chennai',DEFAULT, current_timestamp() ),
(4, 'Bharath', '1234657894','bharath@test.com', 'porur dlf', 'Chennai',DEFAULT, current_timestamp() );

SELECT * FROM Customer;

DESC customer;


