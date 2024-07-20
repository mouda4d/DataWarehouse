-- Create SourceDB
IF NOT EXISTS(SELECT * FROM sys.schemas WHERE name = 'Source')
  BEGIN
    EXEC('CREATE SCHEMA [Source]');
  END
GO
-- Create Departments table
CREATE TABLE Source.Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100),
    Location NVARCHAR(100)
);

-- Insert data into Departments
INSERT INTO Source.Departments (DepartmentID, DepartmentName, Location)
VALUES
(1, 'Human Resources', 'New York'),
(2, 'Engineering', 'San Francisco'),
(3, 'Marketing', 'Chicago');

-- Create Employees table
CREATE TABLE Source.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT,
    HireDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Source.Departments(DepartmentID)
);

-- Insert data into Employees
INSERT INTO Source.Employees (EmployeeID, FirstName, LastName, DepartmentID, HireDate)
VALUES
(1, 'John', 'Doe', 2, '2020-01-15'),
(2, 'Jane', 'Smith', 1, '2019-03-23'),
(3, 'Michael', 'Johnson', 3, '2021-07-30');

-- Create Projects table
CREATE TABLE Source.Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName NVARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

-- Insert data into Projects
INSERT INTO Source.Projects (ProjectID, ProjectName, StartDate, EndDate)
VALUES
(1, 'Project Alpha', '2021-01-01', '2021-06-30'),
(2, 'Project Beta', '2021-07-01', '2021-12-31'),
(3, 'Project Gamma', '2022-01-01', NULL);

-- Create Assignments table
CREATE TABLE Source.Assignments (
    AssignmentID INT PRIMARY KEY,
    EmployeeID INT,
    ProjectID INT,
    Role NVARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Source.Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Source.Projects(ProjectID)
);

-- Insert data into Assignments
INSERT INTO Source.Assignments (AssignmentID, EmployeeID, ProjectID, Role, StartDate, EndDate)
VALUES
(1, 1, 1, 'Developer', '2021-01-01', '2021-06-30'),
(2, 2, 2, 'Manager', '2021-07-01', '2021-12-31'),
(3, 3, 3, 'Analyst', '2022-01-01', NULL);
GO