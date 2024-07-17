IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'CompanyDB')
  BEGIN
    CREATE DATABASE [DataCompanyDBBase]


    END
GO
    USE [CompanyDB]
GO

IF OBJECT_ID ( 'CreateTables', 'P' ) IS NOT NULL
    DROP PROCEDURE CreateTables;
GO    
CREATE PROCEDURE CreateTables
AS
BEGIN

IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Sales')) 
BEGIN
    EXEC ('CREATE SCHEMA [Sales] AUTHORIZATION [CompanyDB]')
END

IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Staff')) 
BEGIN
    EXEC ('CREATE SCHEMA [Staff] AUTHORIZATION [CompanyDB]')
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Departments' and xtype='U')
BEGIN
    CREATE TABLE Staff.Departments (
      DepartmentID INT PRIMARY KEY,
      DepartmentName VARCHAR(100) NOT NULL,
      Location VARCHAR(100) NOT NULL
    )
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Employees' and xtype='U')
BEGIN
CREATE TABLE Staff.Employees (
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
CREATE TABLE Staff.Projects (
  ProjectID INT PRIMARY KEY,
  ProjectName VARCHAR(100) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  Budget DECIMAL(15, 2) NOT NULL
)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Assignments' and xtype='U')
BEGIN
CREATE TABLE Staff.Assignments (
  AssignmentID INT PRIMARY KEY,
  EmployeeID INT NOT NULL,
  ProjectID INT NOT NULL,
  Role VARCHAR(50) NOT NULL,
  AssignmentDate DATE NOT NULL
)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Customers' and xtype='U')
BEGIN
CREATE TABLE Sales.Customers (
  CustomerID INT PRIMARY KEY,
  CustomerName VARCHAR(100) NOT NULL,
  ContactNumber VARCHAR(15) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  Address VARCHAR(255) NOT NULL
)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Orders' and xtype='U')
BEGIN
CREATE TABLE Sales.Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT NOT NULL,
  OrderDate DATE NOT NULL,
  TotalAmount DECIMAL(10, 2) NOT NULL
)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Products' and xtype='U')
BEGIN
CREATE TABLE Sales.Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(100) NOT NULL,
  Category VARCHAR(50) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  StockQuantity INT NOT NULL
)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='OrderDetails' and xtype='U')
BEGIN
CREATE TABLE Sales.OrderDetails (
  OrderDetailID INT PRIMARY KEY,
  OrderID INT,
  ProductID INT,
  Quantity INT NOT NULL,
  UnitPrice DECIMAL(10, 2) NOT NULL
)
END
END