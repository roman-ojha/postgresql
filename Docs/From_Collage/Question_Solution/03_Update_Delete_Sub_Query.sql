-- Q1) Find all bookname, publication name and author name where publication name is 'astha'
SELECT book.bname, bl.publication, book.author FROM book, booklist as bl WHERE bl.publication = 'astha';

-- Q2) Find the teachers name and faculty who issued book on jan 1, 2021.
SELECT t.name, t.faculty FROM employee as e, teacher as t, issues as i WHERE e.eid = t.tid AND e.eid = i.iid AND i.dateofissue = '01/01/2021';

-- Q3) Find the employee name whose salary is greater then 10000 and faculty is 'Computer'.
SELECT e.ename FROM employee as e, teacher as t WHERE e.eid = t.tid AND e.salary > 10000 AND t.faculty = 'Computer';

-- Q4) Add attribute bid on Issues relation
ALTER TABLE issues
ADD COLUMN bid INT
REFERENCES booklist(isbn) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- Q5) Insert the data in bid column
UPDATE issues
SET bid = 1
WHERE iid = 1;
UPDATE issues
SET bid = 2
WHERE iid = 2;
UPDATE issues
SET bid = 1
WHERE iid = 3;

-- Q6) Find the Teacher's name, and book namd issued by the teacher whose name starts with 'S'.
SELECT t.name as tname, i.name as bookname FROM teacher as t,employee as e, issues as i WHERE t.tid = e.eid AND e.eid = i.iid AND t.name LIKE 'B';

-- Q7) Update all salary by 10%
UPDATE employee
SET salary = salary * 1.10;

-- Q8) Update book name DBMS as DATABASE
UPDATE booklist
SET name = 'DATABASE'
WHERE name = 'DSA';
UPDATE book
SET bname = 'DATABASE'
WHERE bname = 'DSA';
UPDATE issues
SET name = 'DATABASE'
WHERE name = 'DSA';

-- Q9) Update the salary of all employee by 20% whose salary is less than 5000.
UPDATE employee
SET salary = salary * 1.20
WHERE salary < 5000;

-- Q10) Provide 5% increment to all salaries whose salary is greater than 20000 and 20% increment in rest of salary
UPDATE employee
SET salary 
CASE WHEN salary > 20000 THEN salary * 1.05
ELSE salary * 1.2
END;

-- Q11) Delete the record from employee table whose eid is 111.  
DELETE FROM employee
WHERE eid = 111;

-- Q12) Use sub query to find all teacher name and faculty whose date of employee is jan 1, 2070
SELECT name, faculty FROM teacher WHERE tid IN (SELECT teacher.tid FROM teacher, employee as e WHERE e.eid = teacher.tid AND dateofemploy = '01/01/2070');

-- Q13) Use sub query to find all the book name and auther name whose publication is 'hcoe'
