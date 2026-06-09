CREATE OR ALTER PROCEDURE silver.load_silver
AS
BEGIN
  BEGIN TRY
      PRINT '>> Truncating Table: silver.test_config';
      TRUNCATE TABLE silver.test_config
      PRINT '>> Inserting Data Into: silver.test_config';
  INSERT INTO silver.test_config
    (
    id,
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
    id,
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


  PRINT '>> Truncating Table: silver.date_info';
  TRUNCATE TABLE silver.date_info
  PRINT '>> Inserting Data into: silver.date_info'
  INSERT INTO silver.date_info
    (
    id,
    [timestamp],
    date_day,
    date_month,
    date_year,
    day_of_week,
    is_weekend
    )
  SELECT
    id,
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
      id,
      [timestamp],
      DATEADD(second, CAST(timestamp as bigint) / 1000, '1970-01-01') AS full_date
    FROM
      bronze.results
    ) t
    

    PRINT '>> Truncating Table: silver.typing_tests';
    TRUNCATE TABLE silver.typing_tests
    PRINT '>> Inserting Data into: silver.typing_tests'
INSERT INTO silver.typing_tests
    (
    id,
    wpm,
    acc,
    rawWpm,
    consistency,
    test_duration,
    skill_level,
    test_datetime
    )
  SELECT
    id,
    TRY_CAST(wpm as decimal(5,2)) AS wpm,
    TRY_CAST(acc  as decimal(5,2)) as acc,
    rawWpm,
    consistency,
    testDuration,
    CASE
    WHEN TRY_CAST( wpm as decimal(5,2)) < 30 THEN 'Normal'
    WHEN TRY_CAST( wpm as decimal(5,2)) < 60 THEN 'Expert'
    ELSE 'Master'
END AS skill_level,
    DATEADD(second, TRY_CAST(timestamp as bigint) / 1000, '1970-01-01')  AS test_datetime
  FROM (
  select
      *,
      ROW_NUMBER() OVER (
    PARTITION BY id
    ORDER BY timestamp DESC
) as rn
    from bronze.results
) t
  WHERE rn = 1
    and wpm IS NOT NULL
    AND acc IS NOT NULL
    AND testDuration IS NOT NULL


    END TRY
    BEGIN CATCH
        PRINT '====================================================='
        PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE()
        PRINT 'ERROR MESSAGE ' + CAST(ERROR_NUMBER() AS NVARCHAR)
        PRINT 'ERROR MESSAGE ' + CAST(ERROR_STATE() AS NVARCHAR)
        PRINT '====================================================='
    END CATCH
END

