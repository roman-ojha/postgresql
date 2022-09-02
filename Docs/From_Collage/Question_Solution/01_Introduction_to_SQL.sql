-- Create a database named 'HCOE' and create tables as following schema
-- Student(SID, Name, RN, Batch)
-- Teacher(TID, Name, Faculty)

CREATE DATABASE HCOE;
CREATE TABLE student(
    SID INT,
    Name VARCHAR(50),
    RN INT,
    Batch CHAR(4)
);
CREATE TABLE teacher(
    TID INT,
    Name VARCHAR(50),
    Faculty VARCHAR(50)
);

-- Q1) Insert any five records in each table
INSERT INTO student(SID, Name, RN, Batch)
VALUES (1,'Roman',25,'2076');
INSERT INTO student(SID, Name, RN, Batch)
VALUES (2,'Razz',26,'2077');
INSERT INTO student(SID, Name, RN, Batch)
VALUES (3,'Ram',27,'2078');
INSERT INTO student(SID, Name, RN, Batch)
VALUES (4,'Harry',28,'2079');
INSERT INTO student(SID, Name, RN, Batch)
VALUES (5,'Tom',29,'2078');

INSERT INTO teacher(TID, Name, Faculty)
VALUES (1, 'Brad', 'CSIT');
INSERT INTO teacher(TID, Name, Faculty)
VALUES (2, 'Jack', 'CIVIL');
INSERT INTO teacher(TID, Name, Faculty)
VALUES (3, 'Bruce', 'COMPUTER');
INSERT INTO teacher(TID, Name, Faculty)
VALUES (4, 'Himal', 'ARCHITECTURE');
INSERT INTO teacher(TID, Name, Faculty)
VALUES (5, 'Jary', 'BCA');

-- Q2) Display all records
SELECT * FROM student;
SELECT * FROM teacher;

-- Q3) Display only SID and Name form student
SELECT SID, Name FROM student;

-- Q4) Display Name and Faculty from Teacher table
SELECT NAME, Faculty FROM teacher;

-- Q5) Remove 'RN' attribute from student relation
ALTER TABLE student
DROP COLUMN RN;

-- Q6) Add 'Salary' attribute to teacher relation
ALTER TABLE teacher
ADD salary MONEY;

-- Q7) Copy SID and name attribute to new relation 'info_student'
SELECT SID, Name
INTO info_student
FROM student;

-- Q8) Delete all contents from info_student relation
DELETE FROM info_student;