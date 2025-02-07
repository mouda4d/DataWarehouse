use testScripts;
Go
IF OBJECT_ID ( 'Merging_p', 'P' ) IS NOT NULL
    DROP PROCEDURE Merging_p;
GO

CREATE PROCEDURE Merging_p
AS
BEGIN
EXEC('
-- Drop views if they exist
IF OBJECT_ID(''transformed_CompanyDB_Employee'', ''V'') IS NOT NULL
    DROP VIEW transformed_CompanyDB_Employee;
IF OBJECT_ID(''transformed_CompanyDB_Department'', ''V'') IS NOT NULL
    DROP VIEW transformed_CompanyDB_Department;
IF OBJECT_ID(''transformed_CompanyDB_Assignment'', ''V'') IS NOT NULL
    DROP VIEW transformed_CompanyDB_Assignment;
IF OBJECT_ID(''transformed_CompanyDB_Project'', ''V'') IS NOT NULL
    DROP VIEW transformed_CompanyDB_Project;

IF OBJECT_ID(''transformed_SourceDB_Employee'', ''V'') IS NOT NULL
    DROP VIEW transformed_SourceDB_Employee;
IF OBJECT_ID(''transformed_SourceDB_Department'', ''V'') IS NOT NULL
    DROP VIEW transformed_SourceDB_Department;
IF OBJECT_ID(''transformed_SourceDB_Assignment'', ''V'') IS NOT NULL
    DROP VIEW transformed_SourceDB_Assignment;
IF OBJECT_ID(''transformed_SourceDB_Project'', ''V'') IS NOT NULL
    DROP VIEW transformed_SourceDB_Project;
');

---------------------------------------------------------------------------------------------------------------------
EXEC('
CREATE VIEW transformed_CompanyDB_Employee AS (
SELECT 
    emp_surr.s_emp, dep_surr.s_dep, emp.*, emp_surr.dataSource
FROM
    loading_sources.Employees_temp_company emp
LEFT JOIN 
    surrogation.employeeSurrogation emp_surr
ON
    emp.employeeID = emp_surr.employeeID AND emp_surr.dataSource = ''CompanyDB''
LEFT JOIN 
    surrogation.DepartmentSurrogation dep_surr
ON
    emp.DepartmentID = dep_surr.DepartmentID AND dep_surr.dataSource = ''CompanyDB''
);
');

EXEC
('CREATE VIEW transformed_CompanyDB_Department AS (
SELECT 
    dep_surr.s_dep, dep.*, dep_surr.dataSource
FROM
    loading_sources.Departments_temp_company dep
LEFT JOIN
    surrogation.DepartmentSurrogation dep_surr
ON
    dep.DepartmentID = dep_surr.DepartmentID AND dep_surr.dataSource = ''CompanyDB''
);
');

EXEC
('CREATE VIEW transformed_CompanyDB_Assignment AS (
SELECT 
    assign_surr.s_assign, proj_surr.s_proj, emp_surr.s_emp, assign.*, assign_surr.dataSource
FROM
    loading_sources.Assignments_temp_company assign
LEFT JOIN
    surrogation.AssignmentSurrogation assign_surr
ON
    assign.AssignmentID = assign_surr.AssignmentID AND assign_surr.dataSource = ''CompanyDB''
LEFT JOIN
    surrogation.ProjectSurrogation proj_surr
ON 
    assign.ProjectID = proj_surr.ProjectID AND proj_surr.dataSource = ''CompanyDB''
LEFT JOIN
    surrogation.EmployeeSurrogation emp_surr
ON 
    assign.EmployeeID = emp_surr.EmployeeID AND emp_surr.dataSource = ''CompanyDB''
);
');

EXEC
('CREATE VIEW transformed_CompanyDB_Project AS (
SELECT 
    proj_surr.s_proj, proj.*, proj_surr.dataSource
FROM
    loading_sources.Projects_temp_company proj
LEFT JOIN
    surrogation.ProjectSurrogation proj_surr
ON
    proj.ProjectID = proj_surr.ProjectID AND proj_surr.dataSource = ''CompanyDB''
);
');

---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
EXEC('
CREATE VIEW transformed_SourceDB_Employee AS (
SELECT 
    emp_surr.s_emp, dep_surr.s_dep, emp.*, emp_surr.dataSource
FROM
    loading_sources.Employees_temp_Source emp
LEFT JOIN 
    surrogation.employeeSurrogation emp_surr
ON
    emp.employeeID = emp_surr.employeeID AND emp_surr.dataSource = ''SourceDB''
LEFT JOIN 
    surrogation.DepartmentSurrogation dep_surr
ON
    emp.DepartmentID = dep_surr.DepartmentID AND dep_surr.dataSource = ''SourceDB''
);
');

EXEC
('CREATE VIEW transformed_SourceDB_Department AS (
SELECT 
    dep_surr.s_dep, dep.*, dep_surr.dataSource
FROM
    loading_sources.Departments_temp_Source dep
LEFT JOIN
    surrogation.DepartmentSurrogation dep_surr
ON
    dep.DepartmentID = dep_surr.DepartmentID AND dep_surr.dataSource = ''SourceDB''
);
');

EXEC
('CREATE VIEW transformed_SourceDB_Assignment AS (
SELECT 
    assign_surr.s_assign, proj_surr.s_proj, emp_surr.s_emp, assign.*, assign_surr.dataSource
FROM
    loading_sources.Assignments_temp_Source assign
LEFT JOIN
    surrogation.AssignmentSurrogation assign_surr
ON
    assign.AssignmentID = assign_surr.AssignmentID AND assign_surr.dataSource = ''SourceDB''
LEFT JOIN
    surrogation.ProjectSurrogation proj_surr
ON 
    assign.ProjectID = proj_surr.ProjectID AND proj_surr.dataSource = ''SourceDB''
LEFT JOIN
    surrogation.EmployeeSurrogation emp_surr
ON 
    assign.EmployeeID = emp_surr.EmployeeID AND emp_surr.dataSource = ''SourceDB''
);
');

EXEC
('CREATE VIEW transformed_SourceDB_Project AS (
SELECT 
    proj_surr.s_proj, proj.*, proj_surr.dataSource
FROM
    loading_sources.Projects_temp_Source proj
LEFT JOIN
    surrogation.ProjectSurrogation proj_surr
ON
    proj.ProjectID = proj_surr.ProjectID AND proj_surr.dataSource = ''SourceDB''
);
');
END