USE DataWarehouse

GO

CREATE VIEW merged_Assignments AS
SELECT 
    t1.s_assign AS s_assign1, t1.s_proj AS s_proj1, t1.s_emp AS s_emp1, t1.AssignmentID AS AssignmentID1, 
    t1.EmployeeID AS EmployeeID1, t1.ProjectID AS ProjectID1, t1.Role AS Role1,
     t1.AssignmentDate AS StartDate, NULL AS EndDate
FROM 
    transformed_CompanyDB_Assignment t1

UNION ALL

SELECT 
    t2.s_assign AS s_assign2, t2.s_proj AS s_proj2, t2.s_emp AS s_emp2, t2.AssignmentID AS AssignmentID2, 
    t2.EmployeeID AS EmployeeID2, t2.ProjectID AS ProjectID2, t2.Role AS Role2, t2.StartDate, t2.EndDate
FROM 
    transformed_SourceDB_Assignment t2;

GO

CREATE VIEW merged_Departments AS
SELECT 
    s_dep, 
    DepartmentID, 
    DepartmentName, 
    Location
FROM 
    transformed_CompanyDB_Department

UNION ALL

SELECT 
    s_dep, 
    DepartmentID, 
    DepartmentName, 
    Location
FROM 
    transformed_SourceDB_Department;
GO

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
    Salary
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
    NULL AS Salary
FROM 
    transformed_SourceDB_Employee;

GO

CREATE VIEW merged_Projects AS
SELECT 
    s_proj,
    ProjectID,
    ProjectName,
    StartDate,
    EndDate,
    NULL AS Budget
FROM 
    transformed_SourceDB_Project

UNION ALL

SELECT 
    s_proj,
    ProjectID,
    ProjectName,
    StartDate,
    EndDate,
    Budget
FROM 
    transformed_CompanyDB_Project

GO