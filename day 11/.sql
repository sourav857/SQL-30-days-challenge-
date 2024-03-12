drop table if exists hotel_ratings;
create table hotel_ratings
(
	hotel 		varchar(30),
	year		int,
	rating 		float
);
insert into hotel_ratings values('Radisson Blu', 2020, 4.8);
insert into hotel_ratings values('Radisson Blu', 2021, 3.5);
insert into hotel_ratings values('Radisson Blu', 2022, 3.2);
insert into hotel_ratings values('Radisson Blu', 2023, 3.8);
insert into hotel_ratings values('InterContinental', 2020, 4.2);
insert into hotel_ratings values('InterContinental', 2021, 4.5);
insert into hotel_ratings values('InterContinental', 2022, 1.5);
insert into hotel_ratings values('InterContinental', 2023, 3.8);

with cte as 
(select *,round(avg(rating) over(partition by hotel ),2) as avg_rating
  
  from hotel_ratings),cte1 as 
  
  (select *,abs(avg_rating-rating) as diff,
  rank() over(partition by hotel order by abs(avg_rating-rating) desc ,year) as ranking
   from cte 
   )
   
   select hotel,year,rating from cte1 where ranking>1
   order by hotel desc,year
  
  
  
select * from hotel_ratings














