-- Check for Orphaned Records in Fact Table
-- Expectation: No records should exist without a Config or Date dimension entry
SELECT
  f.id
FROM gold.fact_typing_tests f
  LEFT JOIN gold.dim_test_config c
  ON f.id = c.id
  LEFT JOIN gold.dim_date_info d
  ON f.id = d.id
WHERE c.id IS NULL
  OR d.id IS NULL;

-- Check for Weekend Consistency
-- Expectation: If is_weekend is 'true', the day_of_week must be Saturday or Sunday
SELECT
  id,
  day_of_week,
  is_weekend
FROM gold.dim_date_info
WHERE (is_weekend = 'true' AND day_of_week NOT IN ('Saturday', 'Sunday'))
  OR (is_weekend = 'false' AND day_of_week IN ('Saturday', 'Sunday'));

-- Check for Skill Level Validity
-- Expectation: No unexpected skill levels (should match the business logic)
SELECT
  DISTINCT skill_level
FROM gold.fact_typing_tests
WHERE skill_level NOT IN 
  ('Normal', 'Expert', 'Master');

-- Check for Accuracy logic
-- Expectation: Accuracy percentage should be between 0 and 100
SELECT
  id,
  accuracy_percentage
FROM gold.fact_typing_tests
WHERE accuracy_percentage < 0
  OR accuracy_percentage > 100;

-- Check for Test Duration logic
-- Expectation: Duration should not be zero or negative (invalid test)
SELECT
  id,
  test_duration
FROM gold.fact_typing_tests
WHERE test_duration <= 0;

-- Check for duplicate IDs in Dim Tables
-- Expectation: No duplicates
SELECT
  id,
  COUNT(*)
FROM gold.dim_test_config
GROUP BY id
HAVING COUNT(*) > 1;

SELECT
  id,
  COUNT(*)
FROM gold.dim_date_info
GROUP BY id
HAVING COUNT(*) > 1;