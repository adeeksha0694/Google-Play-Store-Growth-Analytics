-- Create and select database
CREATE DATABASE google_play_store;
USE google_play_store;


-- Create apps table
CREATE TABLE apps (
    App VARCHAR(255),
    Category VARCHAR(100),
    Rating VARCHAR(20),
    Reviews BIGINT,
    Size VARCHAR(50),
    Installs BIGINT,
    Type VARCHAR(20),
    Price VARCHAR(20),
    Content_Rating VARCHAR(50),
    Genres VARCHAR(100),
    Last_Updated VARCHAR(30),
    Current_Ver VARCHAR(50),
    Android_Ver VARCHAR(50),
    Size_MB VARCHAR(20)
);


-- Import CSV file
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/google_play_store_cleaned.csv'
INTO TABLE apps
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- Verify imported rows
SELECT COUNT(*) AS total_rows FROM apps;

-- View first five records
SELECT * FROM apps LIMIT 5;

-- Check column data types
DESCRIBE apps;


-- Convert Rating to decimal
ALTER TABLE apps
MODIFY Rating DECIMAL(3,2) NULL;

-- Check missing ratings
SELECT DISTINCT Rating
FROM apps
WHERE Rating = '' OR Rating IS NULL;

-- Replace empty ratings with NULL
UPDATE apps
SET Rating = NULL
WHERE Rating = '';


-- Convert Price to decimal
ALTER TABLE apps
MODIFY Price DECIMAL(10,2) NULL;


-- Convert Last_Updated to date
ALTER TABLE apps
MODIFY Last_Updated DATE NULL;


-- Replace empty Size_MB values with NULL
UPDATE apps
SET Size_MB = NULL
WHERE Size_MB = '';

-- Check distinct app sizes
SELECT DISTINCT Size_MB
FROM apps
ORDER BY Size_MB;


-- Check missing app sizes
SELECT
    COUNT(*) AS total_rows,
    SUM(Size_MB IS NULL) AS null_sizes,
    SUM(TRIM(Size_MB) = '') AS empty_sizes
FROM apps;


-- Check Size_MB data type
SHOW COLUMNS FROM apps LIKE 'Size_MB';


-- Find non-numeric app sizes
SELECT Size_MB
FROM apps
WHERE Size_MB IS NOT NULL
  AND TRIM(Size_MB) <> ''
  AND TRIM(Size_MB) NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'
LIMIT 20;


-- Final missing-value check
SELECT
    COUNT(*) AS total_rows,
    SUM(Size_MB IS NULL) AS null_values,
    SUM(Size_MB = '') AS empty_values,
    SUM(TRIM(Size_MB) = '') AS blank_or_whitespace_values
FROM apps;

-- Create and select database
CREATE DATABASE google_play_store;
USE google_play_store;


-- Create apps table
CREATE TABLE apps (
    App VARCHAR(255),
    Category VARCHAR(100),
    Rating VARCHAR(20),
    Reviews BIGINT,
    Size VARCHAR(50),
    Installs BIGINT,
    Type VARCHAR(20),
    Price VARCHAR(20),
    Content_Rating VARCHAR(50),
    Genres VARCHAR(100),
    Last_Updated VARCHAR(30),
    Current_Ver VARCHAR(50),
    Android_Ver VARCHAR(50),
    Size_MB VARCHAR(20)
);


-- Import CSV file
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/google_play_store_cleaned.csv'
INTO TABLE apps
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- Verify imported rows
SELECT COUNT(*) AS total_rows FROM apps;

-- View first five records
SELECT * FROM apps LIMIT 5;

-- Check column data types
DESCRIBE apps;


-- Convert Rating to decimal
ALTER TABLE apps
MODIFY Rating DECIMAL(3,2) NULL;

-- Check missing ratings
SELECT DISTINCT Rating
FROM apps
WHERE Rating = '' OR Rating IS NULL;

-- Replace empty ratings with NULL
UPDATE apps
SET Rating = NULL
WHERE Rating = '';


-- Convert Price to decimal
ALTER TABLE apps
MODIFY Price DECIMAL(10,2) NULL;


-- Convert Last_Updated to date
ALTER TABLE apps
MODIFY Last_Updated DATE NULL;


-- Replace empty Size_MB values with NULL
UPDATE apps
SET Size_MB = NULL
WHERE Size_MB = '';

-- Check distinct app sizes
SELECT DISTINCT Size_MB
FROM apps
ORDER BY Size_MB;


-- Check missing app sizes
SELECT
    COUNT(*) AS total_rows,
    SUM(Size_MB IS NULL) AS null_sizes,
    SUM(TRIM(Size_MB) = '') AS empty_sizes
FROM apps;


-- Check Size_MB data type
SHOW COLUMNS FROM apps LIKE 'Size_MB';


-- Find non-numeric app sizes
SELECT Size_MB
FROM apps
WHERE Size_MB IS NOT NULL
  AND TRIM(Size_MB) <> ''
  AND TRIM(Size_MB) NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'
LIMIT 20;


-- Final missing-value check
SELECT
    COUNT(*) AS total_rows,
    SUM(Size_MB IS NULL) AS null_values,
    SUM(Size_MB = '') AS empty_values,
    SUM(TRIM(Size_MB) = '') AS blank_or_whitespace_values
FROM apps;

-- Check for values that cannot be converted to numbers
SELECT Size_MB
FROM apps
WHERE CAST(Size_MB AS DECIMAL(10,2)) IS NULL
LIMIT 10;

-- Convert app size from text to a numeric data type
ALTER TABLE apps
MODIFY Size_MB DECIMAL(10,2) NULL;

-- Test how MySQL converts the Size_MB values
SELECT
    Size_MB,
    CAST(Size_MB AS DECIMAL(10,2)) AS converted_size
FROM apps
LIMIT 10;

-- Check the range of app sizes before converting the column
SELECT
    MIN(CAST(Size_MB AS DECIMAL(10,2))) AS min_size_mb,
    MAX(CAST(Size_MB AS DECIMAL(10,2))) AS max_size_mb
FROM apps;

-- Create a numeric column for app size in MB
ALTER TABLE apps
ADD COLUMN Size_MB_numeric DECIMAL(10,2) NULL;

-- Convert app sizes to numeric values
UPDATE apps
SET Size_MB_numeric = CAST(Size_MB AS DECIMAL(10,2));

-- Show the exact contents of the non-numeric value
SELECT
    CONCAT('[', Size_MB, ']') AS size_value,
    LENGTH(Size_MB) AS value_length,
    HEX(Size_MB) AS value_hex
FROM apps
WHERE Size_MB IS NOT NULL
  AND TRIM(Size_MB) <> ''
  AND TRIM(Size_MB) NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'
LIMIT 10;


-- Remove hidden carriage return characters from app sizes
UPDATE apps
SET Size_MB = TRIM(REPLACE(Size_MB, CHAR(13), ''))
WHERE LOCATE(CHAR(13), Size_MB) > 0;

-- Check for remaining hidden characters and numeric-column values
SELECT
    SUM(LOCATE(CHAR(13), Size_MB) > 0) AS remaining_carriage_returns,
    SUM(LOCATE(CHAR(10), Size_MB) > 0) AS remaining_line_feeds,
    SUM(Size_MB_numeric IS NULL) AS empty_numeric_values,
    COUNT(*) AS total_rows
FROM apps;

-- Test numeric conversion on a single app
SELECT
    Size_MB,
    CAST(TRIM(Size_MB) AS DECIMAL(10,2)) AS converted_size
FROM apps
LIMIT 1;

-- Check the MySQL server version
SELECT VERSION() AS mysql_version;

-- Check whether the apps table has triggers
SHOW TRIGGERS WHERE `Table` = 'apps';

-- Test whether the numeric column accepts a value
UPDATE apps
SET Size_MB_numeric = 19.00
WHERE App = 'Photo Editor & Candy Camera - Grid & ScrapBook'
LIMIT 1;

-- Check the first few app names and their numeric values
SELECT App, Size_MB, Size_MB_numeric
FROM apps
LIMIT 5;

-- Test updating the first row
UPDATE apps
SET Size_MB_numeric = CAST(TRIM(Size_MB) AS DECIMAL(10,2))
LIMIT 1;

-- Convert the remaining app sizes to numeric values
UPDATE apps
SET Size_MB_numeric = CAST(TRIM(Size_MB) AS DECIMAL(10,2))
WHERE Size_MB_numeric IS NULL;

-- Find values that cannot be converted to a decimal
SELECT
    CONCAT('[', Size_MB, ']') AS size_value,
    HEX(Size_MB) AS value_hex,
    COUNT(*) AS occurrences
FROM apps
WHERE Size_MB_numeric IS NULL
  AND TRIM(Size_MB) NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'
GROUP BY Size_MB, HEX(Size_MB)
LIMIT 20;

-- Convert available sizes and preserve missing values as NULL
UPDATE apps
SET Size_MB_numeric = CAST(TRIM(Size_MB) AS DECIMAL(10,2))
WHERE Size_MB_numeric IS NULL
  AND NULLIF(TRIM(Size_MB), '') IS NOT NULL;
  
  -- Verify numeric conversions and missing sizes
SELECT
    COUNT(*) AS total_rows,
    SUM(Size_MB_numeric IS NOT NULL) AS converted_sizes,
    SUM(Size_MB_numeric IS NULL) AS missing_sizes
FROM apps;

-- Verify the numeric column's data type
SHOW COLUMNS FROM apps LIKE 'Size_MB_numeric';

-- Remove the original text-based size column
ALTER TABLE apps
DROP COLUMN Size_MB;

-- Rename the column and retain its numeric data type
ALTER TABLE apps
CHANGE COLUMN Size_MB_numeric Size_MB DECIMAL(10,2) NULL;

-- Review the current table structure
DESCRIBE apps;

-- Confirm the row count and missing app sizes
SELECT
    COUNT(*) AS total_apps,
    SUM(Size_MB IS NOT NULL) AS apps_with_size,
    SUM(Size_MB IS NULL) AS apps_missing_size
FROM apps;

-- Check the installation count range
SELECT
    MIN(Installs) AS minimum_installs,
    MAX(Installs) AS maximum_installs
FROM apps;


-- Check whether any apps have negative install counts
SELECT COUNT(*) AS negative_install_counts
FROM apps
WHERE Installs < 0;

-- Check whether any apps have negative prices
SELECT COUNT(*) AS negative_prices
FROM apps
WHERE Price < 0;

-- Find ratings outside the valid range
SELECT COUNT(*) AS invalid_ratings
FROM apps
WHERE Rating < 1 OR Rating > 5;

-- Check missing values in key columns
SELECT
    SUM(App IS NULL OR TRIM(App) = '') AS missing_app_names,
    SUM(Category IS NULL OR TRIM(Category) = '') AS missing_categories,
    SUM(Installs IS NULL) AS missing_installs
FROM apps;

-- Find app names appearing more than once
SELECT
    App,
    COUNT(*) AS app_count
FROM apps
GROUP BY App
HAVING COUNT(*) > 1
ORDER BY app_count DESC
LIMIT 10;

-- Compare records for an app with repeated names
SELECT
    App,
    Category,
    Rating,
    Reviews,
    Installs,
    Type,
    Price,
    Last_Updated,
    Current_Ver
FROM apps
WHERE App = 'ROBLOX'
ORDER BY Last_Updated DESC;

-- Find records identical across all app attributes
SELECT
    App,
    Category,
    Rating,
    Reviews,
    Size,
    Installs,
    Type,
    Price,
    Content_Rating,
    Genres,
    Last_Updated,
    Current_Ver,
    Android_Ver,
    Size_MB,
    COUNT(*) AS duplicate_count
FROM apps
GROUP BY
    App,
    Category,
    Rating,
    Reviews,
    Size,
    Installs,
    Type,
    Price,
    Content_Rating,
    Genres,
    Last_Updated,
    Current_Ver,
    Android_Ver,
    Size_MB
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC
LIMIT 10;

-- Count unique app names
SELECT
    COUNT(DISTINCT App) AS unique_apps,
    COUNT(*) AS total_records
FROM apps;

-- Count app names that appear in multiple records
SELECT COUNT(*) AS repeated_app_names
FROM (
    SELECT App
    FROM apps
    GROUP BY App
    HAVING COUNT(*) > 1
) AS repeated_apps;

-- Rank app names by number of records
SELECT
    App,
    COUNT(*) AS record_count
FROM apps
GROUP BY App
HAVING COUNT(*) > 1
ORDER BY record_count DESC, App
LIMIT 10;
