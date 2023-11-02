-- Revenue by year/month
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

-- break by year,month,market
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

-- Customer Analysis
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

-- top 5 products sales by year, month
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