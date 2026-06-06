TRUNCATE TABLE silver.typing_tests
INSERT INTO silver.typing_tests (
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
    WHEN TRY_CAST( wpm as decimal(5,2)) < 30 THEN 'Beginner'
    WHEN TRY_CAST( wpm as decimal(5,2)) < 60 THEN 'Intermediate'
    ELSE 'Advanced'
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




select * from silver.typing_tests

exec silver.load_silver