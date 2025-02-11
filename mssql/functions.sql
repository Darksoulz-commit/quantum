/*
	Functions:
		-- used for automating repetitive task
		-- can be used in sp
		-- must have the return value
		-- can be used in select and too stored procedure
		-- type of function
				|__ system defined function
				|__ User defined function(UDF)
							|__ Scaler UDF used for a single values
							|__ Tabular UDF in a tabular format

	Stored procedure:
		-- may returen a value
		-- can not be used in select and too stored procedure
		-- cant use insed a function
		-- the main usecase is sent via api request to pass the data to database to frontend

*/


-- creating  a scalar function

CREATE OR ALTER FUNCTION udf_age(
	@dob as DATE
)
RETURNS INT
AS BEGIN
	DECLARE @iAge as INT

	SET @iAge = DateDIFF(YY,@dob,GETDATE())

	RETURN @iAge
END

DECLARE @Dateofbirth as Date = '2001-10-10'
select 
  @Dateofbirth as DOB
, dbo.udf_age(@Dateofbirth) as age;

/*
	create a function to concat firast name and lastname
*/
-- hardcodeed values
create or alter function udf_name(
	@fname as varchar(50),
	@lname as varchar(50)
)
returns varchar(100)
as begin
	declare @fullname as varchar(100)
	set @fullname = (RTRIM(LTRIM(@fname)) + ' ' + RTRIM(LTRIM(@lname)))
	return @fullname
end

DECLARE @fnames as varchar(50) = 'quantum',@lnames as varchar(50) = 'unity'
select 
  @fnames as [First Name]
, @lnames as [Last Name]
, dbo.udf_name(@fnames,@lnames) as [Full Name];


--dynamic values
create or alter function udf_name(
	@fname as varchar(50),
	@lname as varchar(50)
)
returns varchar(100)
as begin
	declare @fullname as varchar(100)
	set @fullname = (RTRIM(LTRIM(@fname)) + ' ' + RTRIM(LTRIM(@lname)))
	return @fullname
end

SELECT 
    c.first_name AS [First Name],
    c.last_name AS [Last Name],
    dbo.udf_name(c.first_name, c.last_name) AS [Full Name]
FROM 
    customers as c;


--concat gmail ids
create or alter function udf_mail(
	@fname as varchar(50),
	@lname as varchar(50),
	@dname as varchar(50)
)
returns varchar(100)
as begin
	declare @mailID as varchar(100)
	--set @mailID = (RTRIM(LTRIM(@fname)) + ' ' + RTRIM(LTRIM(@lname)))
	set @mailID = (RTRIM(LTRIM(@fname)) + '.' + RTRIM(LTRIM(@lname)) + '@' + RTRIM(LTRIM(@dname)) + '.com')
	return @mailID
end
-- combining
DECLARE
	  @fnames as varchar(50) = 'quantum'
	, @lnames as varchar(50) = 'unity'
	, @dnames as varchar(50) = 'test'
select 
  @fnames as [First Name]
, @lnames as [Last Name]
, @dnames as [Domain Name]
, dbo.udf_mail(@fnames,@lnames,@dnames) as [Full Name];



select * from orders
-- return the delivery date

create or alter function udf_delivery(
	@order_date as date,
	@N_days as int
)
returns date
as begin
	declare @delivery as date
	-- set @delivery = @order_date + @N_days -- we can use this also
	set @delivery = dateadd(D, @N_days, @order_date) -- use the dateadd function to add dates
	return @delivery
end

DECLARE
	  @order_date as date = '2024-12-31'
	, @N_days as int = 2
select 
  @order_date as [First Name]
, @N_days as [Last Name]
, dbo.udf_delivery(@order_date,@N_days) as [Delivery Date];


/*--seperate mail with firstname lastname and domain name*/

 -- without using function
DECLARE @mail VARCHAR(100);
SET @mail = 'quantum.unity@test.com';

SELECT 
@mail as mailID,
left(@mail, charindex('.', @mail, 1) - 1) as [First Name],
SUBSTRING(@mail , CHARINDEX('.', @mail)+1 , CHARINDEX('@',@mail) - CHARINDEX('.',@mail)-1) as [Last Name],
right (@mail, charindex('.', @mail)) as [domain name];

-- for all the table
SELECT
	 c.email
	,left(c.email, CHARINDEX('.', c.email)-1) AS [First Name]
	,SUBSTRING( c.email, CHARINDEX('.', c.email) + 1, CHARINDEX('@', c.email) - CHARINDEX('.', c.email) - 1 ) AS [Last Name]
	,SUBSTRING(c.email, CHARINDEX('@', c.email)+ 1, LEN(c.email)) AS [Domain Name]
FROM customers AS c;

-- using functions
create or alter function udf_sep_mail(
	@mail as varchar(100)
)
returns @fld table (firstName varchar(100),lastName varchar(100),domain varchar(100)) 
as begin
	declare @firstName as varchar(100), @lastName as varchar(100), @domain varchar(100)
	set @firstName = left(@mail, charindex('.', @mail, 1) - 1) 
	set @lastName = SUBSTRING(@mail , CHARINDEX('.', @mail)+1 , CHARINDEX('@',@mail) - CHARINDEX('.',@mail)-1)
	set @domain = right (@mail, charindex('.', @mail))

	INSERT INTO @fld(firstName,lastName,domain)
	select @firstName,@lastName,@domain
	return
end
-- seperating
DECLARE @mail as varchar(100) = 'quantum.unity@test.com'
select * from dbo.udf_sep_mail(@mail) ;

-- usnig function with all the datas

create or alter function udf_sep_mail_all(
	@mail as varchar(100)
)
returns @fld table (firstName varchar(100),lastName varchar(100),domain varchar(100)) 
as begin
	declare @firstName as varchar(100), @lastName as varchar(100), @domain varchar(100)
	set @firstName = left(@mail, charindex('.', @mail, 1) - 1) 
	set @lastName = SUBSTRING(@mail , CHARINDEX('.', @mail)+1 , CHARINDEX('@',@mail) - CHARINDEX('.',@mail)-1)
	set @domain = right (@mail, charindex('.', @mail))

	INSERT INTO @fld(firstName,lastName,domain)
	select @firstName,@lastName,@domain
	return
end
-- seperating
DECLARE @mail as varchar(100) = 'quantum.unity@test.com'
select * from dbo.udf_sep_mail_all(@mail) ;

select * from customers

SELECT
	  c.email
	, ep.firstName
	, ep.lastName
	, ep.domain 
FROM customers AS c 
CROSS APPLY dbo.udf_sep_mail_all(c.email) AS ep

-------------------------------------------------------------------------------

/*
	splict the values and insert into a table
*/

create or alter function udf_sep_str(
	@str as varchar(100)
)
returns @fld table (cources varchar(100)) 
as begin
	declare @cource as varchar(100)
	set @cource = left(@str, charindex(',', @str)-1)

	while len(@str) >0
	begin
		
	end

	INSERT INTO @fld(cources)
	select @cource
	return
end


declare @str as varchar(100) = 'Java,Python,SQL,Java Script'
select * from dbo.udf_sep_str(@str) ;
-------------------------------------------------------------------------------

CREATE OR ALTER FUNCTION udf_SplitString (
    @string NVARCHAR(MAX),
    @delimiter NCHAR(1)
) 
RETURNS @table TABLE (value NVARCHAR(MAX))
AS
BEGIN
    DECLARE @start INT = 1,
            @end INT,
            @substring NVARCHAR(MAX);

    WHILE  LEN(@string) >= @start
    BEGIN
        SET @end = CHARINDEX(@delimiter, @string, @start);
        IF @end = 0 
        BEGIN
            SET @end = LEN(@string) + 1;
        END
        SET @substring = SUBSTRING(@string, @start, @end - @start);
        INSERT INTO @table (value) VALUES (@substring);
        SET @start = @end + 1;
    END
    RETURN;
END;

declare @str as varchar(100) = 'Java'
select * from dbo.udf_SplitString(@str,',') ;

declare @str as varchar(100) = 'Java,Python,SQL,Java Script'
select * from dbo.udf_SplitString(@str,',') ;