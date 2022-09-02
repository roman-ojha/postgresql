-- Q1) Sort the employee records in descending order
SELECT * FROM employee ORDER BY ename DESC;

-- Q2) Sort name and publication name in ascending order
SELECT name, publication FROM booklist ORDER BY name;

-- Q3) Display top three records from teachers relation.
SELECT * FROM teacher LIMIT 3;

-- Q4) Display the sum of salaries of all employees
SELECT SUM(salary) as sum_salary FROM employee;

-- Q5) Display the minimum salary of employee
SELECT MIN(salary) as minimum_salary FROM employee;

-- Q6) Display the averate price of book writen by same author
SELECT author, AVG(price) as avg_book_price FROM book GROUP BY author;

-- Q7) display publication name and number of books published by it from book list relation publication wise.
SELECT publication, COUNT(*) FROM booklist GROUP BY publication ORDER BY publication;

-- Q8) Display the bid and bname of books whose price is greater than average prices of book.
SELECT bid, bname FROM book WHERE price > (SELECT AVG(price) FROM book);

-- Q9) Find the bid, bname and author in ascending order where author name is started by 'R'.
SELECT bid, bname, author FROM book WHERE author LIKE 'R%' ORDER BY author;

-- Q10) Find the employee name and book taken by him. The employee salary who take the book should be the maximum salary.
SELECT e.ename, i.name FROM employee as e, issues as i WHERE e.eid = i.iid AND e.salary = (SELECT MAX(salary) FROM employee);

-- Q11) Find the authors name who have written more than one book.
SELECT author, COUNT(*) FROM book GROUP BY author HAVING COUNT(author) > 1;