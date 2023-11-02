<h1 align="center">Sales Insights Hardware Company Using Tableau and SQL <a href="https://public.tableau.com/app/profile/mrankitgupta" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/mrankitgupta/mrankitgupta/a768d6bf0a001f03327578ae12f8867e4056cbaf/tableau-software.svg" alt="tableau" width="55" height="40"/> </a> </h1>

### About Project 👨‍💻

- India based hardware company sales insights - A Data Analysis project.

- Using MySQL RDB to extract the data from the database file.

- Development of a Tableau dashboard to perform analysis and produce quantitative visualizations to give valuable insights based on different parameters affecting the company's performance. 

- Source  : https://www.youtube.com/watch?v=6BLY1IfV-1M&ab_channel=codebasics

## 📚 Table of Contents
- [Technologies used ](#technologies-used)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Instructions](#instructions)
- [Setup Process](#setup-process)
- [Data Analysis Using Tableau](#data-analysis-using-tableau)
- [MySql Appendix](#mysql-appendix)

## Entity Relationship Diagram

![image](https://raw.githubusercontent.com/robav112341/Sales-Insights-Hardware-Company-using-Tableau-and-SQL/main/India%20based%20hardware%20company/ERD.png)

## Technologies used 

* <a href="https://www.mysql.com/">MySQL</a><a href="https://www.mysql.com/" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/mysql/mysql-original-wordmark.svg" alt="mysql" width="45" height="30"/> </a> 

* <a href="https://public.tableau.com/app/profile/mrankitgupta">Tableau</a><a href="https://public.tableau.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/mrankitgupta/mrankitgupta/a768d6bf0a001f03327578ae12f8867e4056cbaf/tableau-software.svg" alt="tableau" width="45" height="30"/> </a> 

## Instructions 

Sales director is keen on evaluating the company's performance using various key factors.

- Revenue breakdown by cities.

- Revenue brekdown by years & months.

- Top 5 customers by revenue & sales quantity.

- Top 5 Products by revenue.
  
- Net Profit & Profit Margin by Market

## Setup Process
  
Step 1: Download file: <code>[db_dump_version_2.sql](https://github.com/robav112341/Sales-Insights-Hardware-Company-using-Tableau-and-SQL/blob/main/India%20based%20hardware%20company/DB/db_dump_version_2.sql)</code>

Step 2: Open the file in MySQL, Extract data from the database using SQL.
  
Step 4: Connect Tableau with MySql database or Excel database.
  
Step 5: Develop dashboards which could be used to gain insights from sales data.

## Data Analysis Using Tableau 

In order to provide a comprehensive view of the sales data, I decided to develop two distinct dashboards, each catering to a specific perspective - one focused on revenue and the other on net profit. While both dashboards contain similar information, they present it in terms of either profit or revenue, offering a well-rounded analysis of the data.

#### Revenue Dashboard 

<p  align="center"><a href="https://public.tableau.com/views/RevenueAnalysis_16988522446180/Dashboard1?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link"><img width="100%" src="https://raw.githubusercontent.com/robav112341/Sales-Insights-Hardware-Company-using-Tableau-and-SQL/main/India%20based%20hardware%20company/Tableau%20Files/Revenue%20Analysis.jpg" /></a></p>

#### Profit Dashboard 

<p  align="center"><a href="https://public.tableau.com/views/ProfitAnalysis_16988364274580/ProfitDashboard?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link"><img width="100%" src="https://raw.githubusercontent.com/robav112341/Sales-Insights-Hardware-Company-using-Tableau-and-SQL/main/India%20based%20hardware%20company/Tableau%20Files/Profit%20Dashboard.jpg" /></a></p>

## MySql Appendix

### Revenue Queries:

#### Revenue by year/month :

```sql
SELECT 
	order_date,
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    SUM(CASE
        WHEN currency = 'USD' THEN sales_amount * 83
        ELSE sales_amount
    END) AS revenue,
    SUM(sales_qty) AS products
FROM
    transactions
GROUP BY 2 , 3
ORDER BY 2 , 3;
```

#### Revenue By Year, Months And Markets:

```sql
SELECT 
	order_date,
    YEAR(t.order_date) AS year,
    MONTHNAME(t.order_date) AS month,
    markets_name,
    SUM(CASE
        WHEN t.currency = 'USD' THEN t.sales_amount * 83
        ELSE t.sales_amount
    END) AS revenue,
    SUM(t.sales_qty) AS products
FROM
    transactions t
        JOIN
    markets m ON t.market_code = m.markets_code
GROUP BY 2 , 3 , 4
ORDER BY 2 , 3 , 4;
```

#### Revenue By Year, Month And Customer Names :

```sql
SELECT 
	order_date,
    YEAR(t.order_date) AS year,
    MONTHNAME(t.order_date) AS month,
    c.custmer_name,
    SUM(t.sales_amount) AS revenue,
    SUM(t.sales_qty) AS products
FROM
    transactions t
        JOIN
    customers c ON t.customer_code = c.customer_code
GROUP BY 2 , 3 , 4
ORDER BY 2 , 3 , 4;
```

#### Revenue By Year, Month, Product_id:

```sql
SELECT 
	order_date,
    YEAR(t.order_date) AS year,
    MONTHNAME(t.order_date) AS month,
    t.product_code,
    p.product_type,
    SUM(t.sales_amount) AS revenue,
    SUM(t.sales_qty) AS products
FROM
    transactions t
        JOIN
    products p ON t.product_code = p.product_code
GROUP BY 2 , 3 , 4
ORDER BY 2 , 3 , 4;
```

### Profit Queries:

#### Profit by year/month :

```sql
ELECT 
    order_date,
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    ROUND(SUM(CASE
                WHEN currency = 'USD' THEN profit_margin * 83
                ELSE profit_margin
            END),
            1) AS net_profit,
    ROUND((SUM(CASE
                WHEN currency = 'USD' THEN profit_margin * 83
                ELSE profit_margin
            END)) / (SUM(CASE
                WHEN currency = 'USD' THEN sales_amount * 83
                ELSE sales_amount
            END)) * 100,
            3) AS profit_margin_percentage
FROM
    transactions
GROUP BY 2 , 3
ORDER BY 2 , 3;
```

#### Profit By Year, Months And Markets:

```sql
SELECT 
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    m.markets_name,
    ROUND(SUM(CASE
                WHEN t.currency = 'USD' THEN t.profit_margin * 83
                ELSE t.profit_margin
            END),
            1) AS revenue,
	ROUND((SUM(CASE
                WHEN t.currency = 'USD' THEN t.profit_margin * 83
                ELSE t.profit_margin
            END)) / (SUM(CASE
                WHEN t.currency = 'USD' THEN t.sales_amount * 83
                ELSE t.sales_amount
            END)) * 100,
            3) AS profit_margin_percentage
FROM
    transactions t
        JOIN
    markets m ON t.market_code = m.markets_code
GROUP BY 1 , 2 , 3 
ORDER BY 1 , 2 ASC , 4 DESC;
```

#### Profit By Year, Month And Customer Names :

```sql
SELECT 
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    c.custmer_name,
    ROUND(SUM(CASE
                WHEN t.currency = 'USD' THEN t.profit_margin * 83
                ELSE t.profit_margin
            END),
            1) AS revenue
FROM
    transactions t
        JOIN
    customers c ON t.customer_code = c.customer_code
GROUP BY 1 , 2 , 3
ORDER BY 1 , 2 ASC , 4 DESC;
```

#### Revenue By Year, Month, Product_id:

```sql
SELECT 
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    t.product_code,
    p.product_type,
    ROUND(SUM(CASE
                WHEN t.currency = 'USD' THEN t.profit_margin * 83
                ELSE t.profit_margin
            END),
            1) AS revenue
FROM
    transactions t
        JOIN
    products p ON t.product_code = p.product_code
GROUP BY 1 , 2 , 3
ORDER BY 1 , 2 ASC , 5 DESC;
```
