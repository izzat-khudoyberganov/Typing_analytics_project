IF OBJECT_ID('bronze.results', 'U') IS NOT NULL
    DROP TABLE bronze.results
GO

CREATE TABLE bronze.results (
    id VARCHAR(100),
    isPb VARCHAR(20),
    wpm VARCHAR(50),
    acc VARCHAR(50),
    rawWpm VARCHAR(50),
    consistency VARCHAR(50),
    charStats VARCHAR(100),
    mode VARCHAR(50),
    mode2 VARCHAR(50),
    quoteLength VARCHAR(50),
    restartCount VARCHAR(50),
    testDuration VARCHAR(50),
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