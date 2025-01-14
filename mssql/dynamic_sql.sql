/*
	DYNAMIC SQL
		--  take all the values in a sep tablre and combine it
			for example filters in website

*/

--select * from customers
/*
DECLARE @select AS VARCHAR(100); 
DECLARE @where AS VARCHAR(100); 
DECLARE @sql AS VARCHAR(100); 
DECLARE @table_name AS VARCHAR(100); 
DECLARE @condition1 AS VARCHAR(100); 
DECLARE @value AS VARCHAR(100);

-- Assign values to variables
SET @select = 'SELECT * FROM ';
SET @table_name = 'customers';
SET @condition1 = 'customer_id = ';
SET @value = '1';

SET @where = 'WHERE ' + @condition1 + @value;
SET @sql = @select + @table_name + ' ' + @where;

EXEC(@sql);
*/

/*
	select state, count(*) from customers group by state
*/

/*
DECLARE @select AS VARCHAR(100); 
DECLARE @select_value_1 AS VARCHAR(100); 
DECLARE @select_value_2 AS VARCHAR(100); 
DECLARE @from AS VARCHAR(100); 
DECLARE @where AS VARCHAR(100); 
DECLARE @sql AS VARCHAR(100); 
DECLARE @table_name AS VARCHAR(100); 
--DECLARE @condition1 AS VARCHAR(100); 
--DECLARE @value AS VARCHAR(100);
DECLARE @group_by AS VARCHAR(100); 
DECLARE @group_by_value AS VARCHAR(100); 


-- Assign values to variables
SET @select = 'SELECT ';
SET @select_value_1 = 'state'
SET @select_value_2 = 'count(*)'
SET @from = ' FROM '
SET @table_name = ' customers ';
--SET @condition1 = 'customer_id = ';
--SET @value = '1';
SET @group_by = ' GROUP BY '
SET @group_by_value = ' state '


SET @sql = @select + @select_value_1 + ',' + @select_value_2 + @from + @table_name + @group_by + @group_by_value;

EXEC(@sql);
*/

/*
	select first_name + ' ' + last_name, city, state from customers where city = 'New York'
*/
/*
DECLARE @select AS VARCHAR(100); 
DECLARE @select_value_1 AS VARCHAR(100); 
DECLARE @select_value_2 AS VARCHAR(100); 
DECLARE @select_value_3 AS VARCHAR(100); 
DECLARE @from AS VARCHAR(100); 
DECLARE @where AS VARCHAR(100); 
DECLARE @sql AS VARCHAR(100); 
DECLARE @table_name AS VARCHAR(100); 
DECLARE @condition1 AS VARCHAR(100); 
DECLARE @value AS VARCHAR(100);
--DECLARE @group_by AS VARCHAR(100); 
--DECLARE @group_by_value AS VARCHAR(100); 


-- Assign values to variables
SET @select = 'SELECT ';
SET @select_value_1 = 'concat(first_name,'', '',last_name)'
SET @select_value_2 = 'city'
SET @select_value_3 = 'state'
SET @from = ' FROM ';
SET @table_name = ' customers ';
SET @condition1 = 'city = ';
SET @value = '''New York''';
SET @where = ' WHERE '
--SET @group_by = ' GROUP BY '
--SET @group_by_value = ' state '


SET @sql = @select + @select_value_1 + ',' + @select_value_2 +  ',' + @select_value_3 + @from + @table_name + @where + @condition1 + @value;
print @sql
EXEC(@sql);
*/

/*
DECLARE @select AS VARCHAR(100);
DECLARE @select_value_1 AS VARCHAR(100);
--DECLARE @select_value_2 AS VARCHAR(100);
DECLARE @from AS VARCHAR(100);
DECLARE @where AS VARCHAR(100);
DECLARE @sql AS VARCHAR(100);
DECLARE @table_name AS VARCHAR(100); 
DECLARE @select_state AS VARCHAR(100);
 
SET @select = 'SELECT *';
SET @select_value_1 = 'state'
SET @from = ' FROM '
SET @table_name = ' customers ';
--SET @condition1 = 'customer_id = ';
SET @select_state = '''NY'''
SET  @Where =' WHERE '

 
SET @sql = @select + @from +@table_name+ @Where + @select_value_1+ ' = ' + @select_state
print @sql
EXEC(@sql);
*/


/*
LIST OF customers and their ORDERS BETWEEN THE DATES
select concat(c.first_name,' ',c.last_name) as full_name,o.order_status,o.order_date from customers as c 
inner join orders as o
on c.customer_id = o.customer_id
where o.order_date between '2017-04-01' and '2017-05-15'
select * from customers
select * from orders
*/

/*
DECLARE @select AS VARCHAR(100);
DECLARE @select_value_1 AS VARCHAR(100);
DECLARE @select_value_2 AS VARCHAR(100);
DECLARE @select_value_3 AS VARCHAR(100);
DECLARE @from AS VARCHAR(100);
DECLARE @where AS VARCHAR(100);
DECLARE @where_condition1 AS VARCHAR(100);
DECLARE @sql AS VARCHAR(MAX);
DECLARE @table_name_1 AS VARCHAR(100); 
DECLARE @table_name_2 AS VARCHAR(100); 
DECLARE @select_state AS VARCHAR(100);
DECLARE @join AS VARCHAR(100);
DECLARE @on AS VARCHAR(100);
DECLARE @on_condition AS VARCHAR(100);
DECLARE @start_range AS VARCHAR(100);
DECLARE @end_range AS VARCHAR(100);
 
SET @select = 'SELECT ';
SET @select_value_1 = 'concat(c.first_name,'' '',c.last_name) as [Full Name]'
SET @select_value_2 = 'o.order_status as [Order Status]'
SET @select_value_3 = 'o.order_date as [Order Date]'
SET @from = ' FROM '
SET @table_name_1 = ' customers as c ';
SET @join = ' inner join '
SET @table_name_2 = ' orders as o ';
SET @on =' ON ';
SET @on_condition = ' c.customer_id = o.customer_id ';
SET  @Where =' WHERE '
SET @where_condition1 = 'o.order_date between ''2017-04-01'' and ''2017-05-15'' ';
SET @start_range = '''2017-04-01'''
SET @end_range = '''2017-05-15'''

SET @sql = @select + @select_value_1 + ',' + @select_value_2 + ',' + @select_value_3 + @from + @table_name_1 + @join + @table_name_2 + @on + @on_condition + @Where + @where_condition1;
print @sql
EXEC(@sql);
*/

/*
LIST OF customers and their ORDERS BETWEEN THE DATES
select concat(c.first_name,' ',c.last_name) as full_name,o.order_status,o.order_date from customers as c 
inner join orders as o
on c.customer_id = o.customer_id
where o.order_date between '2017-04-01' and '2017-05-15'
select * from customers
select * from orders
select * from order_items
*/

DECLARE @select AS VARCHAR(100);
DECLARE @select_value_1 AS VARCHAR(100);
DECLARE @select_value_2 AS VARCHAR(100);
DECLARE @select_value_3 AS VARCHAR(100);
DECLARE @from AS VARCHAR(100);
DECLARE @where AS VARCHAR(100);
DECLARE @where_condition1 AS VARCHAR(100);
DECLARE @sql AS VARCHAR(MAX);
DECLARE @table_name_1 AS VARCHAR(100); 
DECLARE @table_name_2 AS VARCHAR(100); 
DECLARE @select_state AS VARCHAR(100);
DECLARE @join AS VARCHAR(100);
DECLARE @on AS VARCHAR(100);
DECLARE @on_condition AS VARCHAR(100);
DECLARE @start_range AS VARCHAR(100);
DECLARE @end_range AS VARCHAR(100);
 
SET @select = 'SELECT ';
SET @select_value_1 = 'concat(c.first_name,'' '',c.last_name) as [Full Name]'
SET @select_value_2 = 'o.order_status as [Order Status]'
SET @select_value_3 = 'o.order_date as [Order Date]'
SET @from = ' FROM '
SET @table_name_1 = ' customers as c ';
SET @join = ' inner join '
SET @table_name_2 = ' orders as o ';
SET @on =' ON ';
SET @on_condition = ' c.customer_id = o.customer_id ';
SET  @Where =' WHERE '
SET @start_range = '''2017-04-01'''
SET @end_range = '''2017-05-15'''
SET @where_condition1 = ' o.order_date between ' + @start_range + 'and' + @end_range;

SET @sql = @select + @select_value_1 + ',' + @select_value_2 + ',' + @select_value_3 + @from + @table_name_1 + @join + @table_name_2 + @on + @on_condition + @Where + @where_condition1;
print @sql
EXEC(@sql);

select 
	   o.order_id as [id]
	 , sum(oi.list_price * oi.quantity) as order_values
from customers as c 
inner join orders as o
on c.customer_id = o.customer_id
inner join order_items as oi
on o.order_id = oi.order_id
where o.order_date between '2017-04-01' and '2017-05-15'
group by o.order_id
order by 2 desc

select 
	oi.order_id as [Order ID],
	sum(oi.list_price * oi.quantity) As [order value]
from order_items as oi
Inner join orders as o ON oi.order_id=o.order_id
Inner join Customers as c ON o.customer_id=c.customer_id
where o.order_date between '2017-04-01' and '2017-05-15'
group by oi.order_id
order by 2 desc

