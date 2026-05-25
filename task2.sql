USE CompanyDB;

DROP TABLE IF EXISTS EmployeeProject;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
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

CREATE TABLE Department (
    dept_id INT IDENTITY(1,1) PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE,
    company_id INT,

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT,

    FOREIGN KEY (company_id)
    REFERENCES Company(company_id)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    experience_years INT,

    company_id INT,
    dept_id INT,

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT,

    FOREIGN KEY (company_id)
    REFERENCES Company(company_id),

    FOREIGN KEY (dept_id)
    REFERENCES Department(dept_id)
);

CREATE TABLE Project (
    project_id INT IDENTITY(1,1) PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT
);

CREATE TABLE EmployeeProject (
    emp_id INT,
    project_id INT,
    role_name VARCHAR(50),

    created_on DATETIME,
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT,

    PRIMARY KEY(emp_id, project_id),

    FOREIGN KEY(emp_id)
    REFERENCES Employee(emp_id),

    FOREIGN KEY(project_id)
    REFERENCES Project(project_id)
);

INSERT INTO Company
(company_name, location,
created_on, created_by,
updated_on, updated_by, is_active)

VALUES

('TCS', 'Bangalore',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Infosys', 'Hyderabad',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Wipro', 'Chennai',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Accenture', 'Pune',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Capgemini', 'Mumbai',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1);

INSERT INTO Department
(dept_name, company_id,
created_on, created_by,
updated_on, updated_by, is_active)

VALUES

('Development', 1,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Testing', 2,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('HR', 3,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Support', 4,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Finance', 5,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1);

INSERT INTO Employee
(emp_id, emp_name, salary,
experience_years,
company_id, dept_id,
created_on, created_by,
updated_on, updated_by, is_active)

VALUES

(101, 'Rahul', 50000,
3,
1, 1,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

(102, 'Sneha', 35000,
2,
2, 2,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

(103, 'Arjun', 60000,
5,
3, 1,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

(104, 'Priya', 30000,
1,
4, 4,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

(105, 'Kiran', 45000,
2,
5, 5,
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1);

INSERT INTO Project
(project_name, start_date,
created_on, created_by,
updated_on, updated_by, is_active)

VALUES

('Payroll System', '2026-01-10',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('E-Commerce App', '2026-02-15',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

('Banking Portal', '2026-03-01',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1);

DELETE FROM EmployeeProject;

INSERT INTO EmployeeProject
(emp_id, project_id, role_name,
created_on, created_by,
updated_on, updated_by, is_active)

VALUES

(101, 1, 'Developer',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

(102, 2, 'Tester',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

(103, 3, 'Senior Developer',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

(104, 1, 'Support Engineer',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1),

(105, 2, 'Finance Analyst',
GETDATE(), 'Admin',
GETDATE(), 'Admin', 1);

SELECT * FROM EmployeeProject;

SELECT * FROM Company;

SELECT * FROM Department;

SELECT * FROM Employee;

SELECT * FROM Project;

SELECT * FROM Employee
WHERE salary > 40000;

SELECT * FROM Employee
WHERE experience_years >= 2;

SELECT * FROM Employee
WHERE emp_name LIKE 'R%';

SELECT
    e.emp_name,
    d.dept_name,
    c.company_name,
    p.project_name,
    ep.role_name,
    e.salary

FROM Employee e

JOIN Department d
ON e.dept_id = d.dept_id

JOIN Company c
ON e.company_id = c.company_id

JOIN EmployeeProject ep
ON e.emp_id = ep.emp_id

JOIN Project p
ON ep.project_id = p.project_id;

UPDATE Employee
SET salary = 55000
WHERE emp_id = 101;

SELECT * FROM Employee;

DELETE FROM EmployeeProject
WHERE emp_id = 104
AND project_id = 1;

DELETE FROM Employee
WHERE emp_id = 104;

SELECT * FROM Employee;

SELECT e.emp_name , d.dept_name
FROM Employee e 
INNER JOIN Department d 
ON e.dept_id = d.dept_id;


