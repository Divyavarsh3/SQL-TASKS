USE CompanyDB;

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Company;

CREATE TABLE Company (
    company_id INT IDENTITY(1,1) PRIMARY KEY,
    company_name VARCHAR(50),
    location VARCHAR(50),
    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);


CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    experience_years INT,
    company_id INT,
    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT,

    FOREIGN KEY (company_id)
    REFERENCES Company(company_id)
);

INSERT INTO Company
(company_name, location, created_on, created_by,
updated_on, updated_by, is_active)

VALUES
('TCS', 'Bangalore', GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Infosys', 'Hyderabad', GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Wipro', 'Chennai', GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Accenture', 'Pune', GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Capgemini', 'Mumbai', GETDATE(), 'Admin',
GETDATE(), 'Admin', 1);


SELECT * FROM Company;


INSERT INTO Employee
(emp_id, emp_name, department, salary,
experience_years, company_id,
created_on, created_by,
updated_on, updated_by, is_active)

VALUES

(101, 'Rahul', 'Developer', 50000, 3, 1,
GETDATE(), 'Admin', GETDATE(), 'Admin', 1),

(102, 'Sneha', 'Tester', 35000, 2, 2,
GETDATE(), 'Admin', GETDATE(), 'Admin', 1),

(103, 'Arjun', 'Developer', 60000, 5, 3,
GETDATE(), 'Admin', GETDATE(), 'Admin', 1),

(104, 'Priya', 'HR', 30000, 1, 4,
GETDATE(), 'Admin', GETDATE(), 'Admin', 1),

(105, 'Kiran', 'Developer', 45000, 2, 5,
GETDATE(), 'Admin', GETDATE(), 'Admin', 1);


SELECT * FROM Employee;

SELECT * FROM Employee
WHERE department = 'Developer';

SELECT * FROM Employee
WHERE salary > 40000
AND experience_years >= 2;

SELECT * FROM Employee
WHERE department = 'HR'
OR department = 'Tester';


SELECT * FROM Employee
WHERE emp_name LIKE 'R%';


SELECT * FROM Employee
ORDER BY salary DESC;

UPDATE Employee
SET salary = 55000
WHERE emp_id = 101;

SELECT * FROM Employee;

DELETE FROM Employee
WHERE emp_id = 104;

SELECT * FROM Employee;