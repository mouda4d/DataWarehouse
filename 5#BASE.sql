USE datawarehouse

CREATE TABLE base_departments (
    s_dep INT PRIMARY KEY,
    DepartmentID INT,
    DepartmentName NVARCHAR(128),
    Location NVARCHAR(128),
    insertion_timestamp DATETIME DEFAULT SYSUTCDATETIME() 
);


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

);


CREATE TABLE base_projects (
    s_proj INT PRIMARY KEY,
    ProjectID INT,
    ProjectName NVARCHAR(128),
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(15, 2),
    insertion_timestamp DATETIME DEFAULT SYSUTCDATETIME()

);

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

);
INSERT INTO base_departments(s_dep, DepartmentID, DepartmentName, Location)
SELECT s_dep, DepartmentID, DepartmentName, Location FROM merged_Departments;


INSERT INTO base_Employees(s_emp, s_dep, EmployeeID, FirstName, LastName, DepartmentID, HireDate, Position, Salary)
SELECT s_emp, s_dep, EmployeeID, FirstName, LastName, DepartmentID, HireDate, Position, Salary FROM merged_Employees;

INSERT INTO base_projects(s_proj, ProjectID, ProjectName, StartDate, EndDate, Budget)
SELECT s_proj, ProjectID, ProjectName, StartDate, EndDate, Budget FROM merged_Projects;


INSERT INTO base_assignments(s_assign, s_proj, s_emp, AssignmentID, EmployeeID, ProjectID, Role, StartDate, EndDate)
SELECT s_assign, s_proj, s_emp, AssignmentID, EmployeeID, ProjectID, Role, StartDate, EndDate FROM merged_Assignments;

