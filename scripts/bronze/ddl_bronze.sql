IF OBJECT_ID('bronze.results', 'U') IS NOT NULL
    DROP TABLE bronze.results
GO

CREATE TABLE bronze.results
(
    id VARCHAR(100),
    isPb VARCHAR(20),
    wpm DECIMAL(10, 2),
    acc DECIMAL(10, 2),
    rawWpm DECIMAL(10, 2),
    consistency DECIMAL(10, 2),
    charStats VARCHAR(100),
    mode VARCHAR(50),
    mode2 INT,
    quoteLength VARCHAR(50),
    restartCount VARCHAR(50),
    testDuration DECIMAL(10, 2),
    afkDuration VARCHAR(50),
    incompleteTestSeconds VARCHAR(50),
    punctuation VARCHAR(20),
    numbers VARCHAR(20),
    language VARCHAR(50),
    funbox VARCHAR(100),
    difficulty VARCHAR(50),
    lazyMode VARCHAR(20),
    blindMode VARCHAR(20),
    bailedOut VARCHAR(20),
    tags VARCHAR(500),
    [timestamp] VARCHAR(50)
);

