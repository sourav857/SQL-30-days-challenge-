-- Find out the employees who attended all compan events

drop table if exists employees;
create table employees
(
	id			int,
	name		varchar(50)
);
insert into employees values(1, 'Lewis');
insert into employees values(2, 'Max');
insert into employees values(3, 'Charles');
insert into employees values(4, 'Sainz');


drop table if exists events;
create table events
(
	event_name		varchar(50),
	emp_id			int,
	dates			date
);
INSERT INTO events VALUES ('Product launch', 1, CONVERT(DATETIME, '01-03-2024', 103));
INSERT INTO events VALUES ('Product launch', 3, CONVERT(DATETIME, '01-03-2024', 103));
INSERT INTO events VALUES ('Product launch', 4, CONVERT(DATETIME, '01-03-2024', 103));
INSERT INTO events VALUES ('Conference', 2, CONVERT(DATETIME, '02-03-2024', 103));
INSERT INTO events VALUES ('Conference', 2, CONVERT(DATETIME, '03-03-2024', 103));
INSERT INTO events VALUES ('Conference', 3, CONVERT(DATETIME, '02-03-2024', 103));
INSERT INTO events VALUES ('Conference', 4, CONVERT(DATETIME, '02-03-2024', 103));
INSERT INTO events VALUES ('Training', 3, CONVERT(DATETIME, '04-03-2024', 103));
INSERT INTO events VALUES ('Training', 2, CONVERT(DATETIME, '04-03-2024', 103));
INSERT INTO events VALUES ('Training', 4, CONVERT(DATETIME, '04-03-2024', 103));
INSERT INTO events VALUES ('Training', 4, CONVERT(DATETIME, '05-03-2024', 103));


select name as employee_name,count(DISTINCT event_name) as no_of_events from employees emp join 
events ev on emp.id=ev.emp_id
group by id,name 
having count(DISTINCT event_name)=3














