USE DataWarehouse;
GO
IF OBJECT_ID ( 'CreateViews', 'P' ) IS NOT NULL
    DROP PROCEDURE CreateViews;
GO

create procedure CreateViews 
as
begin
IF NOT EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE Name = 'EmployeeProjectAssignments'
)
BEGIN
    EXEC('CREATE VIEW EmployeeProjectAssignments AS SELECT 1 as Val')
END
exec ('
Alter VIEW EmployeeProjectAssignments
AS
SELECT CONCAT(FirstName,LastName) EmployeeName,
DepartmentName,ProjectName,Role,DATEDIFF(day, a.StartDate, a.EndDate) AS AssignmentDuration 
FROM base_employees e JOIN base_departments d
on e.s_dep = d.s_dep JOIN base_assignments a
on a.s_emp = e.s_emp JOIN base_projects p
on p.s_proj = a.s_proj
')
SELECT * from EmployeeProjectAssignments;
end
