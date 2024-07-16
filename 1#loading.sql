
CREATE DATABASE DataWarehouse;
GO
/*
select 'DROP TABLE ' + TABLE_SCHEMA + '.' + TABLE_NAME FROM INFORMATION_SCHEMA.TABLEs;
DROP TABLE surrogation.employeeSurrogation
DROP TABLE loading_sources.Departments_temp_source
DROP TABLE loading_sources.Employees_temp_source
DROP TABLE loading_sources.Projects_temp_source
DROP TABLE loading_sources.Assignments_temp_source
DROP TABLE loading_sources.Customers_temp_source
DROP TABLE loading_sources.Orders_temp_source
DROP TABLE loading_sources.Products_temp_source
DROP TABLE loading_sources.OrderDetails_temp_source
DROP TABLE loading_sources.Departments_temp_company
DROP TABLE loading_sources.Employees_temp_company
DROP TABLE loading_sources.Projects_temp_company
DROP TABLE loading_sources.Assignments_temp_company
DROP procedure loading_temp_tables; 
*/
USE DataWarehouse;
GO

CREATE SCHEMA loading_sources;



GO
--drop PROCEDURE loading_temp_tables;
CREATE PROCEDURE loading_temp_tables
    @tempTableName VARCHAR(128),
    @sourcetable VARCHAR(128),
    @databaseName VARCHAR(128),
    @schemaName VARCHAR(128)
AS
BEGIN
    DECLARE @sql2 NVARCHAR(MAX);

    -- Check if the table already exists
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @tempTableName AND TABLE_SCHEMA = 'loading_sources')
    BEGIN
        -- Construct the SQL statement for creating the temporary table
        SET @sql2 = 
        CONCAT('SELECT * INTO ', 
               'loading_sources.', QUOTENAME(@tempTableName), ' ' ,
               'FROM ', QUOTENAME(@databaseName), '.', QUOTENAME(@schemaName), '.', QUOTENAME(@sourcetable), ';');

        -- Execute the dynamic SQL
        EXEC sp_executesql @sql2;
    END;
END;
GO
--SELECT * FROM CompanyDB.Staff.Departments;
--drop table loading_sources.Departments_temp_source
--drop table loading_sources.Employees_temp_source
--drop table loading_sources.Projects_temp_source
--drop table loading_sources.Assignments_temp_source

--CompanyDB, Staff Schema
EXEC loading_temp_tables
    @tempTableName = 'Departments_temp_company',
    @sourcetable = 'Departments',
    @databaseName = 'CompanyDB',
    @schemaName = 'Staff';

EXEC loading_temp_tables
    @tempTableName = 'Employees_temp_company',
    @sourcetable = 'Employees',
    @databaseName = 'CompanyDB',
    @schemaName = 'Staff';

EXEC loading_temp_tables
    @tempTableName = 'Projects_temp_company',
    @sourcetable = 'Projects',
    @databaseName = 'CompanyDB',
    @schemaName = 'Staff';

EXEC loading_temp_tables
    @tempTableName = 'Assignments_temp_company',
    @sourcetable = 'Assignments',
    @databaseName = 'CompanyDB',
    @schemaName = 'Staff';
----------------------------------------------------------------------------------------------------------------------------
--CompanyDB, Sales Schema
EXEC loading_temp_tables
    @tempTableName = 'Customers_temp_company',
    @sourcetable = 'Customers',
    @databaseName = 'CompanyDB',
    @schemaName = 'Sales';

EXEC loading_temp_tables
    @tempTableName = 'Orders_temp_company',
    @sourcetable = 'Orders',
    @databaseName = 'CompanyDB',
    @schemaName = 'Sales';

EXEC loading_temp_tables
    @tempTableName = 'Products_temp_company',
    @sourcetable = 'Products',
    @databaseName = 'CompanyDB',
    @schemaName = 'Sales';

EXEC loading_temp_tables
    @tempTableName = 'OrderDetails_temp_company',
    @sourcetable = 'OrderDetails',
    @databaseName = 'CompanyDB',
    @schemaName = 'Sales';
------------------------------------------------------------------------------------------------------------------------------
--SourceDB, dbo Schema
EXEC loading_temp_tables
    @tempTableName = 'Departments_temp_source',
    @sourcetable = 'Departments',
    @databaseName = 'SourceDB',
    @schemaName = 'dbo';

EXEC loading_temp_tables
    @tempTableName = 'Employees_temp_source',
    @sourcetable = 'Employees',
    @databaseName = 'SourceDB',
    @schemaName = 'dbo';

EXEC loading_temp_tables
    @tempTableName = 'Projects_temp_source',
    @sourcetable = 'Projects',
    @databaseName = 'SourceDB',
    @schemaName = 'dbo';

EXEC loading_temp_tables
    @tempTableName = 'Assignments_temp_source',
    @sourcetable = 'Assignments',
    @databaseName = 'SourceDB',
    @schemaName = 'dbo';
