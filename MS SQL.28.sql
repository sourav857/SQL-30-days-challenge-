-- Find length of comma seperated values in items field

drop table if exists item;
create table item
(
	id		int,
	items	varchar(50)
);
insert into item values(1, '22,122,1022');
insert into item values(2, ',6,0,9999');
insert into item values(3, '100,2000,2');
insert into item values(4, '4,44,444,4444');


--cross apply gives a tabular output
--so it cannot be used after select
--cross apply is only used for join query
--string_agg is used to join all the rows one after another

select id,string_agg(len(value),',') as lengths from item cross apply 
string_split(items,',')
group by id


