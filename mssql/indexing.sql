/*
	INDEXING in MsSQL
		|__ Clustured index -- one per table - Primary key
		|__ Non Clustered index -- can be more than one per table - unique aka multiple in
*/

drop table if exists customer;

create table customer(
	  id int not null
    , first_name varchar(100) not null
	, last_name varchar(100) not null
	, primary key(id,first_name)
)



truncate table customer

insert into customer (id,first_name,last_name)
select 1,'sudharsan','s'
union
select 1,'quantum', 'unity'
union
select 2, 'one','two'

select * from customer
--where id = 1
--where c_name = 'quantum'

--non clyustered index nonclustered is optional we can use index to create non clusterd
create  nonclustered index ind on customer(last_name)
--clustered indecx
create clustered index cid on customer(lastname)

select * from customer
where id=2

/*
querry execution plan 
table scan
index scan index seek	 culstered index
*/