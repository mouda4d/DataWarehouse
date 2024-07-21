use testScripts;
Go
IF OBJECT_ID ( 'CreateConstraintsAndRelationships', 'P' ) IS NOT NULL
    DROP PROCEDURE CreateConstraintsAndRelationships;
GO

CREATE PROCEDURE CreateConstraintsAndRelationships
AS
BEGIN

ALTER TABLE Company.Employees
ADD CONSTRAINT CHK_Salary CHECK (Salary > 0);

ALTER TABLE Company.Employees
ADD CONSTRAINT FK_DepartmentID FOREIGN KEY (DepartmentID) REFERENCES Company.Departments(DepartmentID);

ALTER TABLE Company.Employees
ADD CONSTRAINT employees_chd CHECK (HireDate <= CAST(SYSDATETIME() AS DATE))

ALTER TABLE Company.Projects
ADD CONSTRAINT CHK_Budget CHECK (Budget > 0);


ALTER TABLE Company.Assignments
ADD CONSTRAINT FK_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Company.Employees(EmployeeID);

ALTER TABLE Company.Assignments
ADD CONSTRAINT FK_ProjectID FOREIGN KEY (ProjectID) REFERENCES Company.Projects(ProjectID);

ALTER TABLE Company.Orders
ADD CONSTRAINT CHK_TotalAmount CHECK (TotalAmount > 0);

ALTER TABLE Company.Orders
ADD CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES Company.Customers(CustomerID);

ALTER TABLE Company.Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

ALTER TABLE Company.Products
ADD CONSTRAINT CHK_StockQuantity CHECK (StockQuantity >= 0);


ALTER TABLE Company.OrderDetails
ADD CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Company.Orders(OrderID);

ALTER TABLE Company.OrderDetails
ADD CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Company.Products(ProductID);

ALTER TABLE Company.OrderDetails
ADD CONSTRAINT CHK_Quantity CHECK (Quantity > 0);

ALTER TABLE Company.OrderDetails
ADD CONSTRAINT CHK_UnitPrice CHECK (UnitPrice > 0);
END
