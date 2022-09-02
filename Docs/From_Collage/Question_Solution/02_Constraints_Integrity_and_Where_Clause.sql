-- Create the relations an bellow:
-- Employee(eid(pk), ename, dateofemploy, salary)
-- Booklist(isbn(pk), name, publication)
-- Book(bid(pk), bname, auther, price)
-- Issues(IID, name, dateofissue)

CREATE TABLE employee(
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    dateofemploy DATE DEFAULT '01/01/2010',
    salary DECIMAL(20,10)
);
CREATE TABLE booklist(
    isbn INT,
    name VARCHAR(50),
    publication VARCHAR(50),
    PRIMARY KEY(isbn)
);
CREATE TABLE book(
    bid INT,
    bname VARCHAR(50),
    author VARCHAR(50),
    price DECIMAL(20,10),
    FOREIGN KEY(bid) REFERENCES booklist(isbn) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE issues(
    iid INT,
    name VARCHAR(50),
    dateofissue DATE,
    FOREIGN KEY(iid) REFERENCES employee(eid) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Q2) Modify relation teacher and student
-- i) Set Tid as foreign key
-- ii) Set SID as primary key
-- iii) Delete RN attribute

-- i)
ALTER TABLE teacher
ADD CONSTRAINT tid_foreign FOREIGN KEY(tid)
REFERENCES employee(eid)
ON DELETE CASCADE ON UPDATE CASCADE;

-- ii)
ALTER TABLE student
ADD CONSTRAINT sid_primary PRIMARY KEY(sid);

-- iii)
ALTER TABLE student
DROP COLUMN RN;

-- Q2) Set dedfault value of 'dateofemploy' attribute as jan 1, 2021
ALTER TABLE employee
ALTER dateofemploy SET DEFAULT '01/01/2021';

-- Q3) Assign Bid and Iid as foreign key

-- Q6) Insert any 4 records in each relation
INSERT INTO employee(eid, ename, dateofemploy, salary)
VALUES (1,'Brad', '01/01/2070', 20000);
INSERT INTO employee(eid, ename, dateofemploy, salary)
VALUES (2,'Jack', '01/01/2070', 40000);
INSERT INTO employee(eid, ename, dateofemploy, salary)
VALUES (3,'Bruce', '01/01/2070', 35000);
INSERT INTO employee(eid, ename, dateofemploy, salary)
VALUES (4,'Himal', '01/01/2070', 44000);

INSERT INTO booklist(isbn, name, publication)
VALUES (1, 'DSA', 'hcoe');
INSERT INTO booklist(isbn, name, publication)
VALUES (2, 'STAT1', 'astha');
INSERT INTO booklist(isbn, name, publication)
VALUES (3, 'STAT2', 'asmita');
INSERT INTO booklist(isbn, name, publication)
VALUES (4, 'DBMS', 'hcoe');

INSERT INTO book(bid, bname, author, price)
VALUES (1,'DSA','Roman', 2000);
INSERT INTO book(bid, bname, author, price)
VALUES (2,'STAT1','Jack', 2000);
INSERT INTO book(bid, bname, author, price)
VALUES (3,'STAT2','Tim', 2000);
INSERT INTO book(bid, bname, author, price)
VALUES (4,'DBMS','Hanry', 2000);

INSERT INTO issues(iid, name, dateofissue)
VALUES (1,'DSA','01/01/2021');
INSERT INTO issues(iid, name, dateofissue)
VALUES (2,'DBMS','04/30/2021');
INSERT INTO issues(iid, name, dateofissue)
VALUES (3,'DSA','05/24/2022');
INSERT INTO issues(iid, name, dateofissue)
VALUES (1,'STAT1','12/21/2019');

-- Q7) Display all records from all relations
SELECT * FROM employee;
SELECT * FROM booklist;
SELECT * FROM book;
SELECT * FROM issues;

-- Q8) Display eid and ename of all employes whose salary is less than 20000.
SELECT eid, ename FROM employee WHERE salary < 20000;

-- Q9) Display all records of book whose price range from 200 to 5000.
SELECT * FROM book WHERE price >= 2000 AND price <= 5000;

-- Q10) Display all the records from booklist relation whose publication name starts from 'a'
SELECT * FROM booklist WHERE publication LIKE 'a%';

-- Q11) Display all records from employee table whose name ends with 'd'.
SELECT * FROM employee WHERE ename LIKE '%d';

-- Q12) Display all records from employee table whose name exactly consist of 5 characters.
SELECT * FROM employee WHERE ename LIKE '_____';

-- Q13) Display all records from employee table where name start with 'B' and salary greater than 22000
SELECT * FROM employee WHERE ename LIKE 'B%' AND salary < 22000;

-- Q14) Display all records from book table where either bookid lies in range 1001 to 1000 or price range in 1000 to 2500
SELECT * FROM book WHERE bid > 1000 AND bid <= 2001 OR price >= 1000 AND price <= 2500;

-- Q15) Display isbn number and bookname where booklist must not contain isbn no. 1003
SELECT * FROM booklist WHERE isbn != 1003;