IF OBJECT_ID ( 'Queries_p', 'P' ) IS NOT NULL
    DROP PROCEDURE Queries_p;
GO   
CREATE PROCEDURE Queries_p
AS
BEGIN
--QUESTIONS

-- Question 1: Employee Details with Function Manipulation 1

SELECT 
    UPPER(FirstName) AS first_name, 
    LOWER(LastName) AS last_name, 
    LEN(position) AS position_length,
    DepartmentName
FROM
    BASE.base_employees emp
LEFT JOIN
    BASE.base_Departments dep
ON
    emp.s_dep = dep.s_dep;
-------------------------------------------------------------------------------------------------------------------------
-- Question 2: Department Budget Summary
SELECT
    dep.s_dep,
    dep.DepartmentID,
    DepartmentName, 
    ROUND(SUM(Salary), 3) AS total_salary_expenditure, 
    COUNT(1) AS count_employees
FROM
    BASE.base_Departments dep
LEFT JOIN
    BASE.base_employees emp
ON 
    dep.s_dep = emp.s_dep
GROUP BY 
    dep.s_dep, DepartmentName, dep.DepartmentID
ORDER BY 
    3 DESC;
-------------------------------------------------------------------------------------------------------------------------
-- Question 3: Project Assignments
SELECT 
    proj.ProjectID,
    UPPER(ProjectName) AS ProjectName,
    FirstName + ' ' + LastName AS EmployeeName,
    [Role]
FROM
    BASE.base_projects proj
LEFT JOIN
    BASE.base_assignments assign
ON
    proj.s_proj = assign.s_proj
LEFT JOIN
    BASE.base_employees emp
ON
    assign.s_emp = emp.s_emp;
-------------------------------------------------------------------------------------------------------------------------
-- Question 4: Customer Order Analysis
SELECT
    cust.CustomerID,
    LOWER(cust.CustomerName) AS customerName,
    COUNT(1) AS count_orders,
    SUM(TotalAmount) AS total_amount_spent
FROM
    BASE.base_customers cust
INNER JOIN
    BASE.base_orders orders
ON
    cust.CustomerID = orders.CustomerID
GROUP BY 
    cust.CustomerID, CustomerName;
-------------------------------------------------------------------------------------------------------------------------
-- Question 5: Product Details Extraction
SELECT 
    LEFT(ProductName, 10) AS prod_name,
    LEFT(ProductName, 2) AS productCategory,
    SUM(Quantity) AS totalQuantity
FROM
    BASE.base_products prod 
LEFT JOIN
    BASE.base_orderDetails od
ON
    prod.ProductID = od.ProductID
GROUP BY LEFT(ProductName, 10), LEFT(ProductName, 2);
-------------------------------------------------------------------------------------------------------------------------
-- Question 6: High Salary Employees in Specific Departments
WITH AVG_SALARY AS (
    SELECT 
        emp.s_emp,
        emp.EmployeeID,
        emp.FirstName,
        emp.LastName,
        emp.Salary,
        AVG(Salary) OVER(PARTITION BY dep. DepartmentID) AS avg_salary_department,
        dep.s_dep,
        dep.DepartmentID,
        dep.DepartmentName
    FROM
        BASE.base_employees emp
    JOIN
        BASE.base_departments dep 
    ON 
        emp.s_dep = dep.s_dep
)
SELECT
    s_emp,
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    DepartmentName
FROM 
    AVG_SALARY
WHERE Salary > avg_salary_department;
--QUALIFY emp.Salary > AVG(Salary) OVER(PARTITION BY dep. DepartmentID);
END;