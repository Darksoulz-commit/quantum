DROP TABLE IF EXISTS  sample;

CREATE TABLE IF NOT EXISTS sample(
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
	CustomerName VARCHAR(30) NOT NULL
);

SELECT * FROM sample;

START TRANSACTION;

INSERT INTO sample(CustomerName) VALUES
('varma'),
('sajith'),
('sidarth'),
('sudhar');

DELETE from sample where CustomerID = 2;

COMMIT;

ROLLBACK to C1;
ROLLBACK to B;


DELETE from sample where CustomerID = 4;

SAVEPOINT B;
DELETE from sample where CustomerID = 3;
DELETE from sample where CustomerID = 2;


SAVEPOINT C1;
update  sample set CustomerName = 'varma' where CustomerID =1;