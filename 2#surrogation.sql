USE DataWarehouse;

GO

CREATE SCHEMA surrogation;

GO
--drop procedure surrogate_table;
--drop table surrogation.employeesurrogation;
/*
CREATE TABLE surrogation.employeeSurrogation (
    s_emp INT IDENTITY(1, 1) PRIMARY KEY,
    EmployeeID INT,
    dataSource VARCHAR(50)
);
GO
*/
-- Create the stored procedure
--drop procedure surrogate_table
--drop table surrogation.employeeSurrogation
--drop table surrogation.AssignmentSurrogation
--drop table surrogation.DepartmentSurrogation
--drop table surrogation.ProjectSurrogation
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
    --@sourceDatabase = 'DataWarehouse',
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
/*
INSERT INTO 
    surrogation.employeeSurrogation(EmployeeID, dataSource)
SELECT 
    CompanyDB.Staff.Employees.EmployeeID, 'CompanyDB'
FROM
    CompanyDB.Staff.Employees;

INSERT INTO 
    surrogation.employeeSurrogation(EmployeeID, dataSource)
SELECT 
    Employees_temp.EmployeeID, 'SourceDB'
FROM
    loading_source.Employees_temp;

select * FROM surrogation.employeeSurrogation;
*/
