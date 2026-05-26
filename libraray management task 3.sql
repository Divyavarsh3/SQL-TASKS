CREATE DATABASE LibraryManagementDB;
GO

USE LibraryManagementDB;
GO

CREATE TABLE mst_Category
(
    CategoryId INT PRIMARY KEY IDENTITY(1,1),

    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE mst_Author
(
    AuthorId INT PRIMARY KEY IDENTITY(1,1),

    AuthorName VARCHAR(100) NOT NULL
);

CREATE TABLE tbl_Books
(
    BookId INT PRIMARY KEY IDENTITY(1,1),

    BookName VARCHAR(100) NOT NULL,

    CategoryId INT NOT NULL,

    AuthorId INT NOT NULL,

    Price DECIMAL(10,2),

    PublishedYear INT,

    FOREIGN KEY (CategoryId)
    REFERENCES mst_Category(CategoryId),

    FOREIGN KEY (AuthorId)
    REFERENCES mst_Author(AuthorId)
);


CREATE TABLE tbl_Members
(
    MemberId INT PRIMARY KEY IDENTITY(1,1),

    MemberName VARCHAR(100),

    PhoneNumber VARCHAR(15),

    JoinDate DATE
);


CREATE TABLE tbl_IssueBooks
(
    IssueId INT PRIMARY KEY IDENTITY(1,1),

    BookId INT,

    MemberId INT,

    IssueDate DATE,

    ReturnDate DATE,

    FOREIGN KEY (BookId)
    REFERENCES tbl_Books(BookId),

    FOREIGN KEY (MemberId)
    REFERENCES tbl_Members(MemberId)
);



CREATE TABLE tbl_ErrorLog
(
    ErrorLogId INT PRIMARY KEY IDENTITY(1,1),

    ErrorMessage VARCHAR(500),

    ErrorProcedure VARCHAR(100),

    ErrorDate DATETIME
);


INSERT INTO mst_Category
(
    CategoryName
)
VALUES
('Programming'),
('Science'),
('History'),
('Fiction');


INSERT INTO mst_Author
(
    AuthorName
)
VALUES
('James'),
('Robert'),
('William'),
('David');


INSERT INTO tbl_Books
(
    BookName,
    CategoryId,
    AuthorId,
    Price,
    PublishedYear
)
VALUES
('SQL Basics',1,1,500,2022),
('Physics World',2,2,700,2021),
('Indian History',3,3,650,2020),
('Story Book',4,4,400,2023);


INSERT INTO tbl_Members
(
    MemberName,
    PhoneNumber,
    JoinDate
)
VALUES
('Arun','9876543210','2026-05-01'),
('Priya','9876543211','2026-05-02');


INSERT INTO tbl_IssueBooks
(
    BookId,
    MemberId,
    IssueDate,
    ReturnDate
)
VALUES
(1,1,'2026-05-20','2026-05-27'),
(2,2,'2026-05-21','2026-05-28');


SELECT
    b.BookName,
    c.CategoryName,
    a.AuthorName
FROM tbl_Books b
INNER JOIN mst_Category c
ON b.CategoryId = c.CategoryId
INNER JOIN mst_Author a
ON b.AuthorId = a.AuthorId;


SELECT
    m.MemberName,
    i.IssueDate
FROM tbl_Members m
LEFT JOIN tbl_IssueBooks i
ON m.MemberId = i.MemberId;


SELECT
    m.MemberName,
    i.IssueDate
FROM tbl_Members m
RIGHT JOIN tbl_IssueBooks i
ON m.MemberId = i.MemberId;


SELECT
    m.MemberName,
    i.IssueDate
FROM tbl_Members m
FULL JOIN tbl_IssueBooks i
ON m.MemberId = i.MemberId;


SELECT
    b.BookName,
    m.MemberName
FROM tbl_Books b
CROSS JOIN tbl_Members m;


CREATE PROCEDURE usp_GetBooks
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        BookId,
        BookName,
        Price
    FROM tbl_Books;

END;


EXEC usp_GetBooks;


CREATE TYPE BookType AS TABLE
(
    BookName VARCHAR(100),
    CategoryId INT,
    AuthorId INT,
    Price DECIMAL(10,2),
    PublishedYear INT
);


CREATE PROCEDURE usp_InsertMultipleBooks
(
    @BookData BookType READONLY
)
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO tbl_Books
    (
        BookName,
        CategoryId,
        AuthorId,
        Price,
        PublishedYear
    )
    SELECT
        BookName,
        CategoryId,
        AuthorId,
        Price,
        PublishedYear
    FROM @BookData;

END;


DECLARE @Books BookType;

INSERT INTO @Books
VALUES
('C Programming',1,1,550,2024),
('Modern Science',2,2,750,2025);

EXEC usp_InsertMultipleBooks @Books;



CREATE PROCEDURE usp_TransactionExample
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        INSERT INTO mst_Category
        (
            CategoryName
        )
        VALUES
        ('Mathematics');

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        INSERT INTO tbl_ErrorLog
        (
            ErrorMessage,
            ErrorProcedure,
            ErrorDate
        )
        VALUES
        (
            ERROR_MESSAGE(),
            ERROR_PROCEDURE(),
            GETDATE()
        );

    END CATCH

END;



EXEC usp_TransactionExample;