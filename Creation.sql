use testScripts;
Go
IF OBJECT_ID ( 'CreateTables', 'P' ) IS NOT NULL
    DROP PROCEDURE CreateTables;
GO   
CREATE PROCEDURE CreateTables
AS
BEGIN
  EXEC
  ('IF NOT EXISTS(SELECT * FROM sys.schemas WHERE name = ''Company'')
    BEGIN
      EXEC(''CREATE SCHEMA [Company]'');
    END
  ');

  IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Departments' and xtype='U')
  BEGIN
      CREATE TABLE Company.Departments (
        DepartmentID INT PRIMARY KEY,
        DepartmentName VARCHAR(100) NOT NULL,
        Location VARCHAR(100) NOT NULL
      )
  END

  IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Employees' and xtype='U')
  BEGIN
    CREATE TABLE Company.Employees (
      EmployeeID INT PRIMARY KEY,
      FirstName VARCHAR(50) NOT NULL,
      LastName VARCHAR(50) NOT NULL,
      DepartmentID INT,
      HireDate DATE NOT NULL,
      Position VARCHAR(50),
      Salary DECIMAL(10, 2) NOT NULL
    )
    END

    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Projects' and xtype='U')
    BEGIN
      CREATE TABLE Company.Projects (
        ProjectID INT PRIMARY KEY,
        ProjectName VARCHAR(100) NOT NULL,
        StartDate DATE NOT NULL,
        EndDate DATE NOT NULL,
        Budget DECIMAL(15, 2) NOT NULL
    )
    END

    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Assignments' and xtype='U')
    BEGIN
      CREATE TABLE Company.Assignments (
        AssignmentID INT PRIMARY KEY,
        EmployeeID INT NOT NULL,
        ProjectID INT NOT NULL,
        Role VARCHAR(50) NOT NULL,
        AssignmentDate DATE NOT NULL
    )
    END

    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Customers' and xtype='U')
    BEGIN
      CREATE TABLE Company.Customers (
        CustomerID INT PRIMARY KEY,
        CustomerName VARCHAR(100) NOT NULL,
        ContactNumber VARCHAR(15) NOT NULL,
        Email VARCHAR(100) NOT NULL,
        Address VARCHAR(255) NOT NULL
    )
    END

    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Orders' and xtype='U')
    BEGIN
      CREATE TABLE Company.Orders (
        OrderID INT PRIMARY KEY,
        CustomerID INT NOT NULL,
        OrderDate DATE NOT NULL,
        TotalAmount DECIMAL(10, 2) NOT NULL
    )
    END

    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Products' and xtype='U')
    BEGIN
      CREATE TABLE Company.Products (
        ProductID INT PRIMARY KEY,
        ProductName VARCHAR(100) NOT NULL,
        Category VARCHAR(50) NOT NULL,
        Price DECIMAL(10, 2) NOT NULL,
        StockQuantity INT NOT NULL
    )
    END

    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='OrderDetails' and xtype='U')
    BEGIN
      CREATE TABLE Company.OrderDetails (
        OrderDetailID INT PRIMARY KEY,
        OrderID INT,
        ProductID INT,
        Quantity INT NOT NULL,
        UnitPrice DECIMAL(10, 2) NOT NULL
    )
    END
    
--Inserting into the database as two transactions 
--First, staff side
BEGIN TRANSACTION;

INSERT INTO Company.Departments (DepartmentID, DepartmentName, Location)
VALUES 
    (1, 'IT Department', 'Headquarters'),
    (2, 'Sales Department', 'Branch Office'),
    (3, 'Marketing Department', 'Headquarters');

INSERT INTO Company.Employees (EmployeeID, FirstName, LastName, DepartmentID, HireDate, Position, Salary)
VALUES
    (1, 'John', 'Doe', 1, '2020-01-15', 'Software Engineer', 75000.00),
    (2, 'Jane', 'Smith', 1, '2019-05-20', 'Database Administrator', 80000.00),
    (3, 'Michael', 'Johnson', 2, '2021-03-10', 'Sales Manager', 90000.00),
    (4, 'Emily', 'Williams', 2, '2022-02-28', 'Sales Representative', 60000.00),
    (5, 'David', 'Brown', 3, '2020-11-15', 'Marketing Specialist', 70000.00);

INSERT INTO Company.Projects (ProjectID, ProjectName, StartDate, EndDate, Budget)
VALUES
    (1, 'Database Migration', '2023-01-01', '2023-06-30', 100000.00),
    (2, 'Sales Campaign 2024', '2024-03-01', '2024-06-30', 80000.00),
    (3, 'Website Redesign', '2023-07-01', '2023-12-31', 120000.00);

INSERT INTO Company.Assignments (AssignmentID, EmployeeID, ProjectID, Role, AssignmentDate)
VALUES
    (1, 1, 1, 'Lead Developer', '2023-01-01'),
    (2, 2, 1, 'Database Administrator', '2023-01-01'),
    (3, 3, 2, 'Project Manager', '2024-03-01'),
    (4, 4, 2, 'Sales Representative', '2024-03-01'),
    (5, 5, 3, 'Marketing Coordinator', '2023-07-01');

--Commit transaction
COMMIT;

BEGIN TRANSACTION;

INSERT INTO Company.Customers (CustomerID, CustomerName, ContactNumber, Email, Address)
VALUES
    (1, 'Tech Solutions Inc.', '123-456-7890', 'info@techsolutions.com', '123 Main St, Anytown, USA'),
    (2, 'Global Marketing Group', '555-123-4567', 'contact@globalmarketing.com', '456 Market Ave, Big City, USA'),
    (3, 'Super Retail Corp.', '789-321-6540', 'support@superretail.com', '789 Oak Blvd, Smalltown, USA');

INSERT INTO Company.Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (1, 1, '2023-02-15', 25000.00),
    (2, 1, '2023-05-20', 35000.00),
    (3, 2, '2024-04-01', 18000.00),
    (4, 3, '2023-08-10', 50000.00),
    (5, 3, '2024-01-05', 42000.00);

INSERT INTO Company.Products (ProductID, ProductName, Category, Price, StockQuantity)
VALUES
    (1, 'Laptop Computer', 'Electronics', 1200.00, 50),
    (2, 'Office Desk', 'Furniture', 400.00, 20),
    (3, 'Printer', 'Office Supplies', 300.00, 30),
    (4, 'Smartphone', 'Electronics', 800.00, 100),
    (5, 'Office Chair', 'Furniture', 150.00, 25);

INSERT INTO Company.OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1, 1, 3, 1200.00),
    (2, 1, 2, 2, 400.00),
    (3, 2, 4, 4, 800.00),
    (4, 3, 3, 1, 300.00),
    (5, 4, 5, 2, 150.00),
    (6, 5, 1, 2, 1200.00);

--Commit transaction
COMMIT;
END;
