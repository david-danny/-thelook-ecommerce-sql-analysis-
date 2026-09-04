-- TheLook E-commerce SQL Analysis
-- Question 4: First vs. Repeat Purchases
-- Platform: Google BigQuery (GoogleSQL)
--
-- Objective:
-- Classify every order as a user's first or repeat purchase, then compare
-- total orders, sales, and average order value.

WITH order_summary AS (
  SELECT
    order_id,
    user_id,
    MIN(created_at) AS order_date,
    SUM(sale_price) AS order_sales
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  GROUP BY order_id, user_id
),

ranked_orders AS (
  SELECT
    order_id,
    user_id,
    order_date,
    order_sales,
    ROW_NUMBER() OVER (
      PARTITION BY user_id
      ORDER BY order_date, order_id
    ) AS order_sequence
  FROM order_summary
)

SELECT
  CASE
    WHEN order_sequence = 1 THEN 'First Purchase'
    ELSE 'Repeat Purchase'
  END AS order_type,
  COUNT(*) AS orders,
  ROUND(SUM(order_sales), 2) AS sales,
  ROUND(SAFE_DIVIDE(SUM(order_sales), COUNT(*)), 2) AS aov
FROM ranked_orders
GROUP BY order_type
ORDER BY order_type;

