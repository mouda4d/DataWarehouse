use testScripts;
Go
IF OBJECT_ID ( 'CreateRandomDataGeneratorForSource_p', 'P' ) IS NOT NULL
    DROP PROCEDURE CreateRandomDataGeneratorForSource_p;
GO

CREATE PROCEDURE CreateRandomDataGeneratorForSource_p
AS
BEGIN
-- Create random data generator for Employees
DECLARE @EmployeeID INT = 4;
DECLARE @Counter INT = 1;

WHILE @Counter <= 200
BEGIN
    INSERT INTO Source.Employees (EmployeeID, FirstName, LastName, DepartmentID, HireDate)
    VALUES (
        @EmployeeID,
        CHAR(65 + RAND(CHECKSUM(NEWID())) * 25) + CHAR(65 + RAND(CHECKSUM(NEWID())) * 25),
        CHAR(65 + RAND(CHECKSUM(NEWID())) * 25) + CHAR(65 + RAND(CHECKSUM(NEWID())) * 25),
        FLOOR(1 + RAND() * 3), -- Random DepartmentID between 1 and 3
        DATEADD(DAY, -1 * FLOOR(RAND() * 3650), GETDATE()) -- Random HireDate within the last 10 years
    );

    SET @EmployeeID = @EmployeeID + 1;
    SET @Counter = @Counter + 1;
END

-- Create random data generator for Projects
DECLARE @ProjectID INT = 4;
SET @Counter = 1;

WHILE @Counter <= 80
BEGIN
    INSERT INTO Source.Projects (ProjectID, ProjectName, StartDate, EndDate)
    VALUES (
        @ProjectID,
        'Project ' + CHAR(65 + RAND(CHECKSUM(NEWID())) * 25) + CHAR(65 + RAND(CHECKSUM(NEWID())) * 25),
        DATEADD(DAY, -1 * FLOOR(RAND() * 3650), GETDATE()), -- Random StartDate within the last 10 years
        CASE
            WHEN RAND() > 0.5 THEN DATEADD(DAY, FLOOR(RAND() * 180), GETDATE()) -- Random EndDate within the next 6 months
            ELSE NULL
        END
    );

    SET @ProjectID = @ProjectID + 1;
    SET @Counter = @Counter + 1;
END

-- Create random data generator for Assignments
DECLARE @AssignmentID INT = 4;
SET @Counter = 1;

WHILE @Counter <= 300
BEGIN
    INSERT INTO Source.Assignments (AssignmentID, EmployeeID, ProjectID, Role, StartDate, EndDate)
    VALUES (
        @AssignmentID,
        FLOOR(1 + RAND() * 200), -- Random EmployeeID between 1 and 200
        FLOOR(1 + RAND() * 80),  -- Random ProjectID between 1 and 80
        CASE 
            WHEN RAND() > 0.5 THEN 'Developer'
            ELSE 'Analyst'
        END,
        DATEADD(DAY, -1 * FLOOR(RAND() * 3650), GETDATE()), -- Random StartDate within the last 10 years
        CASE
            WHEN RAND() > 0.5 THEN DATEADD(DAY, FLOOR(RAND() * 180), GETDATE()) -- Random EndDate within the next 6 months
            ELSE NULL
        END
    );

    SET @AssignmentID = @AssignmentID + 1;
    SET @Counter = @Counter + 1;
END
END
