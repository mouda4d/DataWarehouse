
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
    FROM BASE.base_employees e JOIN BASE.base_departments d
    on e.s_dep = d.s_dep JOIN BASE.base_assignments a
    on a.s_emp = e.s_emp JOIN BASE.base_projects p
    on p.s_proj = a.s_proj
    ')
    end
GO
EXEC CreateViews 
SELECT * from EmployeeProjectAssignments;

