USE DataWarehouse;
GO
CREATE VIEW EmployeeProjectAssignments AS (
    SELECT 
        s_assign,
        CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
        d.DepartmentName,
        p.ProjectName,
        a.Role,
        DATEDIFF(day, a.StartDate, a.EndDate) AS AssignmentDuration
    FROM 
        base_employees e
    JOIN 
        base_departments d ON e.s_dep = d.s_dep
    JOIN 
        base_assignments a ON e.s_emp = a.s_emp
    JOIN 
        base_projects p ON a.s_proj = p.s_proj
)
GO
select * FROM EmployeeProjectAssignments;