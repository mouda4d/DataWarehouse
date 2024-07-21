use testScripts;
Go
IF OBJECT_ID ( 'MergingSources_p', 'P' ) IS NOT NULL
    DROP PROCEDURE MergingSources_p;
GO

CREATE PROCEDURE MergingSources_p
AS
BEGIN
EXEC('
-- Drop views if they exist
IF OBJECT_ID(''merged_Assignments'', ''V'') IS NOT NULL
    DROP VIEW merged_Assignments;
IF OBJECT_ID(''merged_Departments'', ''V'') IS NOT NULL
    DROP VIEW merged_Departments;
IF OBJECT_ID(''merged_Employees'', ''V'') IS NOT NULL
    DROP VIEW merged_Employees;
IF OBJECT_ID(''merged_Projects'', ''V'') IS NOT NULL
    DROP VIEW merged_Projects;
')

EXEC
('CREATE VIEW merged_Assignments AS
SELECT 
    t1.s_assign , t1.s_proj , t1.s_emp , t1.AssignmentID , 
    t1.EmployeeID , t1.ProjectID  , t1.Role ,
     t1.AssignmentDate AS StartDate, NULL AS EndDate, dataSource
FROM 
    transformed_CompanyDB_Assignment t1

UNION ALL

SELECT 
    t2.s_assign , t2.s_proj , t2.s_emp , t2.AssignmentID , 
    t2.EmployeeID , t2.ProjectID , t2.Role , t2.StartDate, t2.EndDate, datasource
FROM 
    transformed_SourceDB_Assignment t2;
');

EXEC
('CREATE VIEW merged_Departments AS
SELECT 
    s_dep, 
    DepartmentID, 
    DepartmentName, 
    Location, datasource
FROM 
    transformed_CompanyDB_Department

UNION ALL

SELECT 
    s_dep, 
    DepartmentID, 
    DepartmentName, 
    Location, datasource
FROM 
    transformed_SourceDB_Department;
');

EXEC('
CREATE VIEW merged_Employees AS
SELECT 
    s_emp,
    s_dep,
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    HireDate,
    Position,
    Salary,  datasource
FROM 
    transformed_CompanyDB_Employee

UNION ALL

SELECT 
    s_emp,
    s_dep,
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    HireDate,
    NULL AS Position,
    NULL AS Salary, datasource
FROM 
    transformed_SourceDB_Employee;
');

EXEC
('CREATE VIEW merged_Projects AS
SELECT 
    s_proj,
    ProjectID,
    ProjectName,
    StartDate,
    EndDate,
    NULL AS Budget, datasource
FROM 
    transformed_SourceDB_Project

UNION ALL

SELECT 
    s_proj,
    ProjectID,
    ProjectName,
    StartDate,
    EndDate,
    Budget,
    dataSource
FROM 
    transformed_CompanyDB_Project
');
END;