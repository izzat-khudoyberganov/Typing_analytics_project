-- Check for duplicate id in test_config table
-- Expectation: No duplicate id values should exist
SELECT
    id,
    COUNT(*)
FROM silver.test_config
GROUP BY id
HAVING COUNT(*) > 1


-- Check for duplicate mode in date_info table
-- Expectation: No duplicate mode values should exist
SELECT DISTINCT mode
FROM silver.test_config


-- Check for duplicate id in typing_tests table
-- Expectation: No duplicate id values should exist
SELECT id, COUNT(*)
FROM silver.date_info
GROUP BY id
HAVING COUNT(*) > 1



-- Check for invalid test_datetime values in typing_tests table
-- Expectation: All test_datetime values should be between '1970-01-01' AND '2050-01-01'
SELECT COUNT(*)
FROM silver.date_info
WHERE date_year < '1970' AND date_year > '2050'



-- Check for duplicate id in typing_tests table
-- Expectation: No duplicate id values should exist
SELECT id, COUNT(*)
from silver.typing_tests
GROUP BY id
HAVING COUNT(*) > 1


-- Check for invalid wpm, acc, and test_duration values in typing_tests table
-- Expectation: wpm should be between 0 and 500, acc should be between 0 and 100, and test_duration should be between 0 and 36000 seconds
SELECT COUNT(*)
FROM silver.typing_tests
WHERE (wpm < 0 OR wpm > 500 OR wpm IS NULL)
    OR (acc < 0 OR acc > 100 OR acc IS NULL)
    OR (test_duration < 0 OR test_duration > 36000 OR test_duration IS NULL);


-- Check for invalid skill_level values in typing_tests table
-- Expectation: skill_level should be either 'Normal', 'Expert', or 'Master'
SELECT DISTINCT skill_level
FROM silver.typing_tests
WHERE skill_level NOT IN ('Normal', 'Expert', 'Master')






