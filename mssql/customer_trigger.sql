select * from customers;
select * from products;
select * from brands;
select * from categories;

-- Coping customer table into another table
select * into adt_customers from customers where 1 = 2;

alter table adt_customers add adt_created datetime default Getdate ();
alter table adt_customers add adt_updated datetime;
alter table adt_customers add operations char(3);

create or alter trigger customer_trigger 
on customers
after update,delete,insert 
as begin
insert into
    adt_customers (
        customer_id,
        first_name,
        last_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code,
		operations
    )
select
    isnull (d.customer_id, i.customer_id) as customer_id,
    isnull (d.first_name, i.first_name) as customer_id,
    isnull (d.last_name, i.last_name) as customer_id,
    isnull (d.phone, i.phone) as customer_id,
    isnull (d.email, i.email) as customer_id,
    isnull (d.street, i.street) as customer_id,
    isnull (d.city, i.city) as customer_id,
    isnull (d.state, i.state) as customer_id,
    isnull (d.zip_code, i.zip_code) as customer_id,
    case
        when d.customer_id is null then 'INS'
        when i.customer_id is null then 'DEL'
        When i.customer_id = d.customer_id then 'UPD'
    end as Operation
from
    inserted as i
    full outer join deleted as d on i.customer_id = d.customer_id 
end;

truncate table adt_customers

select * from customers;
select * from adt_customers

--inserting
insert into customers(customer_id,first_name,last_name,phone,email,street,city,state,zip_code)
select 7,'sidarth','M',9597534562,'chennai'
-- deleting
delete from Students where StudentID=7;
-- updating
update customers set phone = '1234567890'  where customer_id = 1
update customers set email = 'test@test.com' where customer_id = 2

 
--------------------------------------------------------------------------------------