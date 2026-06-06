CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    BEGIN TRY
    TRUNCATE TABLE bronze.results
    BULK INSERT bronze.results
    FROM 'C:\SQL2022\DataWarehouse\monkeytype\results.csv'
    WITH (
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        ROWTERMINATOR = '0x0A',
        TABLOCK
    )
END TRY
BEGIN CATCH
        PRINT '====================================================='
		PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE()
		PRINT 'ERROR MESSAGE ' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'ERROR MESSAGE ' + CAST(ERROR_STATE() AS NVARCHAR)
		PRINT '====================================================='
END CATCH
END

EXEC bronze.load_bronze