# DBMS AND RDBMS

#normalization no data redunce

# order of execution : FROM >> WHERE >> GROUP BY >> HAVING >> SELECT >> ORDER BY

# sql commands:
	# DDL - data defination language : CREATE, ALTER, DROP, TRUNCATE
    # DML - data manupilation languaage : INSERT,UPDATE,DELETE -->(CRUD OPERATION)
    # DQL - data query language : SELECT
    # TCL - transaction control language : COMMIT, ROLLBACK, SAVEPOINT
    # DCL - data control language : GRANT, REVOKE
    
# Operators in sql
	-- comparision operator : =,>,>=,<,<=,<> or !=, between 

/*
#DATA TYPES CLASSIFICATION:
	* string
			-char or character - fixed memory  --> CHAR(15)  
            -varchar or variable Character - variable memo --> VARCHAR(60)
	* numerics
			-int or integer (....-3,-2,-1,0,1,2,3,....)
            -float or decimal
	* boolean (0 & 1)
	* DateTime --> yyyy-mm-dd hh:mm:ss
 */
 
 /*
	TRANSACTION --> only for delete, update, insert
 */

USE supermarket;

# TO SHOW THE TABLES IN THE DATABASE
SHOW TABLES;

# TO DELETE TABLE VALUES USE DELETE AND TRUNCATE
TRUNCATE TABLE Customer;

# UPDATE VALUES
UPDATE Customer SET gender = 'Male' WHERE CustomerId = 3;

# TO DELETE AN COLUMN IN A TABLE
ALTER TABLE Customer DROP gender;

#ALTER TABLE AFTER THE SPECIFIC COLUMNS
ALTER TABLE Customer ADD COLUMN gender VARCHAR(6) AFTER Mobile;

# TO DELETE THE ROW IN A TABLE
DELETE FROM Customer WHERE CustomerName='manoj';


USE normalization;
