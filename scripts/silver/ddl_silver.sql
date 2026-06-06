

IF OBJECT_ID('silver.dim_test_config', 'U') IS NOT NULL
  DROP TABLE silver.dim_test_config
GO

CREATE TABLE silver.dim_test_config
(
  config_id INT IDENTITY(1,1),
  mode VARCHAR(50),
  mode2 INT,
  quoteLength VARCHAR(50),
  punctuation VARCHAR(20),
  numbers VARCHAR(20),
  language VARCHAR(50),
  funbox VARCHAR(100),
  difficulty VARCHAR(50),
  lazyMode VARCHAR(20),
  blindMode VARCHAR(20),
  bailedOut VARCHAR(20),
  tags VARCHAR(500),
  isPb VARCHAR(20),
  created_at DATETIME DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.dim_date', 'U') IS NOT NULL
  DROP TABLE silver.dim_date
GO

CREATE TABLE silver.dim_date
(
  date_key INT IDENTITY(1,1),
  [timestamp] VARCHAR(50),
  date_day INT,           
  date_month VARCHAR(20), 
  date_year INT,          
  day_of_week VARCHAR(20),
  is_weekend VARCHAR(20),
  created_at DATETIME DEFAULT GETDATE()
)

IF OBJECT_ID('silver.fact_typing_tests', 'U') IS NOT NULL
  DROP TABLE silver.fact_typing_tests
GO

CREATE TABLE silver.fact_typing_tests
(
  fact_id INT IDENTITY(1,1),
  original_id VARCHAR(100),
  config_id INT,
  date_key INT,
  wpm DECIMAL(10, 2),
  acc DECIMAL(10, 2),
  rawWpm DECIMAL(10, 2),
  consistency DECIMAL(10, 2),
  testDuration DECIMAL(10, 2),
  [timestamp] VARCHAR(50)
)
GO