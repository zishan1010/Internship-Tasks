CREATE DATABASE university;
USE university;
SHOW TABLES;

CREATE TABLE Departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(100)
);

CREATE TABLE Professors (
  professor_id INT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(20)
);

CREATE TABLE Students (
  student_id INT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(20),
  date_of_birth DATE,
  enrollment_date DATE,
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(100),
  department_id INT,
  professor_id INT,
  credits INT,
  FOREIGN KEY (department_id) REFERENCES Departments(department_id),
  FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

CREATE TABLE Enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  enrollment_date DATE,
  grade VARCHAR(5),
  FOREIGN KEY (student_id) REFERENCES Students(student_id),
  FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Departments VALUES (1, 'Computer Science'), (2, 'Mechanical'), (3, 'Electrical');

INSERT INTO Professors VALUES
(1, 'Raj', 'Sharma', 'raj@example.com', '9999999999'),
(2, 'Anita', 'Verma', 'anita@example.com', '8888888888');

INSERT INTO Students VALUES
(101, 'Zishan', 'Khan', 'zishan@example.com', '7777777777', '2000-01-01', '2022-07-01', 1),
(102, 'Rahul', 'Yadav', 'rahul@example.com', '6666666666', '2001-03-04', '2022-07-01', 2),
(103, 'Simran', 'Singh', 'simran@example.com', '5555555555', '2002-05-10', '2022-07-01', 1);

INSERT INTO Courses VALUES
(1, 'Database Systems', 1, 1, 4),
(2, 'Operating Systems', 1, 2, 3),
(3, 'Thermodynamics', 2, 2, 3);

INSERT INTO Enrollments VALUES
(1, 101, 1, '2022-08-01', '85'),
(2, 102, 2, '2022-08-05', '78'),
(3, 101, 2, '2022-08-06', '90');

-- 1. Total Students in Each Department
SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM Students s
JOIN Departments d ON s.department_id = d.department_id
GROUP BY d.department_name;

-- 2. Courses Taught by a Specific Professor
SELECT c.course_name
FROM Courses c
WHERE c.professor_id = 2;

-- 3. Average Grade of Students in Each Course
SELECT 
    c.course_name, 
    AVG(CASE
        WHEN e.grade REGEXP '^[0-9]+(\\.[0-9]+)?$' THEN CAST(e.grade AS DECIMAL(10,2))
        ELSE NULL
    END) AS average_grade
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

-- 4. Students Not Enrolled in Any Courses
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- 5. Number of Courses Offered by Each Department
SELECT d.department_name, COUNT(c.course_id) AS course_count
FROM Departments d
JOIN Courses c ON d.department_id = c.department_id
GROUP BY d.department_name;

-- 6. Students Who Took 'Database Systems'
SELECT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Database Systems';

-- 7. Most Popular Course by Enrollment
SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name
ORDER BY enrollment_count DESC
LIMIT 1;

-- 8. Average Credits Per Student in a Department
SELECT d.department_name, AVG(course_credits) AS avg_credits_per_student
FROM (
    SELECT s.student_id, s.department_id, SUM(c.credits) AS course_credits
    FROM Students s
    JOIN Enrollments e ON s.student_id = e.student_id
    JOIN Courses c ON e.course_id = c.course_id
    GROUP BY s.student_id, s.department_id
) student_courses
JOIN Departments d ON student_courses.department_id = d.department_id
GROUP BY d.department_name;

-- 9. Professors Teaching in More Than One Department
SELECT p.first_name, p.last_name, COUNT(DISTINCT c.department_id) AS department_count
FROM Professors p
JOIN Courses c ON p.professor_id = c.professor_id
GROUP BY p.professor_id, p.first_name, p.last_name
HAVING COUNT(DISTINCT c.department_id) > 1;

-- 10. Highest and Lowest Grade in 'Operating Systems'
SELECT c.course_name,
       MAX(e.grade) AS highest_grade,
       MIN(e.grade) AS lowest_grade
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Operating Systems'
GROUP BY c.course_name;
