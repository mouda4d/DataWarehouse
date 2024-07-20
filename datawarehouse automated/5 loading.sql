
-- Create the DataWarehouse database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    EXEC('CREATE SCHEMA DataWarehouse');
END
GO

-- Check if the schema 'loading_sources' exists, and create it if it doesn't
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'loading_sources')
BEGIN
    EXEC('CREATE SCHEMA loading_sources');
END
GO

-- Drop the stored procedure if it exists
IF OBJECT_ID('loading_temp_tables', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE loading_temp_tables;
END
GO

--drop PROCEDURE loading_temp_tables;
CREATE PROCEDURE loading_temp_tables
    @tempTableName VARCHAR(128),
    @sourcetable VARCHAR(128),
    --@databaseName VARCHAR(128),
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
               'FROM ', QUOTENAME(@schemaName), '.', QUOTENAME(@sourcetable), ';');

        -- Execute the dynamic SQL
        EXEC sp_executesql @sql2;
    END;
END;
GO

--CompanyDB, Staff Schema
EXEC loading_temp_tables
    @tempTableName = 'Departments_temp_company',
    @sourcetable = 'Departments',
    --@databaseName = 'CompanyDB',
    @schemaName = 'Company';

EXEC loading_temp_tables
    @tempTableName = 'Employees_temp_company',
    @sourcetable = 'Employees',
    --@databaseName = 'CompanyDB',
    @schemaName = 'Company';

EXEC loading_temp_tables
    @tempTableName = 'Projects_temp_company',
    @sourcetable = 'Projects',
    --@databaseName = 'CompanyDB',
    @schemaName = 'Company';

EXEC loading_temp_tables
    @tempTableName = 'Assignments_temp_company',
    @sourcetable = 'Assignments',
    --@databaseName = 'CompanyDB',
    @schemaName = 'Company';
----------------------------------------------------------------------------------------------------------------------------
--CompanyDB, Sales Schema
EXEC loading_temp_tables
    @tempTableName = 'Customers_temp_company',
    @sourcetable = 'Customers',
    --@databaseName = 'CompanyDB',
    @schemaName = 'Company';

EXEC loading_temp_tables
    @tempTableName = 'Orders_temp_company',
    @sourcetable = 'Orders',
   -- @databaseName = 'CompanyDB',
    @schemaName = 'Company';

EXEC loading_temp_tables
    @tempTableName = 'Products_temp_company',
    @sourcetable = 'Products',
   -- @databaseName = 'CompanyDB',
    @schemaName = 'Company';

EXEC loading_temp_tables
    @tempTableName = 'OrderDetails_temp_company',
    @sourcetable = 'OrderDetails',
   -- @databaseName = 'CompanyDB',
    @schemaName = 'Company';
------------------------------------------------------------------------------------------------------------------------------
--SourceDB, dbo Schema
EXEC loading_temp_tables
    @tempTableName = 'Departments_temp_source',
    @sourcetable = 'Departments',
   -- @databaseName = 'SourceDB',
    @schemaName = 'Source';

EXEC loading_temp_tables
    @tempTableName = 'Employees_temp_source',
    @sourcetable = 'Employees',
  --  @databaseName = 'SourceDB',
    @schemaName = 'Source';

EXEC loading_temp_tables
    @tempTableName = 'Projects_temp_source',
    @sourcetable = 'Projects',
  --  @databaseName = 'SourceDB',
    @schemaName = 'Source';

EXEC loading_temp_tables
    @tempTableName = 'Assignments_temp_source',
    @sourcetable = 'Assignments',
  --  @databaseName = 'SourceDB',
    @schemaName = 'Source';
