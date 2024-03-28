/*
PROBLEM STATEMENT: 
Given vacation_plans tables shows the vacations applied by each employee during the year 2024. 
Leave_balance table has the available leaves for each employee.
Write an SQL query to determine if the vacations applied by each employee can be approved or not based on the available leave balance. 
If an employee has enough available leaves then mention the status as "Approved" else mention "Insufficient Leave Balance".
Assume there are no public holidays during 2024. weekends (sat & sun) should be excluded while calculating vacation days. 
*/

drop table if exists vacation_plans;
create table vacation_plans
(
	id 			int primary key,
	emp_id		int,
	from_dt		date,
	to_dt		date
);
insert into vacation_plans values(1,1, '2024-02-12', '2024-02-16');
insert into vacation_plans values(2,2, '2024-02-20', '2024-02-29');
insert into vacation_plans values(3,3, '2024-03-01', '2024-03-31');
insert into vacation_plans values(4,1, '2024-04-11', '2024-04-23');
insert into vacation_plans values(5,4, '2024-06-01', '2024-06-30');
insert into vacation_plans values(6,3, '2024-07-05', '2024-07-15');
insert into vacation_plans values(7,3, '2024-08-28', '2024-09-15');


drop table if exists leave_balance;
create table leave_balance
(
	emp_id			int,
	balance			int
);
insert into leave_balance values (1, 12);
insert into leave_balance values (2, 10);
insert into leave_balance values (3, 26);
insert into leave_balance values (4, 20);
insert into leave_balance values (5, 14);


with cte as (
  select from_dt,to_dt,
    vp.id,
    vp.emp_id,
    lb.balance,
    datediff(day, vp.from_dt, vp.to_dt) - datediff(week, vp.from_dt, vp.to_dt) * 2 + 1 as vacation_days,
    row_number() over(partition by vp.emp_id order by vp.id) as rn
  from  
    vacation_plans vp 
  inner join  
    leave_balance lb on vp.emp_id = lb.emp_id
),
rcte as (
  select 
    *,
    balance - vacation_days as balance_left
  from 
    cte 
  where 
    rn = 1 
  
  union all
  
  select 
    c.*,
    rc.balance_left - c.vacation_days as balance_left
  from 
    rcte rc
  join 
    cte c on c.rn = rc.rn + 1 and c.emp_id=rc.emp_id
)
select id,emp_id,from_dt,to_dt,vacation_days ,
case when balance_left>=0 then 'Approved' else 'Not approved' end as status
from rcte
order by status,emp_id;












