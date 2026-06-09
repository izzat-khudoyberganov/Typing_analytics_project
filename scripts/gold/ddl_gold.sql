IF OBJECT_ID('gold.dim_test_config', 'V') IS NOT NULL
  DROP VIEW gold.dim_test_config
GO

CREATE VIEW gold.dim_test_config
AS
    SELECT
        id,
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
        id,
        date_day AS day,
        date_month AS month,
        date_year AS year,
        day_of_week AS day_of_week,
        is_weekend AS is_weekend
    FROM silver.date_info;
GO


IF OBJECT_ID('gold.fact_typing_tests', 'V') IS NOT NULL
    DROP VIEW gold.fact_typing_tests
GO

CREATE VIEW gold.fact_typing_tests
AS
    SELECT
        t.id,
        t.wpm  AS word_per_minute,
        t.acc  AS accuracy_percentage,
        t.rawWpm,
        t.consistency AS consistency_percentage,
        t.test_duration,
        t.skill_level,

        -- Config data
        c.mode,
        c.difficulty,
        c.[language],
        c.isPb AS is_personal_best,
        c.punctuation,

        -- Date info
        d.date_month,
        d.day_of_week,
        d.is_weekend,
        t.test_datetime
    FROM silver.typing_tests t
        LEFT JOIN silver.test_config c ON t.id = c.id
        LEFT JOIN silver.date_info d ON t.id = d.id
GO
