USE testScripts;
IF OBJECT_ID('transformations', 'P') IS NOT NULL
    DROP PROCEDURE transformations;
GO

CREATE PROCEDURE transformations 
AS
BEGIN
    -- Add dataSource column
    EXEC('
        ALTER TABLE loading_sources.Departments_temp_company
        ADD dataSource VARCHAR(20) DEFAULT ''Company'';
        
        ALTER TABLE loading_sources.Employees_temp_company
        ADD dataSource VARCHAR(20) DEFAULT ''Company'';
        
        ALTER TABLE loading_sources.Assignments_temp_company
        ADD dataSource VARCHAR(20) DEFAULT ''Company'';
        
        ALTER TABLE loading_sources.Projects_temp_company
        ADD dataSource VARCHAR(20) DEFAULT ''Company'';
        
        ALTER TABLE loading_sources.Customers_temp_company
        ADD dataSource VARCHAR(20) DEFAULT ''Company'';
        
        ALTER TABLE loading_sources.Orders_temp_company
        ADD dataSource VARCHAR(20) DEFAULT ''Company'';
        
        ALTER TABLE loading_sources.OrderDetails_temp_company
        ADD dataSource VARCHAR(20) DEFAULT ''Company'';
        
        ALTER TABLE loading_sources.Departments_temp_Source
        ADD dataSource VARCHAR(20) DEFAULT ''Source'';
        
        ALTER TABLE loading_sources.Employees_temp_Source
        ADD dataSource VARCHAR(20) DEFAULT ''Source'';
        
        ALTER TABLE loading_sources.Assignments_temp_Source
        ADD dataSource VARCHAR(20) DEFAULT ''Source'';
        
        ALTER TABLE loading_sources.Projects_temp_Source
        ADD dataSource VARCHAR(20) DEFAULT ''Source'';
    ')
    
    -- Update dataSource column
    EXEC('
        UPDATE loading_sources.Departments_temp_company
        SET dataSource = ''Company'';
        
        UPDATE loading_sources.Employees_temp_company
        SET dataSource = ''Company'';
        
        UPDATE loading_sources.Assignments_temp_company
        SET dataSource = ''Company'';
        
        UPDATE loading_sources.Projects_temp_company
        SET dataSource = ''Company'';
        
        UPDATE loading_sources.Customers_temp_company
        SET dataSource = ''Company'';
        
        UPDATE loading_sources.Orders_temp_company
        SET dataSource = ''Company'';
        
        UPDATE loading_sources.OrderDetails_temp_company
        SET dataSource = ''Company'';
        
        UPDATE loading_sources.Departments_temp_Source
        SET dataSource = ''Source'';
        
        UPDATE loading_sources.Employees_temp_Source
        SET dataSource = ''Source'';
        
        UPDATE loading_sources.Assignments_temp_Source
        SET dataSource = ''Source'';
        
        UPDATE loading_sources.Projects_temp_Source
        SET dataSource = ''Source'';
    ')
END;
GO
