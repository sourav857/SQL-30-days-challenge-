/*
PROBLEM STATEMENT: Given tables represent the marks scored by engineering students.
Create a report to display the following results for each student.
  - Student_id, Student name
  - Total Percentage of all marks
  - Failed subjects (must be comma seperated values in case of multiple failed subjects)
  - Result (if percentage >= 70% then 'First Class', if >= 50% & <=70% then 'Second class', 
  if <=50% then 'Third class' else 'Fail'.
 The result should be Fail if a students fails in any subject irrespective of the percentage marks)
	
	*** The sequence of subjects in student_marks table match with the sequential id from subjects table.
	*** Students have the option to choose either 4 or 5 subjects only.
*/


create table students
(
	roll_no		varchar(20) primary key,
	name		varchar(30)		
);
insert into students values('2GR5CS011', 'Maryam');
insert into students values('2GR5CS012', 'Rose');
insert into students values('2GR5CS013', 'Alice');
insert into students values('2GR5CS014', 'Lilly');
insert into students values('2GR5CS015', 'Anna');
insert into students values('2GR5CS016', 'Zoya');


create table student_marks
(
	student_id		varchar(20) primary key references students(roll_no),
	subject1		int,
	subject2		int,
	subject3		int,
	subject4		int,
	subject5		int,
	subject6		int
);
insert into student_marks values('2GR5CS011', 75, NULL, 56, 69, 82, NULL);
insert into student_marks values('2GR5CS012', 57, 46, 32, 30, NULL, NULL);
insert into student_marks values('2GR5CS013', 40, 52, 56, NULL, 31, 40);
insert into student_marks values('2GR5CS014', 65, 73, NULL, 81, 33, 41);
insert into student_marks values('2GR5CS015', 98, NULL, 94, NULL, 90, 20);
insert into student_marks values('2GR5CS016', NULL, 98, 98, 81, 84, 89);


create table subjects
(
	id				varchar(20) primary key,
	name			varchar(30),
	pass_marks  	int check (pass_marks>=30)
);
insert into subjects values('S1', 'Mathematics', 40);
insert into subjects values('S2', 'Algorithms', 35);
insert into subjects values('S3', 'Computer Networks', 35);
insert into subjects values('S4', 'Data Structure', 40);
insert into subjects values('S5', 'Artificial Intelligence', 30);
insert into subjects values('S6', 'Object Oriented Programming', 35);



WITH cte1 AS (
    SELECT 
        student_id,
        subject1 AS marks,
        'S1' AS subject 
    FROM 
        student_marks 
    WHERE 
        subject1 IS NOT NULL
    UNION ALL 
    SELECT 
        student_id,
        subject2 AS marks,
        'S2' AS subject 
    FROM 
        student_marks 
    WHERE 
        subject2 IS NOT NULL
    UNION ALL
    SELECT 
        student_id,
        subject3 AS marks,
        'S3' AS subject 
    FROM 
        student_marks 
    WHERE 
        subject3 IS NOT NULL
    UNION ALL 
    SELECT 
        student_id,
        subject4 AS marks,
        'S4' AS subject 
    FROM 
        student_marks 
    WHERE 
        subject4 IS NOT NULL
    UNION ALL 
    SELECT 
        student_id,
        subject5 AS marks,
        'S5' AS subject 
    FROM 
        student_marks 
    WHERE 
        subject5 IS NOT NULL
    UNION ALL 
    SELECT 
        student_id,
        subject6 AS marks,
        'S6' AS subject 
    FROM 
        student_marks 
    WHERE 
        subject6 IS NOT NULL
),
cte2 AS (
    SELECT 
        c.student_id,
        stu.name,
        s.name AS n1,
        c.marks,
        pass_marks,
        CASE 
            WHEN pass_marks > c.marks THEN 'Fail' 
            ELSE 'Pass' 
        END AS pass_fail,
        CASE 
            WHEN COUNT(s.name) OVER (PARTITION BY student_id) = 4 THEN 
                ROUND(
                    (
                        SUM(marks) OVER (PARTITION BY student_id ORDER BY s.id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) * 100.0 / 400
                    ), 2
                )
            ELSE
                ROUND(
                    (
                        SUM(marks) OVER (PARTITION BY student_id ORDER BY s.id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) * 100.0 / 500
                    ), 2
                )
        END AS percentage
    FROM 
        cte1 c 
    LEFT JOIN 
        subjects s ON s.id = c.subject
    JOIN 
        students stu ON stu.roll_no = c.student_id
),
cte3 AS (
    SELECT 
        student_id,
        name,
        percentage,
        STRING_AGG(CASE WHEN pass_fail = 'Fail' THEN n1 END, ',') AS failed_subjects
    FROM 
        cte2
    GROUP BY 
        student_id,
        name,
        percentage
),
cte4 AS (
    SELECT 
        *,
        CASE 
            WHEN failed_subjects IS NOT NULL THEN 'Fail'
            WHEN percentage > 70 THEN 'First Class'
            WHEN percentage >= 50 AND percentage <= 70 THEN 'Second Class'
            WHEN percentage <= 50 THEN 'Third Class'
        END AS Result
    FROM 
        cte3
)
SELECT 
    student_id,
    name,
    percentage,
    COALESCE(failed_subjects, '-') AS Failed_subjects,
    Result
FROM 
    cte4
ORDER BY 
    student_id;

