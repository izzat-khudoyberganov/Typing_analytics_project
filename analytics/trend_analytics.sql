WITH CTE AS (
SELECT
    *,
    LAG(word_per_minute) OVER(ORDER BY test_datetime ASC ) AS prev_words_per_minute,
    CASE 
        WHEN word_per_minute > LAG(word_per_minute) OVER(ORDER BY test_datetime ASC ) THEN 1
        ELSE 0
        END AS flag
FROM gold.fact_typing_tests
) SELECT CAST(ROUND(SUM(flag) * 1.0 / COUNT(*), 4) * 100 AS decimal(10, 2)) as my_avg_progress FROM CTE


