IF OBJECT_ID('gold.dim_test_config', 'V') IS NOT NULL
  DROP VIEW gold.dim_test_config
GO

CREATE VIEW gold.dim_test_config
AS
    SELECT
        config_id AS id,
        mode,
        mode2,
        quoteLength as quote_length,
        punctuation,
        numbers,
        language,
        funbox,
        difficulty,
        lazyMode AS lazy_mode,
        blindMode AS blind_mode,
        bailedOut AS bailed_out,
        tags,
        isPb AS is_record
    FROM silver.test_config;
GO


IF OBJECT_ID('gold.dim_date_info', 'V') IS NOT NULL
  DROP VIEW gold.dim_date_info
GO

CREATE VIEW gold.dim_date_info
AS
    SELECT
        date_key AS id,
        date_day AS day,
        date_month AS month,
        date_year AS year,
        day_of_week AS day_of_week,
        is_weekend AS is_weekend
    FROM silver.date_info;
GO


if OBJECT_ID('gold.fact_typing_tests', 'V') IS NOT NULL
  DROP VIEW gold.fact_typing_tests
GO

CREATE VIEW gold.fact_typing_tests
AS
    SELECT
        t.id,
        c.config_id AS config_id,
        d.date_key AS date_key,
        d.date_key AS date_id,
        t.wpm,
        t.acc,
        t.rawWpm AS raw_wpm,
        t.consistency,
        t.test_duration AS test_duration_seconds,
        t.test_datetime,
        t.skill_level
    FROM silver.typing_tests t
        LEFT JOIN silver.test_config c
        ON t.id = c.config_id
        LEFT JOIN silver.date_info d
        ON t.test_datetime = DATEADD(second, TRY_CAST(d.[timestamp] as bigint) / 1000, '1970-01-01');
GO
