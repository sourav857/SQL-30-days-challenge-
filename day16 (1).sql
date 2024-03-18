-- Given is user login table for , identify dates where a user has logged in for 5 or more consecutive days.
-- Return the user id, start date, end date and no of consecutive days, sorting based on user id.
-- If a user logged in consecutively 5 or more times but not spanning 5 days then they should be excluded.

/*
-- Output:
USER_ID		START_DATE		END_DATE		CONSECUTIVE_DAYS
1			10/03/2024		14/03/2024		5
1 			25/03/2024		30/03/2024		6
3 			01/03/2024		05/03/2024		5
*/


-- PostgreSQL Dataset


-- Micrososft SQL Server Dataset

drop table if exists user_login;
create table user_login
(
	user_id		int,
	login_date	date
);
insert into user_login values(1, convert(datetime,'01/03/2024',103));
insert into user_login values(1, convert(datetime,'02/03/2024',103));
insert into user_login values(1, convert(datetime,'03/03/2024',103));
insert into user_login values(1, convert(datetime,'04/03/2024',103));
insert into user_login values(1, convert(datetime,'06/03/2024',103));
insert into user_login values(1, convert(datetime,'10/03/2024',103));
insert into user_login values(1, convert(datetime,'11/03/2024',103));
insert into user_login values(1, convert(datetime,'12/03/2024',103));
insert into user_login values(1, convert(datetime,'13/03/2024',103));
insert into user_login values(1, convert(datetime,'14/03/2024',103));
insert into user_login values(1, convert(datetime,'20/03/2024',103));
insert into user_login values(1, convert(datetime,'25/03/2024',103));
insert into user_login values(1, convert(datetime,'26/03/2024',103));
insert into user_login values(1, convert(datetime,'27/03/2024',103));
insert into user_login values(1, convert(datetime,'28/03/2024',103));
insert into user_login values(1, convert(datetime,'29/03/2024',103));
insert into user_login values(1, convert(datetime,'30/03/2024',103));
insert into user_login values(2, convert(datetime,'01/03/2024',103));
insert into user_login values(2, convert(datetime,'02/03/2024',103));
insert into user_login values(2, convert(datetime,'03/03/2024',103));
insert into user_login values(2, convert(datetime,'04/03/2024',103));
insert into user_login values(3, convert(datetime,'01/03/2024',103));
insert into user_login values(3, convert(datetime,'02/03/2024',103));
insert into user_login values(3, convert(datetime,'03/03/2024',103));
insert into user_login values(3, convert(datetime,'04/03/2024',103));
insert into user_login values(3, convert(datetime,'04/03/2024',103));
insert into user_login values(3, convert(datetime,'04/03/2024',103));
insert into user_login values(3, convert(datetime,'05/03/2024',103));
insert into user_login values(4, convert(datetime,'01/03/2024',103));
insert into user_login values(4, convert(datetime,'02/03/2024',103));
insert into user_login values(4, convert(datetime,'03/03/2024',103));
insert into user_login values(4, convert(datetime,'04/03/2024',103));
insert into user_login values(4, convert(datetime,'04/03/2024',103));


     
     
   with cte as 
	(
      select *,dense_rank() over(partition by user_id order by user_id,login_date) as rno
	  from user_login
 	),
    cte1 as 
    (
	  select distinct *,dateadd(day,-rno,login_date) as initial_date from cte 
     )
     select user_id,min(login_date) as start_date,max(login_date) as end_date,count(*) as consecutive_days from cte1
     group by user_id,initial_date
     having count(*)>=5
     order by user_id
 
 
 













