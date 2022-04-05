USE master;
DROP DATABASE IF EXISTS AT1Prac;
CREATE DATABASE AT1Prac;
USE AT1Prac;

/* CREATE LOGIN adminXXXX WITH PASSWORD = 'password1'; 
CREATE USER adminXXXX FOR LOGIN adminXXXX; 
CREATE LOGIN apiXXXX WITH PASSWORD = 'password1'; 
CREATE USER apiXXXX FOR LOGIN apiXXXX;
GO
 
EXEC sp_addrolemember 'adminXXXX', 'db_owner'; 
EXEC sp_addrolemember 'apiXXXX', 'db_datareader'; 
EXEC sp_addrolemember 'apiXXXX', 'db_datawriter';
GO */

DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Office;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Building;
GO

CREATE TABLE Building (
    BuildingCode NVARCHAR(4),
    Description NVARCHAR(200) NOT NULL,
    PRIMARY KEY (BuildingCode)
);

CREATE TABLE Department (
    DeptCode NVARCHAR(5),
    DeptName NVARCHAR(500) NOT NULL,
    PRIMARY KEY (DeptCode)
);

CREATE TABLE Office (
    BuildingCode NVARCHAR(4),
    OfficeNo INT,
    NumDesks INT,
    Phone NVARCHAR(20),
    CONSTRAINT CHK_NumDesks CHECK(NumDesks < 5),
    PRIMARY KEY (BuildingCode, OfficeNo),
    FOREIGN KEY (BuildingCode) REFERENCES Building (BuildingCode)
);
CREATE TABLE Employee (
    EmpID INT,
    FirstName NVARCHAR(50) NOT NULL,
    SurName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100),
    DeptCode NVARCHAR(5),
    BuildingCode NVARCHAR(4),
    OfficeNo INT,
    PRIMARY KEY (EmpID),
    CONSTRAINT CHK_At CHECK(Email in ('@')),
    FOREIGN KEY (BuildingCode, OfficeNo) REFERENCES Office
);
GO

DROP VIEW IF EXISTS EmployeesByDept;
DROP VIEW IF EXISTS BuildingDeskNumbers;
GO
CREATE VIEW EmployeesByDept AS
SELECT E.Surname, E.FirstName, D.DeptName
FROM Employee E
INNER JOIN Department D
ON E.DeptCode = D.DeptCode
GO 
SELECT * FROM EmployeesByDept
ORDER BY Surname
GO

CREATE VIEW BuildingDeskNumbers AS
SELECT O.BuildingCode, Sum(O.NumDesks) AS Desks
FROM Office O
GROUP BY O.BuildingCode
GO
SELECT * FROM BuildingDeskNumbers
ORDER BY Desks ASC
GO

INSERT INTO Building
(BuildingCode, Description)
Values (N'DGGP', N'Dod & Gy Google Plex');
GO
