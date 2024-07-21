
-- Check if the schema 'surrogation' exists, and create it if it doesn't
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'surrogation')
BEGIN
    EXEC('CREATE SCHEMA surrogation');
END
GO

-- Drop the stored procedure if it exists
IF OBJECT_ID('surrogate_table', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE surrogate_table;
END
GO

CREATE  PROCEDURE surrogate_table
    @mappingtable NVARCHAR(128),
    @surr_key NVARCHAR(128),
    @id NVARCHAR(128),
    @dataSource NVARCHAR(128),
    --@sourceSchema NVARCHAR(128),
    --@sourceDatabase NVARCHAR(128),
    @sourceTable NVARCHAR(128)
AS

BEGIN

    DECLARE @sql NVARCHAR(MAX);
    DECLARE @sql2 NVARCHAR(MAX);
    -- check in information schema if the table already exists
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @mappingtable AND TABLE_SCHEMA = 'surrogation')
    --if it doesnt exist create the table
    BEGIN
        -- Create the table in the surrogation schema
        SET @sql = 'CREATE TABLE surrogation.' + QUOTENAME(@mappingtable) + ' (' +
                QUOTENAME(@surr_key) + ' INT IDENTITY(1, 1) PRIMARY KEY, ' +
                QUOTENAME(@id) + ' INT, ' +
                'dataSource VARCHAR(20));'-- DEFAULT ''' + @dataSource + ''');';
    END;
    -- Insert data into the new table from the specified schema and database
    SET @sql2 = 'INSERT INTO surrogation.' + QUOTENAME(@mappingtable) + '(' + 
                QUOTENAME(@id) + ',' +  'dataSource'  + ') ' +
                'SELECT ' + QUOTENAME(@id) +  ', ''' + @dataSource + ''' '  + ' ' +-- ' ''' + @dataSource + ''' ' +
                'FROM '  + 'loading_sources' + '.' + QUOTENAME(@sourceTable) + ' WHERE NOT EXISTS (SELECT 1 
                                                                                 FROM ' + 'surrogation.' + @mappingtable +  
                                                                                 ' WHERE ' + @mappingtable + '.' + @id +
                                                                                 ' = ' + @sourcetable + '.' + @id +
                                                                                 ' AND ' + @mappingtable + '.' + 'dataSource' +
                                                                                 ' = ''' + @dataSource + ''')'

    -- Execute the SQL commands
    EXEC sp_executesql @sql;
    EXEC sp_executesql @sql2;
END;
GO
---------------------------------------------------------------------------------------------------------------------------
-- Execute the stored procedure
EXEC dbo.surrogate_table
    @mappingtable = 'employeeSurrogation',
    @surr_key = 's_emp',
    @id = 'EmployeeID',
    @dataSource = 'CompanyDB',
    --@sourceSchema = 'loading_sources',
    --@sourceDatabase = 'DataWarehouse2',
    @sourceTable = 'Employees_temp_company';

EXEC dbo.surrogate_table
    @mappingtable = 'employeeSurrogation',
    @surr_key = 's_emp',
    @id = 'EmployeeID',
    @dataSource = 'SourceDB',
    --@sourceSchema = 'loading_source',
    --@sourceDatabase = 'SourceDB',
    @sourceTable = 'Employees_temp_source';
----------------------------------------------------------------------------------------------------------------------------
 EXEC dbo.surrogate_table
    @mappingtable = 'DepartmentSurrogation',
    @surr_key = 's_dep',
    @id = 'DepartmentID',
    @dataSource = 'CompanyDB',
    --@sourceSchema = 'loading_source',
    --@sourceDatabase = 'SourceDB',
    @sourceTable = 'Departments_temp_Company';

EXEC dbo.surrogate_table
    @mappingtable = 'DepartmentSurrogation',
    @surr_key = 's_dep',
    @id = 'DepartmentID',
    @dataSource = 'SourceDB',
    --@sourceSchema = 'loading_source',
    --@sourceDatabase = 'SourceDB',
    @sourceTable = 'Departments_temp_source';
----------------------------------------------------------------------------------------------------------------------------
EXEC dbo.surrogate_table
    @mappingtable = 'ProjectSurrogation',
    @surr_key = 's_proj',
    @id = 'ProjectID',
    @dataSource = 'CompanyDB',
    --@sourceSchema = 'loading_source',
    --@sourceDatabase = 'SourceDB',
    @sourceTable = 'Projects_temp_Company';

EXEC dbo.surrogate_table
    @mappingtable = 'ProjectSurrogation',
    @surr_key = 's_proj',
    @id = 'ProjectID',
    @dataSource = 'SourceDB',
    --@sourceSchema = 'loading_source',
    --@sourceDatabase = 'SourceDB',
    @sourceTable = 'Projects_temp_source';

----------------------------------------------------------------------------------------------------------------------------
EXEC dbo.surrogate_table
    @mappingtable = 'AssignmentSurrogation',
    @surr_key = 's_assign',
    @id = 'AssignmentID',
    @dataSource = 'CompanyDB',
    --@sourceSchema = 'loading_source',
    --@sourceDatabase = 'SourceDB',
    @sourceTable = 'Assignments_temp_Company';

EXEC dbo.surrogate_table
    @mappingtable = 'AssignmentSurrogation',
    @surr_key = 's_assign',
    @id = 'AssignmentID',
    @dataSource = 'SourceDB',
    --@sourceSchema = 'loading_source',
    --@sourceDatabase = 'SourceDB',
    @sourceTable = 'Assignments_temp_source';

