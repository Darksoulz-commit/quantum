select current_timestamp() as 'Date and time';

select (2+1) as 'sum of number';

desc customers;
select * from customers;

select count(c.customerName) as 'name' from customers as c;

# not in NYC
-- solution 1
SELECT C.customerName AS 'Name' FROM customers AS C WHERE city <> 'NYC';
-- solution 2
SELECT C.customerName AS 'Name' FROM customers AS C WHERE city <> 'NYC';
-- solution 3
SELECT C.customerName AS 'Name' FROM customers AS C WHERE NOT('NYC');


#whose greater than 50000
select customerName from customers where creditLimit > 50000;
select c.customerName  from customers as C where creditLimit >= 20000 and creditLimit <= 50000;
select  c.customerName  from customers as C where creditLimit between 20000 and 50000;
select  c.customerName  from customers as C where creditLimit NOT between 20000 and 50000;

# to select in a multiple values
select  count(c.customerName)  from customers as C where country = ('usa') OR country = ('france') OR country = ('germany');
select  count(c.customerName)  from customers as C where country IN('usa','france','germany');
select  c.customerName  from customers as C where country NOT IN('usa','france','germany');

# stats with A
select  c.customerName  from customers as C where customerName like 'A%';
select  c.customerName  from customers as C where customerName not like 'A';

#ends with 'ltd.'
select  c.customerName  from customers as C where customerName like '%ltd.';

#count of names
select  count(c.customerName)  from customers as C ;

#county wise customers
select country ,count(*)  from customers as C  group by country having count(*) >10 order by country asc;
select country ,count(*)  from customers as C  group by country having count(*) >10 order by 1;