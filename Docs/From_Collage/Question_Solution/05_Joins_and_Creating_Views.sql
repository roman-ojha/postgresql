-- Q1) Perform join operation on teacher and employee table and display the ename, faculty and salary
SELECT ename, faculty, employee.salary FROM teacher JOIN employee ON eid = tid;

-- Q2) Perform left join on table book list and book table.
SELECT * FROM booklist LEFT JOIN book ON isbn = bid;

-- Q3) Perform right join on booklist and book table
SELECT * FROM booklist RIGHT JOIN book ON isbn = bid;

-- Q4) Perform full oin on student and issues table
SELECT * FROM student JOIN issues ON iid = sid;

-- Q5) Display those employees name and salary whose name start with 's' and whose name consist 'ni' as sub string.
SELECT ename, salary FROM employee WHERE ename LIKE 's%' AND ename LIKE '%ni%'; 

-- Q6) Display name of the employee who is also a teacher
SELECT ename FROM employee JOIN teacher ON eid = tid;

-- Q7) Display all employees name except the name who are teacher
SELECT ename FROM employee WHERE eid NOT IN (SELECT tid FROM teacher);

-- Q8) Create a view Employee_view shich consist of eid, ename, salary as attributes
CREATE VIEW employee_view AS
SELECT eid, ename, salary 
FROM employee;

-- Q9) Insert a new record in recently created view. and also display the contents if primary table
INSERT INTO employee_view(eid, ename, salary)
VALUES (5, 'Ram', 36000);

-- Q10) Delete the information from view where salary are less then 5000
DELETE FROM employee_view WHERE salary < 5000;