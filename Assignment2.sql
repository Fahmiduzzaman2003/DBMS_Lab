CREATE DATABASE DBm;
USE DBM;
--
CREATE TABLE Student (
  Student_ID INT PRIMARY KEY,
  Name VARCHAR(100),
  Age INT,
  Major VARCHAR(100)
);

INSERT INTO Student (Student_ID, Name, Age, Major) VALUES
(1, 'John Smith', 20, 'Computer Science'),
(2, 'Alice Brown', 22, 'Mathematics'),
(3, 'Bob White', 21, 'Physics'),
(4, 'Carol Green', 23, 'Biology'),
(5, 'Dave Black', 24, 'Engineering');
select *from Student;
--
CREATE TABLE Course (
  Course_ID VARCHAR(10) PRIMARY KEY,
  Course_Name VARCHAR(100),
  Credits INT
);

INSERT INTO Course (Course_ID, Course_Name, Credits) VALUES
('C101', 'Introduction to CS', 3),
('C102', 'Calculus I', 4),
('C103', 'General Physics', 3),
('C104', 'Biology 101', 3),
('C105', 'Electrical Eng.', 4);
select *from Course;
--

CREATE TABLE Instructor (
  Instructor_ID VARCHAR(10) PRIMARY KEY,
  Name VARCHAR(100),
  Department VARCHAR(50),
  Email VARCHAR(100)
);

INSERT INTO Instructor (Instructor_ID, Name, Department, Email) VALUES
('I001', 'Dr. Steve', 'Computer Science', 'steve@university.edu'),
('I002', 'Dr. Mary', 'Mathematics', 'mary@university.edu'),
('I003', 'Dr. John', 'Physics', 'john@university.edu'),
('I004', 'Dr. Alice', 'Biology', 'alice@university.edu'),
('I005', 'Dr. Bob', 'Engineering', 'bob@university.edu');
Select name from Instructor;
--
CREATE TABLE Department (
  Dept_Name VARCHAR(20) PRIMARY KEY,
  Building VARCHAR(15),
  Budget DECIMAL(12, 2)
);

INSERT INTO Department (Dept_Name, Building, Budget) VALUES
('Computer_Science', 'A-Block', 50000),
('Mathematics', 'B-Block', 30000),
('Physics', 'C-Block', 45000),
('Biology', 'D-Block', 35000),
('Engineering', 'E-Block', 60000);
select *from Department;
--
CREATE TABLE Takes (
  Student_ID INT,
  Course_ID VARCHAR(10),
  Semester VARCHAR(10),
  Year INT,
  PRIMARY KEY (Student_ID, Course_ID, Semester, Year),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

INSERT INTO Takes (Student_ID, Course_ID, Semester, Year) VALUES
(1, 'C101', 'Fall', 2023),
(2, 'C102', 'Spring', 2023),
(3, 'C103', 'Fall', 2023),
(4, 'C104', 'Spring', 2023),
(5, 'C105', 'Fall', 2023);
select *from Takes;
--
CREATE TABLE Teaches (
  Instructor_ID VARCHAR(10),
  Course_ID VARCHAR(10),
  Semester VARCHAR(10),
  Year INT,
  PRIMARY KEY (Instructor_ID, Course_ID, Semester, Year),
  FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

INSERT INTO Teaches (Instructor_ID, Course_ID, Semester, Year) VALUES
('I001', 'C101', 'Fall', 2023),
('I002', 'C102', 'Spring', 2023),
('I003', 'C103', 'Fall', 2023),
('I004', 'C104', 'Spring', 2023),
('I005', 'C105', 'Fall', 2023);
select *from Teaches;
--
CREATE TABLE StudentCourse (
  Student_ID INT,
  Course_ID VARCHAR(10),
  PRIMARY KEY (Student_ID, Course_ID),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

INSERT INTO StudentCourse (Student_ID, Course_ID) VALUES
(1, 'C101'),
(2, 'C102'),
(3, 'C103'),
(4, 'C104'),
(5, 'C105');
select *from StudentCourse;
--
DROP TABLE IF EXISTS Takes;

CREATE TABLE Takes (
  Student_ID INT,
  Course_ID VARCHAR(10),
  Semester VARCHAR(10),
  Year INT,
  Grade VARCHAR(2),
  PRIMARY KEY (Student_ID, Course_ID, Semester, Year),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

INSERT INTO Takes (Student_ID, Course_ID, Semester, Year, Grade) VALUES
(1, 'C101', 'Fall', 2023, 'A'),
(2, 'C102', 'Spring', 2023, 'B'),
(3, 'C103', 'Fall', 2023, 'C'),
(4, 'C104', 'Spring', 2023, 'B+'),
(5, 'C105', 'Fall', 2023, 'A');
select *from Takes;
--
ALTER TABLE Student
MODIFY COLUMN Age INT;


INSERT INTO Student (Student_ID, Name, Age, Major, Email)
VALUES (6, 'Eve White', 25, 'Chemistry', 'eve@email.com');


UPDATE Takes
SET Grade = 'A'
WHERE Student_ID = 1 AND Course_ID = 'C101';


DELETE FROM Teaches
WHERE Instructor_ID = 'I002';
Delete From Instructor 
where Instructor_ID='I003';
select*from Instructor;

SELECT * FROM Student;


SELECT * FROM Course;


SELECT * FROM Takes;


SELECT 
    *
FROM
    Instructor;

SELECT Student.Name, Course.Course_Name, Takes.Grade
FROM Takes
JOIN Student ON Takes.Student_ID = Student.Student_ID
JOIN Course ON Takes.Course_ID = Course.Course_ID;
--
select *from Instructor;
select *from Teaches;
select Instructor.name ,Teaches.Semester
from Instructor

natural join Teaches ;

drop table Teaches;
select *from Teaches;


INSERT INTO Takes (Student_ID, Course_ID, Semester, Year) 
VALUES (7, 'C102', 'Spring', 2023);
select Student.Name,Student.Age,StudentCourse.Course_ID
from Student , StudentCourse;
CREATE TABLE Teaches (
  Instructor_ID VARCHAR(10),
  Course_ID VARCHAR(10),
  Semester VARCHAR(10),
  Year INT,
  PRIMARY KEY (Instructor_ID, Course_ID, Semester, Year),
  FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

INSERT INTO Teaches (Instructor_ID, Course_ID, Semester, Year) VALUES
('I002', 'C102', 'Spring', 2023),
('I003', 'C103', 'Fall', 2023),
('I004', 'C104', 'Spring', 2023),
('I005', 'C105', 'Fall', 2023);
select Name,Course_ID

from Instructor,Teaches
where Instructor.Instructor_ID=Teaches.Instructor_ID;


select Name,Course_ID
From Instructor Natural Join Teaches;

Select Name,Course_ID,Age
from Instructor natural join Teaches natural join Student;
alter table Student Rename To Student_Info;
select *from Student_Info;
select concat(Name,'-',Major)As Student_Info
from Student_Info;
select Name, Age 
from Student_Info
order by Age desc;
select *from Student_Info;
Select Name,Age ,Major from Student_Info
order by Major asc,Age desc;

insert into Student_Info(Student_ID,Name,Age,Major,Email)
values 
(8,'Zamann',23,'Arts','zamann@gmail.com');
select Name,Age,Major from Student_Info
order by Age desc,Major Asc;

select name from Instructor;
























