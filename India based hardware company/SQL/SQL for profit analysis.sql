-- Total net profit + margins.
SELECT 
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

-- Net profit by markets
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

-- Net Profit by customer
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

-- Products Profit:
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