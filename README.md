# Walmart-Sales-Analysis-Project

![Image](https://github.com/user-attachments/assets/5dfc4efe-23da-4b70-ab3e-5b1f66887fdb)

---

### Introduction

This project is an end-to-end data analysis solution designed to extract critical business insights from Walmart sales data. I utilize Python for data processing and analysis, SQL for advanced querying, and structured problem-solving techniques to solve key business questions.

---

## Project Steps

### 1. Set Up the Environment
   - **Tools Used**: Visual Studio Code (VS Code), Python, MySQL
   - **Goal**: Create a structured workspace within VS Code and organize project folders for smooth development and data handling.

### 2. Set Up Kaggle API
   - **API Setup**: Obtain my Kaggle API token from [Kaggle](https://www.kaggle.com/) by navigating to my profile settings and downloading the JSON file.
   - **Configure Kaggle**: 
      - Place the downloaded `kaggle.json` file in your local `.kaggle` folder.
      - Use the command `kaggle datasets download -d <dataset-path>` to pull datasets directly into your project.

### 3. Download Walmart Sales Data
   - **Data Source**: Use the Kaggle API to download the Walmart sales datasets from Kaggle.
   - **Dataset Link**: [Walmart Sales Dataset](https://www.kaggle.com/najir0123/walmart-10k-sales-datasets)
   - **Storage**: Save the data in the `data/` folder for easy reference and access.

### 4. Install Required Libraries and Load Data
   - **Libraries**: Install necessary Python libraries using:
     ```
     pip install pandas numpy sqlalchemy mysql-connector-python psycopg2
     ```
   - **Loading Data**: Read the data into a Pandas DataFrame for initial analysis and transformations.

### 5. Explore the Data
   - **Goal**: Conduct an initial data exploration to understand data distribution, check column names, types, and identify potential issues.
   - **Analysis**: Use functions like `.info()`, `.describe()`, and `.head()` to get a quick overview of the data structure and statistics.

### 6. Data Cleaning
   - **Remove Duplicates**: Identify and remove duplicate entries to avoid skewed results.
   - **Handle Missing Values**: Drop rows or columns with missing values if they are insignificant; fill values where essential.
   - **Fix Data Types**: Ensure all columns have consistent data types (e.g., dates as `datetime`, prices as `float`).
   - **Currency Formatting**: Use `.replace()` to handle and format currency values for analysis.
   - **Validation**: Check for any remaining inconsistencies and verify the cleaned data.

### 7. Feature Engineering
   - **Create New Columns**: Calculate the `Total Amount` for each transaction by multiplying `unit_price` by `quantity` and adding this as a new column.
   - **Enhance Dataset**: Adding this calculated field will streamline further SQL analysis and aggregation tasks.

### 8. Load Data into MySQL
   - **Set Up Connections**: Connect to MySQL using `sqlalchemy` and load the cleaned data into each database.
   - **Table Creation**: Set up tables in MySQL using Python SQLAlchemy to automate table creation and data insertion.
   - **Verification**: Run initial SQL queries to confirm that the data has been loaded accurately.

### 9. SQL Analysis: Complex Queries and Business Problem Solving
   - **Business Problem-Solving**: Write and execute complex SQL queries to answer critical business questions:
     - Q1. Find different payment_method and number of transaction, number of quantity sold.
     - Q2. Identify the highest-rated category in each branch, displaying the branch, category, average rating.
     - Q3. Identify the busiest day for each branch based on the number of transactions.
     - Q4. Calculate the total quantity of items sold per payment method. List payments method and total quantity.
     - Q5. Determine the average, minimum, and maximum rating of category for each city. List the city, average rating, min rating, and max rating.
     - Q6. Calculate the total profit for each category by considering total_profit as (unit_price * quantity * profit_margin) List category and total_profit, ordered from highest to lowest profit.
     - Q7. Determine the most common payment method for each branch. Display branch and the preferred payment method. 
     - Q8. Categorize sales into 3 group Morning, Afternoon, Evening. Find out each of the shift and number of invoices.
     - Q9. Identify 5 branch with hightest decrese ratio in revenue compare to last year(current year 2023 and last year 2022). (revenue decrese ratio = last year revenue-current year revenue/last year revenue*100)


     And I personally created the queries for Q10 to Q13
     - Q10. How many items were sold by each city? Objective: Identifying customer preferences by city.
     - Q11. What is the average profit margin for each branch and category? total * profit_margin = total revenue. Objective: Identifying profitability by branch.
     - Q12. What are the bottom 10 branches and categories with low ratings? Objective: Identify branches or products with service quality issues.
     - Q13. What is the proportion of payment methods used within each product category? Objective: Identify customer payment preferences based on product type.

  ### 10. Visualizing for Power BI - [Walmart Sales Analysis](https://github.com/osm4307/walmart-sales-analysis-project/blob/main/walmart_sales_analysis.png)
   - Loaded the necessary queries for visualization and created the visualizations in Power BI.


#### I referred to the project from this [Link](https://github.com/najirh/Walmart_SQL_Python/blob/main/README.md), but I personally created the queries for Q10 to Q13 in MySQL and also built the corresponding visualizations in Power BI on my own.
#### Thanks to Najir H
---

## Requirements

- **Python 3.8+**
- **SQL Databases**: MySQL
- **Python Libraries**:
  - `pandas`, `numpy`, `sqlalchemy`, `mysql-connector-python`
- **Kaggle API Key** (for data downloading)

## Getting Started

1. Clone the repository:
   ```
   git clone <repo-url>
   ```
2. Install Python libraries:
   ```
   pip install -r requirements.txt
   ```
3. Set up my Kaggle API, download the data, and follow the steps to load and analyze.

---

## Results and Insights

- **Sales Insights**: Key categories, branches with highest sales, and preferred payment methods.
- **Profitability**: Insights into the most profitable product categories and locations.
- **Customer Behavior**: Trends in ratings, payment preferences, and peak shopping hours.

---

## License

This project is licensed under the MIT License. 
