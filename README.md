# Google Play Store Growth Analytics

## About the Project

I worked on this project to explore Google Play Store app data and understand how apps perform across different categories. I used Python for data cleaning and exploration, MySQL for querying the data, and Power BI to create a dashboard.

The main aim was to find patterns in app ratings, reviews, installations, pricing, and updates.

## Tools Used

- Python (Pandas)
- Jupyter Notebook
- MySQL
- Power BI
- Git and GitHub

## Project Work

### 1. Data Cleaning and EDA
I used Python and Pandas to inspect the dataset, handle missing values, correct data types, and prepare the data for further analysis.

Notebook: `notebooks/01_data_cleaning_eda.ipynb`

### 2. SQL Analysis
I loaded the cleaned data into MySQL and wrote queries to explore app categories, ratings, reviews, installations, pricing, and update trends. I also created SQL views to organize the results for Power BI.

SQL files:
- `SQL/02_mysql_data_cleaning_validation.sql`
- `SQL/03_sql_analysis.sql`
- `SQL/04_sql_views.sql`

### 3. Power BI Dashboard
I created a four-page report to explore different aspects of the dataset.

- **Market Overview:** Overall app statistics, category comparisons, and rating distribution.
- **Category Analysis:** App counts, average ratings, reviews, and installations by category.
- **Ratings & Pricing Analysis:** Ratings by content rating, paid app prices, and app update trends.
- **App Performance:** Comparison of highly rated apps, installations, and ratings.

Power BI file: `powerbi/Google_Play_Store_Growth_Analytics.pbix`

## Questions Explored

- Which app categories have more applications?
- Which categories have higher average ratings?
- How do free and paid apps compare?
- Which categories attract more installations?
- How are app ratings distributed?
- How do prices vary across paid apps?
- What can the available update dates tell us about update trends?
- Which highly rated apps also have a large number of installations?

## Project Structure

```text
Google-Play-Store-Growth-Analytics/
├── Data/
│   ├── raw/
│   │   └── googleplaystore.csv
│   └── google_play_store_cleaned.csv
├── SQL/
│   ├── 02_mysql_data_cleaning_validation.sql
│   ├── 03_sql_analysis.sql
│   └── 04_sql_views.sql
├── notebooks/
│   └── 01_data_cleaning_eda.ipynb
├── powerbi/
│   └── Google_Play_Store_Growth_Analytics.pbix
├── .gitignore
└── README.md
```

## How to Run

1. Clone this repository.
2. Open the notebook and run the Python analysis.
3. Import the cleaned CSV file into a MySQL database.
4. Run the SQL scripts in order.
5. Open the Power BI file in Power BI Desktop.

The MySQL connection may need to be updated to match your local database settings before refreshing the report.

## What I Learned

Through this project, I got practical experience with data cleaning, exploratory data analysis, SQL queries, aggregations, views, and Power BI visualizations. I also learned how to connect different stages of a data analytics workflow and maintain the project using Git and GitHub.

## Author

**Adeeksha Shettigar**

[View this project on GitHub](https://github.com/adeeksha0694/Google-Play-Store-Growth-Analytics)