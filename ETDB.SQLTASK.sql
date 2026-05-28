CREATE DATABASE ETDB;

USE ETDB;

CREATE TABLE mst_Department
(
    DepartmentId INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(100)
);

CREATE TABLE mst_Employee
(
    EmployeeId INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    DepartmentId INT,
    Email VARCHAR(100),

    CONSTRAINT FK_Employee_Department
    FOREIGN KEY (DepartmentId)
    REFERENCES mst_Department(DepartmentId)
);

ALTER TABLE mst_Employee
ADD
CreatedOn DATETIME DEFAULT GETDATE(),
CreatedBy VARCHAR(100) DEFAULT 'Admin',
UpdatedOn DATETIME ,
UpdatedBy VARCHAR(100) ,
IsActive BIT DEFAULT 1;

SELECT *
FROM mst_Employee;

UPDATE mst_Employee
SET
CreatedOn = GETDATE(),
CreatedBy = 'Admin',
IsActive = 1
WHERE CreatedOn IS NULL;

SELECT *
FROM mst_Employee;

CREATE TABLE tbl_EmployeeTransaction
(
    TransactionId INT PRIMARY KEY IDENTITY(1,1),
    EmployeeId INT,
    TransactionAmount DECIMAL(10,2),
    TransactionDate DATETIME,
    TransactionType VARCHAR(50),

    CONSTRAINT FK_Transaction_Employee
    FOREIGN KEY(EmployeeId)
    REFERENCES mst_Employee(EmployeeId)
);

ALTER TABLE tbl_EmployeeTransaction
ADD
CreatedOn DATETIME DEFAULT GETDATE(),
CreatedBy VARCHAR(100) DEFAULT 'Admin',
UpdatedOn DATETIME ,
UpdatedBy VARCHAR(100) ,
IsActive BIT DEFAULT 1;

SELECT *
FROM tbl_EmployeeTransaction;

INSERT INTO mst_Department(DepartmentName)
VALUES
('HR'),
('IT'),
('Finance'),
('Admin');

SELECT *
FROM mst_Department;


INSERT INTO mst_Employee(EmployeeName, DepartmentId, Email)
VALUES
('Divya',1,'divya@gmail.com'),
('Harini',2,'harini@gmail.com'),
('Pallavi',3,'pallavi@gmail.com'),
('Kiran',4,'kiran@gmail.com');

SELECT *
FROM mst_Employee;

CREATE TYPE udt_EmployeeTransactionType AS TABLE
(
    EmployeeId INT,
    TransactionAmount DECIMAL(10,2),
    TransactionDate DATETIME,
    TransactionType VARCHAR(50)
);

CREATE PROCEDURE usp_BulkInsertEmployeeTransaction
(
    @TransactionData udt_EmployeeTransactionType READONLY
)
AS
BEGIN

    BEGIN TRY

        BEGIN TRANSACTION;

        INSERT INTO tbl_EmployeeTransaction
        (
            EmployeeId,
            TransactionAmount,
            TransactionDate,
            TransactionType
        )
        SELECT
            EmployeeId,
            TransactionAmount,
            TransactionDate,
            TransactionType
        FROM @TransactionData;

        COMMIT TRANSACTION;

        PRINT 'Bulk Insert Successful';

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        PRINT ERROR_MESSAGE();

    END CATCH

END;

EXEC sp_helptext 'usp_BulkInsertEmployeeTransaction';

DECLARE @TransactionData udt_EmployeeTransactionType;

INSERT INTO @TransactionData
VALUES
(1,5000,'2026-05-20','Credit'),
(2,3000,'2026-05-21','Debit'),
(3,4500,'2026-05-22','Credit'),
(4,2500,'2026-05-23','Debit'),
(1,7000,'2026-05-24','Credit'),
(2,3500,'2026-05-25','Debit'),
(3,4200,'2026-05-26','Credit'),
(4,6000,'2026-05-27','Credit'),
(1,2000,'2026-05-28','Debit'),
(2,8000,'2026-05-29','Credit'),

(1,9000,'2026-05-30','Credit'),
(2,6500,'2026-05-31','Debit'),
(3,7200,'2026-06-01','Credit'),
(4,8100,'2026-06-02','Debit'),
(1,5500,'2026-06-03','Credit'),
(2,4300,'2026-06-04','Debit'),
(3,7600,'2026-06-05','Credit'),
(4,2900,'2026-06-06','Debit'),
(1,9100,'2026-06-07','Credit'),
(2,3700,'2026-06-08','Debit'),

(1,5100,'2026-06-09','Credit'),
(2,3200,'2026-06-10','Debit'),
(3,4700,'2026-06-11','Credit'),
(4,2800,'2026-06-12','Debit'),
(1,7600,'2026-06-13','Credit'),
(2,3900,'2026-06-14','Debit'),
(3,4300,'2026-06-15','Credit'),
(4,6100,'2026-06-16','Debit'),
(1,2500,'2026-06-17','Credit'),
(2,8200,'2026-06-18','Debit'),

(1,5300,'2026-06-19','Credit'),
(2,3100,'2026-06-20','Debit'),
(3,4800,'2026-06-21','Credit'),
(4,2600,'2026-06-22','Debit'),
(1,7700,'2026-06-23','Credit'),
(2,4100,'2026-06-24','Debit'),
(3,4400,'2026-06-25','Credit'),
(4,6200,'2026-06-26','Debit'),
(1,2700,'2026-06-27','Credit'),
(2,8300,'2026-06-28','Debit'),

(1,5400,'2026-06-29','Credit'),
(2,3300,'2026-06-30','Debit'),
(3,4900,'2026-07-01','Credit'),
(4,3000,'2026-07-02','Debit'),
(1,7800,'2026-07-03','Credit'),
(2,4200,'2026-07-04','Debit'),
(3,4500,'2026-07-05','Credit'),
(4,6300,'2026-07-06','Debit'),
(1,2800,'2026-07-07','Credit'),
(2,8400,'2026-07-08','Debit');

EXEC usp_BulkInsertEmployeeTransaction @TransactionData;

SELECT COUNT(*) AS TotalRecords
FROM tbl_EmployeeTransaction;

SELECT *
FROM tbl_EmployeeTransaction;

CREATE NONCLUSTERED INDEX IX_EmployeeId
ON tbl_EmployeeTransaction(EmployeeId);

EXEC sp_helpindex 'tbl_EmployeeTransaction';

DECLARE @PageNumber INT = 1;
DECLARE @PageSize INT = 5;

SELECT
    t.TransactionId,
    e.EmployeeName,
    d.DepartmentName,
    t.TransactionAmount,
    t.TransactionDate,
    t.TransactionType,
    COUNT(*) OVER() AS TotalRecords

FROM tbl_EmployeeTransaction t

INNER JOIN mst_Employee e
ON t.EmployeeId = e.EmployeeId

INNER JOIN mst_Department d
ON e.DepartmentId = d.DepartmentId

ORDER BY t.TransactionId

OFFSET (@PageNumber - 1) * @PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY;

UPDATE tbl_EmployeeTransaction
SET
CreatedOn = GETDATE(),
CreatedBy = 'Admin',
IsActive = 1
WHERE CreatedOn IS NULL;

SELECT *
FROM tbl_EmployeeTransaction;

