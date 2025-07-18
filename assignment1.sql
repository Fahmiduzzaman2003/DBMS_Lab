create database academic_lab;
use academic_lab;
create table students(
student_id int primary key,
student_name varchar(255) not null
);
create table courses(
course_id int primary key ,
course_name varchar(255) not null

);
create table enrollments(
enrollment_id int primary key,
student_id int not null ,
course_id int not null,
grade char not null ,
foreign key (student_id) references students(student_id),
foreign key (course_id) references courses(course_id),
unique(student_id,course_id)
);
insert into students(student_id,student_name) values 
(1,'Kamran'),
(2,'Fahmid'),
(3,'Nayem'),
(4,'Sayed'),
(5,'Jayed');
select *from students ;
insert into courses(course_id,course_name) values
(101,'Discrete Maths'),
(102,'Data Structure'),
(103,'OOP'),
(104,'Algorithms'),
(105,'Data Science');
select *from courses ;
insert into enrollments(enrollment_id,student_id,course_id,grade) values
(1,1,101,'A'),
(2,2,102,'B'),
(3,3,103,'A'),
(4,4,104,'B'),
(5,5,105,'A');
select *from enrollments;

select *from enrollments where grade='A';
select *from courses where course_id=104;
insert into enrollments (enrollment_id,student_id,course_id,grade) values
(1,1,101,'A');
select *from enrollments ;

select *from enrollments ;
delete from enrollments where enrollment_id>=1;
insert into enrollments (enrollment_id,student_id,course_id,grade) values
(6,6,101,'A');
select *from enrollments;
insert into enrollments (enrollment_id,student_id,course_id,grade) values
(6,5,106,'A');

















