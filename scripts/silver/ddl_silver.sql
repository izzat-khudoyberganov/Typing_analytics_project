IF OBJECT_ID('silver.test_config', 'U') IS NOT NULL
  DROP TABLE silver.test_config
GO

CREATE TABLE silver.test_config
(
  id VARCHAR(100) PRIMARY KEY,
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

IF OBJECT_ID('silver.date_info', 'U') IS NOT NULL
  DROP TABLE silver.date_info
GO

CREATE TABLE silver.date_info
(
  id VARCHAR(100) PRIMARY KEY,
  [timestamp] VARCHAR(50),
  date_day INT,
  date_month VARCHAR(20),
  date_year INT,
  day_of_week VARCHAR(20),
  is_weekend VARCHAR(20),
  created_at DATETIME DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.typing_tests', 'U') IS NOT NULL
  DROP TABLE silver.typing_tests
GO

CREATE TABLE silver.typing_tests
(
  id VARCHAR(100) PRIMARY KEY,
  wpm DECIMAL(5, 2),
  acc DECIMAL(5, 2),
  rawWpm DECIMAL(5, 2),
  consistency DECIMAL(5, 2),
  test_duration DECIMAL(8, 2),
  test_datetime DATETIME2,
  skill_level VARCHAR(20),
  created_at DATETIME DEFAULT GETDATE()
)
GO