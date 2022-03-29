
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Office;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Building;

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
)
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

    
)
INSERT INTO Building
(BuildingCode, Description)
Values (N'DGGP', N'Dod & Gy Google Plex')
GO