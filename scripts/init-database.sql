USE master;
GO

-- Drop and recreate the 'TypingDataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'TypingDataWarehouse')
BEGIN
    ALTER DATABASE TypingDataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TypingDataWarehouse;
END;
GO

-- Create the 'TypingDataWarehouse' database
CREATE DATABASE TypingDataWarehouse;
GO

USE TypingDataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO


CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO