USE CompanyDB;
GO
IF OBJECT_ID ( 'CreateConstraintsAndRelationships', 'P' ) IS NOT NULL
    DROP PROCEDURE CreateConstraintsAndRelationships;
GO

CREATE PROCEDURE CreateConstraintsAndRelationships
AS
BEGIN

ALTER TABLE Staff.Employees
ADD CONSTRAINT CHK_Salary CHECK (Salary > 0);

ALTER TABLE Staff.Employees
ADD CONSTRAINT FK_DepartmentID FOREIGN KEY (DepartmentID) REFERENCES Staff.Departments(DepartmentID);

ALTER TABLE Staff.Employees
ADD CONSTRAINT employees_chd CHECK (HireDate <= CAST(SYSDATETIME() AS DATE))

ALTER TABLE Staff.Projects
ADD CONSTRAINT CHK_Budget CHECK (Budget > 0);


ALTER TABLE Staff.Assignments
ADD CONSTRAINT FK_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Staff.Employees(EmployeeID);

ALTER TABLE Staff.Assignments
ADD CONSTRAINT FK_ProjectID FOREIGN KEY (ProjectID) REFERENCES Staff.Projects(ProjectID);

ALTER TABLE Sales.Orders
ADD CONSTRAINT CHK_TotalAmount CHECK (TotalAmount > 0);

ALTER TABLE Sales.Orders
ADD CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES Sales.Customers(CustomerID);

ALTER TABLE Sales.Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

ALTER TABLE Sales.Products
ADD CONSTRAINT CHK_StockQuantity CHECK (StockQuantity >= 0);


ALTER TABLE Sales.OrderDetails
ADD CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Sales.Orders(OrderID);

ALTER TABLE Sales.OrderDetails
ADD CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Sales.Products(ProductID);

ALTER TABLE Sales.OrderDetails
ADD CONSTRAINT CHK_Quantity CHECK (Quantity > 0);

ALTER TABLE Sales.OrderDetails
ADD CONSTRAINT CHK_UnitPrice CHECK (UnitPrice > 0);
END