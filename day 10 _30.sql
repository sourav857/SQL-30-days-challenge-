
--create table
drop table if exists auto_repair;
create table auto_repair
(
	client			varchar(20),
	auto			varchar(20),
	repair_date		int,
	indicator		varchar(20),
	value			varchar(20)
);
insert into auto_repair values('c1','a1',2022,'level','good');
insert into auto_repair values('c1','a1',2022,'velocity','90');
insert into auto_repair values('c1','a1',2023,'level','regular');
insert into auto_repair values('c1','a1',2023,'velocity','80');
insert into auto_repair values('c1','a1',2024,'level','wrong');
insert into auto_repair values('c1','a1',2024,'velocity','70');
insert into auto_repair values('c2','a1',2022,'level','good');
insert into auto_repair values('c2','a1',2022,'velocity','90');
insert into auto_repair values('c2','a1',2023,'level','wrong');
insert into auto_repair values('c2','a1',2023,'velocity','50');
insert into auto_repair values('c2','a2',2024,'level','good');
insert into auto_repair values('c2','a2',2024,'velocity','80');


--approach 1-using case function
--first segregate two tables having 'velocity' and 'level' 
--inner join two tables 
--use case function 
select * from auto_repair where indicator='level'
select * from auto_repair where indicator='velocity'

--

with cte as 
(select v.value,(case when l.value ='good' then 1 else 0 end ) as good ,
(case when l.value ='regular' then 1 else 0 end ) as regular,
(case when l.value='wrong' then 1 else 0 end ) as wrong
 from auto_repair l inner join auto_repair v ON
l.client=v.client and l.auto=v.auto and l.repair_date=v.repair_date
where l.indicator='level' and v.indicator='velocity'
)

select value as velocity,sum(good) as good, sum(wrong) as wrong,sum(regular) as regular from cte
group by value







--approach 2 -By using pivot table

select * FROM
(select v.value,l.value as level from auto_repair l inner join auto_repair v ON
l.client=v.client and l.auto=v.auto and l.repair_date=v.repair_date
where l.indicator='level' and v.indicator='velocity'
 )pq
 pivot
 (
   count(level)
   for level in ([good],[wrong],[regular])

 )pq
