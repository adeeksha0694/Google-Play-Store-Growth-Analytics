# Google Play Store Growth Analytics

## Project Overview

This project analyzes Google Play Store application data to understand app market trends, category performance, user ratings, pricing strategies, and installation patterns.

Using Python, MySQL, and Power BI, the project follows an end-to-end data analytics workflow, from data cleaning and exploratory data analysis to SQL-based analysis and interactive dashboard development.

## Objectives

- Analyze application distribution across different categories.
- Evaluate app ratings and review patterns.
- Compare free and paid applications.
- Identify categories with high installation counts and average ratings.
- Explore app pricing across categories.
- Examine app update trends over time.
- Identify highly rated applications with significant installation counts.

## Tools and Technologies

| Tool | Purpose |
|---|---|
| Python | Data cleaning and exploratory data analysis |
| Pandas | Data manipulation and preparation |
| Jupyter Notebook | Executing and documenting the analysis |
| MySQL | Data validation, SQL analysis, and views |
| Power BI | Interactive dashboards and data visualization |
| Git and GitHub | Version control and project hosting |

## Dataset

The project uses Google Play Store application data containing information such as:

- App name
- Category
- Rating
- Number of reviews
- Number of installs
- Application type (Free or Paid)
- Price
- Content rating
- Application size
- Last updated date

The repository includes the raw dataset and the cleaned dataset used in the analysis.

## Project Workflow

### 1. Data Cleaning and Exploratory Data Analysis

- Inspected the dataset structure and data types.
- Identified missing values and data quality issues.
- Cleaned and converted relevant columns into appropriate data types.
- Prepared the data for SQL analysis and visualization.
- Explored application ratings, installations, reviews, categories, and pricing.

**File:** `notebooks/01_data_cleaning_eda.ipynb`

### 2. MySQL Data Preparation

- Loaded the cleaned data into MySQL.
- Validated data types and numerical values.
- Checked missing values and data consistency.
- Prepared the dataset for analytical queries.

**File:** `SQL/02_mysql_data_cleaning_validation.sql`

### 3. SQL Analysis

Used SQL queries to investigate:

- Category-wise app performance.
- Free versus paid applications.
- Rating distribution.
- App update trends.
- Highly rated applications with substantial installations.

**File:** `SQL/03_sql_analysis.sql`

### 4. SQL Views

Created analytical views to organize query results and support Power BI reporting.

The views cover:

- Category performance.
- Free versus paid applications.
- Rating distribution.
- App update trends.
- Top-performing applications.

**File:** `SQL/04_sql_views.sql`

### 5. Power BI Dashboard

Developed a multi-page Power BI report to explore application performance and market trends.

The report contains four pages:

1. **Market Overview** – Key performance indicators, category comparisons, rating distribution, pricing type, and update trends.
2. **Category Analysis** – Category-level app distribution, average ratings, reviews, and installations.
3. **Ratings & Pricing Analysis** – Ratings by content rating, paid app pricing, rating groups, and update trends.
4. **App Performance** – Highly rated applications, installation comparisons, and ratings versus installations.

**File:** `powerbi/Google_Play_Store_Growth_Analytics.pbix`

## Key Areas of Analysis

- App distribution by category.
- Average rating and review comparisons.
- Installation performance across categories.
- Free and paid application distribution.
- Average pricing of paid applications.
- Distribution of applications by rating group.
- Relationship between app ratings and installations.
- Application update history.

## Repository Structure

```text
Google-Play-Store-Growth-Analytics/
│
├── Data/
│   ├── raw/
│   │   └── googleplaystore.csv
│   └── google_play_store_cleaned.csv
│
├── SQL/
│   ├── 02_mysql_data_cleaning_validation.sql
│   ├── 03_sql_analysis.sql
│   └── 04_sql_views.sql
│
├── notebooks/
│   └── 01_data_cleaning_eda.ipynb
│
├── powerbi/
│   └── Google_Play_Store_Growth_Analytics.pbix
│
├── .gitignore
└── README.md
```

## How to Use This Project

1. Clone or download this repository.
2. Open the Jupyter Notebook to review the data cleaning and exploratory analysis.
3. Import the cleaned dataset into MySQL.
4. Run the SQL scripts in the appropriate order to validate the data, perform analysis, and create views.
5. Open the Power BI file in Power BI Desktop to explore the dashboard.

**Note:** Update the MySQL connection settings in Power BI if your local database configuration differs. The database and table must be available before refreshing data that depends on MySQL.

## Skills Demonstrated

- Data cleaning and preprocessing
- Exploratory data analysis
- Python and Pandas
- SQL querying and aggregation
- Data validation
- SQL views
- Data visualization
- Power BI dashboard development
- Analytical thinking and insight generation

## Author

**Adeeksha Shettigar**

[GitHub Repository](https://github.com/adeeksha0694/Google-Play-Store-Growth-Analytics)