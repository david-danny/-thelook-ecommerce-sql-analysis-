-- TheLook E-commerce SQL Analysis
-- Question 1: Monthly Sales Pulse
-- Platform: Google BigQuery (GoogleSQL)
--
-- Objective:
-- Measure monthly unique buyers, orders, sales, and average order value (AOV)
-- from January 2019 onward.
--
-- Metric definitions:
-- sales  = sum of order-item sale prices
-- orders = distinct order IDs
-- aov    = sales / distinct orders

SELECT
  FORMAT_DATE('%Y-%m', DATE(created_at)) AS month,
  COUNT(DISTINCT user_id) AS unique_buyers,
  COUNT(DISTINCT order_id) AS orders,
  ROUND(SUM(sale_price), 2) AS sales,
  ROUND(
    SAFE_DIVIDE(SUM(sale_price), COUNT(DISTINCT order_id)),
    2
  ) AS aov
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE DATE(created_at) >= DATE '2019-01-01'
GROUP BY month
ORDER BY month;

