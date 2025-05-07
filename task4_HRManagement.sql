CREATE DATABASE HRManagement;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100),
    ManagerID INT
);

INSERT INTO Departments (DepartmentName, ManagerID) VALUES
('Human Resources', NULL),
('Engineering', NULL),
('Marketing', NULL);
UPDATE Departments SET ManagerID = 1 WHERE DepartmentID = 1;
UPDATE Departments SET ManagerID = 2 WHERE DepartmentID = 2;
UPDATE Departments SET ManagerID = 1 WHERE DepartmentID = 3;


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    HireDate DATE,
    DepartmentID INT,
    ManagerID INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
    
INSERT INTO Employees (FirstName, LastName, Email, Phone, HireDate, DepartmentID, ManagerID, Salary) VALUES
('Zishan', 'Khan', 'zishan.khan@example.com', '9174974745', '2023-06-01', 1, NULL, 55000),
('Amit', 'Verma', 'amit.verma@example.com', '9001112223', '2022-03-10', 2, 1, 75000),
('Sneha', 'Pawar', 'sneha.pawar@example.com', '9123456789', '2024-01-15', 3, 1, 65000),
('Raj', 'Singh', 'raj.singh@example.com', '9111223344', '2023-12-20', 2, 2, 72000);


CREATE TABLE PerformanceReviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    ReviewDate DATE,
    PerformanceScore ENUM('Excellent', 'Good', 'Average', 'Poor'),
    Comments TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
INSERT INTO PerformanceReviews (EmployeeID, ReviewDate, PerformanceScore, Comments) VALUES
(1, '2024-01-01', 'Excellent', 'Leadership skills and initiative.'),
(2, '2024-03-01', 'Good', 'Consistent performance.'),
(3, '2024-04-01', 'Excellent', 'Creative campaigns and collaboration.'),
(4, '2024-02-15', 'Average', 'Needs to improve deadline handling.');


CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentMethod ENUM('Bank Transfer', 'Check'),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
INSERT INTO Payroll (EmployeeID, PaymentDate, Amount, PaymentMethod) VALUES
(1, '2024-04-01', 55000, 'Bank Transfer'),
(2, '2024-04-01', 75000, 'Check'),
(3, '2024-04-01', 65000, 'Bank Transfer'),
(4, '2024-04-01', 72000, 'Bank Transfer');


-- 1.Retrieve the names and contact details of employees hired after January 1, 2023.
SELECT FirstName, LastName, Email, Phone, HireDate
FROM Employees
WHERE HireDate > '2023-01-01';

-- 2.Find the total payroll amount paid to each department.
SELECT D.DepartmentName, SUM(P.Amount) AS TotalPayroll
FROM Payroll P
JOIN Employees E ON P.EmployeeID = E.EmployeeID
JOIN Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName;

-- 3.List all employees who have not been assigned a manager.
SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE ManagerID IS NULL;

-- 4.Retrieve the highest salary in each department along with the employee’s name.
SELECT D.DepartmentName, E.FirstName, E.LastName, E.Salary
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE E.Salary = (
    SELECT MAX(Salary)
    FROM Employees
    WHERE DepartmentID = E.DepartmentID
);

-- 5.Find the most recent performance review for each employee.
SELECT PR.EmployeeID, E.FirstName, E.LastName, PR.ReviewDate, PR.PerformanceScore
FROM PerformanceReviews PR
JOIN Employees E ON PR.EmployeeID = E.EmployeeID
WHERE PR.ReviewDate = (
    SELECT MAX(ReviewDate)
    FROM PerformanceReviews
    WHERE EmployeeID = PR.EmployeeID
);

-- 6️.Count the number of employees in each department.
SELECT D.DepartmentName, COUNT(E.EmployeeID) AS TotalEmployees
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName;

-- 7. List all employees who have received a performance score of "Excellent.
-- List all employees who have received a performance score of "Excellent."
SELECT DISTINCT E.EmployeeID, E.FirstName, E.LastName
FROM PerformanceReviews PR
JOIN Employees E ON PR.EmployeeID = E.EmployeeID
WHERE PR.PerformanceScore = 'Excellent';

-- Identify the most frequently used payment method in payroll.
SELECT PaymentMethod, COUNT(*) AS UsageCount
FROM Payroll
GROUP BY PaymentMethod
ORDER BY UsageCount DESC
LIMIT 1;

-- 8.Retrieve the top 5 highest-paid employees along with their departments.
SELECT E.FirstName, E.LastName, E.Salary, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
ORDER BY E.Salary DESC
LIMIT 5;

-- 9.details of all employees who report directly to a specific manager (e.g., ManagerID = 101).
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary
FROM Employees
WHERE ManagerID = 101;