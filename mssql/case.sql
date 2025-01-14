

create table emp(
    emp_id int primary key
    , First_Name varchar(50) not null
    , Last_Name varchar(50) not null
    , Hire_Date date not null
    , Email_id varchar(50)
    , Phone_No varchar(50)
    , Job_Id varchar(50)
    , Salary DECIMAL(7,2)
);

insert into emp (emp_id, First_Name,Last_Name,Hire_Date,Email_id,Job_Id,Salary) values
(100,'steven', 'king','1987-06-17','steven.king@gmail.com','AD_Pres',90000.00),
(101,'N', 'kochar','1989-09-21','n.kochar@gmail.com','AD_VP',17000.00),
(102,'Lex', 'DeHaan','1993-01-13','Lex.DeHaan@gmail.com','AD_VP',25000.00),
(103,'Alexender', 'Hunold','1990-01-03','Alexender.Hunold@gmail.com','IT_PROG',9000.00),
(104,'Bruce', 'Ernst','1991-05-21','Bruce.Ernst@gmail.com','IT_PROG',6000.00),
(105,'David', 'Austin','1997-06-25','David.Austin@gmail.com','IT_PROG',4800.00);

select * from emp

alter table emp add Gender char;

select * from emp where emp_id in(100,101,102,103,104,105)

-- simple case expression

select *,
case Job_Id
	when 'AD_Pres' then (salary * 0.1) + salary
	when 'IT_PROG' then (salary * 0.2) + salary
	else salary
end as Revised_salary
from emp;

-- searched case expression

select *,
case 
	when Job_Id = 'AD_Pres' then (salary * 0.1) + salary
	when emp_id = 104 then (salary * 0.2) + salary
	else salary
end as Revised_salary
from emp;


select * from orders
select * from order_items

select distinct
	o.order_status,
	case when o.order_status = 1 then 'IN Progress'
		 when o.order_status = 2 then 'Pending'
		 when o.order_status = 3 then 'Completed'
		 when o.order_status = 4 then 'Delivered'
	end as order_status,
	count(o.order_status) as [Number of order_status]
from orders as o
group by order_status
order by 1

select distinct
	o.order_status,
	case order_status
		 when 1 then 'IN Progress'
		 when 2 then 'Pending'
		 when 3 then 'Completed'
		 when 4 then 'Delivered'
	end as order_status,
	count(*) over(partition by order_status) as [Number of order_status]
from orders as o
order by 1

/*
	order values wirth orderstatus count
	orderid, orderstatus, total amoounbt, discountamount, ordervalue
*/
select distinct
	  o.order_id as [order ID]
	, case order_status
		 when 1 then 'IN Progress'
		 when 2 then 'Pending'
		 when 3 then 'Completed'
		 when 4 then 'Delivered'
	  end as [Order Status]
	--,count(*) over(partition by order_status) as [Number of order_status]
	, oi.list_price as [Total amount]
	, oi.discount as[Discount amount]
	, sum(list_price * discount) over(partition by oi.order_id) as [Order values]
from orders as o
inner join order_items as oi
on o.order_id = oi.order_id
order by 5 desc


with cte_orders as(
select     o.order_status
		 , case order_status
			 when 1 then 'IN Progress'
			 when 2 then 'Pending'
			 when 3 then 'Completed'
			 when 4 then 'Delivered'
		   end as [Order Status]
		, sum (oi.list_price * oi.quantity) over(partition by o.order_id,o.order_status) as [Total amount]
		, sum (oi.discount * oi.quantity * oi.discount ) over(partition by o.order_id,o.order_status) as[Discount amount]
	from orders as o
	inner join order_items as oi
	on o.order_id = oi.order_id
)
select distinct
		case [order_status]
				 when 1 then 'IN Progress'
				 when 2 then 'Pending'
				 when 3 then 'Completed'
				 when 4 then 'Delivered'
			  end as [orderStatus]
		, format(sum([Total amount]),0) as MRP
		, sum([Discount amount]) as Discount
		, sum ([Total amount] - [Discount amount]) as [Order values]
from cte_orders
group by case order_status
			 when 1 then 'IN Progress'
			 when 2 then 'Pending'
			 when 3 then 'Completed'
			 when 4 then 'Delivered'
		  end
order by 1 desc


/*
	coalesce it will return the first non null values in the set of values
*/

select coalesce (null,'AA','B',NULL)

/*
	retive all phone number if null make it na
*/

select c.phone, coalesce(phone, '-') as coalese from customers as c;


