CREATE OR ALTER PROCEDURE silver.load_silver
AS
BEGIN
  BEGIN TRY
      PRINT '>> Truncating Table: silver.dim_test_config';
      TRUNCATE TABLE silver.dim_test_config
      PRINT '>> Inserting Data Into: silver.dim_test_config';
      INSERT INTO silver.dim_test_config
    (
    mode,
    mode2,
    quoteLength,
    punctuation,
    numbers,
    [language],
    funbox,
    difficulty,
    lazyMode,
    blindMode,
    bailedOut,
    tags,
    isPb
    )
  SELECT
    mode,
    mode2,
    case 
          when quoteLength <=  0 then 'n/a'
          ELSE CAST(quoteLength AS VARCHAR(10))
        end as quoteLength,
    IIF(punctuation = 'true', 'yes', 'not') AS punctuation,
    IIF(numbers = 'true', 'yes', 'not') AS numbers,
    [language],
    ISNULL(funbox, 'n/a') as funbox,
    difficulty,
    IIF(lazyMode = 'true', 'yes', 'not') AS lazyMode,
    IIF(blindMode = 'true', 'yes', 'not') AS blindMode,
    IIF(bailedOut = 'true', 'yes', 'not') AS bailedOut,
    ISNULL(tags, 'n/a') AS tags,
    IIF(isPb = 'true', 'record', 'not record')
  FROM bronze.results;


      PRINT '>> Truncating Table: silver.dim_date';
      TRUNCATE TABLE silver.dim_date
      PRINT '>> Inserting Data into: silver.dim_date'
      INSERT INTO silver.dim_date
    (
    [timestamp],
    date_day,
    date_month,
    date_year,
    day_of_week,
    is_weekend
    )
  SELECT
    [timestamp],
    DAY(full_date) as date_day,
    FORMAT(full_date, 'MMM') as date_month,
    YEAR(full_date) as date_year,
    DATENAME(DW, full_date) as day_of_week,
    CASE 
            WHEN DATENAME(dw, full_date) IN ('Saturday', 'Sunday') THEN 'true' 
        ELSE 'false'
        END AS is_weekend
  FROM (
      SELECT
      [timestamp],
      DATEADD(second, CAST(timestamp as bigint) / 1000, '1970-01-01') AS full_date
    FROM
      bronze.results
    ) t
    END TRY
    BEGIN CATCH
        PRINT '====================================================='
        PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE()
        PRINT 'ERROR MESSAGE ' + CAST(ERROR_NUMBER() AS NVARCHAR)
        PRINT 'ERROR MESSAGE ' + CAST(ERROR_STATE() AS NVARCHAR)
        PRINT '====================================================='
    END CATCH
END

