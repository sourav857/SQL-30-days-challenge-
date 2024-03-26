
drop table if exists product_demo;
create table product_demo
(
	store_id	int,
	product_1	varchar(50),
	product_2	varchar(50)
);
insert into product_demo values (1, 'Apple - IPhone', '   Apple - MacBook Pro');
insert into product_demo values (1, 'Apple - AirPods', 'Samsung - Galaxy Phone');
insert into product_demo values (2, 'Apple_IPhone', 'Apple: Phone');
insert into product_demo values (2, 'Google Pixel', ' apple: Laptop');
insert into product_demo values (2, 'Sony: Camera', 'Apple Vision Pro');
insert into product_demo values (3, 'samsung - Galaxy Phone', 'mapple MacBook Pro');




with cte as 
(select store_id,ltrim(product_1) as p1,ltrim(product_2) as p2 from product_demo)

select store_id,sum(case when p1 LIKE 'A%' then 1 else 0 end ) as p1,
sum(case when p2 LIKE 'A%' then 1 else 0 end) as p2
from cte
group by store_id

