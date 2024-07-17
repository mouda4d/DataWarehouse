USE DataWarehouse2

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='base_departments')
BEGIN
CREATE TABLE base_departments (
    s_dep INT PRIMARY KEY,
    DepartmentID INT,
    DepartmentName NVARCHAR(128),
    Location NVARCHAR(128),
    insertion_timestamp DATETIME DEFAULT SYSUTCDATETIME() 
)
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='base_employees')
BEGIN
CREATE TABLE base_employees (
    s_emp INT PRIMARY KEY,
    s_dep INT,
    EmployeeID INT,
    FirstName NVARCHAR(128),
    LastName NVARCHAR(128),
    DepartmentID INT,
    HireDate DATE,
    Position NVARCHAR(128),
    Salary DECIMAL(10, 2),
    FOREIGN KEY (s_dep) REFERENCES base_departments(s_dep), -- Foreign key to base_departments
    insertion_timestamp DATETIME DEFAULT SYSUTCDATETIME()

)
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='base_projects')
BEGIN
CREATE TABLE base_projects (
    s_proj INT PRIMARY KEY,
    ProjectID INT,
    ProjectName NVARCHAR(128),
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(15, 2),
    insertion_timestamp DATETIME DEFAULT SYSUTCDATETIME()
)
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='base_assignments')
BEGIN
CREATE TABLE base_assignments (
    s_assign INT PRIMARY KEY,
    s_proj INT,
    s_emp INT,
    AssignmentID INT,
    EmployeeID INT,
    ProjectID INT,
    Role NVARCHAR(128),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (s_proj) REFERENCES base_projects(s_proj), -- Foreign key to base_projects
    FOREIGN KEY (s_emp) REFERENCES base_employees(s_emp), -- Foreign key to base_employees
    insertion_timestamp DATETIME DEFAULT SYSUTCDATETIME() 
)
END

INSERT INTO base_departments(s_dep, DepartmentID, DepartmentName, Location)
SELECT s_dep, DepartmentID, DepartmentName, Location FROM merged_Departments;


INSERT INTO base_Employees(s_emp, s_dep, EmployeeID, FirstName, LastName, DepartmentID, HireDate, Position, Salary)
SELECT s_emp, s_dep, EmployeeID, FirstName, LastName, DepartmentID, HireDate, Position, Salary FROM merged_Employees;

INSERT INTO base_projects(s_proj, ProjectID, ProjectName, StartDate, EndDate, Budget)
SELECT s_proj, ProjectID, ProjectName, StartDate, EndDate, Budget FROM merged_Projects;


INSERT INTO base_assignments(s_assign, s_proj, s_emp, AssignmentID, EmployeeID, ProjectID, Role, StartDate, EndDate)
SELECT s_assign, s_proj, s_emp, AssignmentID, EmployeeID, ProjectID, Role, StartDate, EndDate FROM merged_Assignments;


SELECT 
    * 
INTO 
    base_customers
 FROM 
    loading_sources.Customers_temp_company;

SELECT 
    * 
INTO 
    base_orders
 FROM 
    loading_sources.orders_temp_company;

SELECT 
    * 
INTO 
    base_products
 FROM 
    loading_sources.products_temp_company;

SELECT 
    * 
INTO 
    base_orderDetails
 FROM 
    loading_sources.orderDetails_temp_company;

/*
SELECT 'DROP TABLE ' + TABLE_SCHEMA + '.' + TABLE_NAME
FROM INFORMATION_SCHEMA.TABLEs
WHERE TABLE_SCHEMA  = 'loading_sources'

IF EXISTS (SELECT * FROM sys.tables WHERE name='Departments_temp_company')
BEGIN
DROP TABLE loading_sources.Departments_temp_company
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Employees_temp_company')
BEGIN
DROP TABLE loading_sources.Employees_temp_company
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Projects_temp_company')
BEGIN
DROP TABLE loading_sources.Projects_temp_company
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Assignments_temp_company')
BEGIN
DROP TABLE loading_sources.Assignments_temp_company
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Customers_temp_company')
BEGIN
DROP TABLE loading_sources.Customers_temp_company
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Orders_temp_company')
BEGIN
DROP TABLE loading_sources.Orders_temp_company
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Products_temp_company')
BEGIN
DROP TABLE loading_sources.Products_temp_company
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='OrderDetails_temp_company')
BEGIN
DROP TABLE loading_sources.OrderDetails_temp_company
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Departments_temp_source')
BEGIN
DROP TABLE loading_sources.Departments_temp_source
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Employees_temp_source')
BEGIN
DROP TABLE loading_sources.Employees_temp_source
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Projects_temp_source')
BEGIN
DROP TABLE loading_sources.Projects_temp_source
END

IF EXISTS (SELECT * FROM sys.tables WHERE name='Assignments_temp_source')
BEGIN
DROP TABLE loading_sources.Assignments_temp_source
END
*/