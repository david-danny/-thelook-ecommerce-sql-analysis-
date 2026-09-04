-- TheLook E-commerce SQL Analysis
-- Question 2: Top Categories in 2024
-- Platform: Google BigQuery (GoogleSQL)
--
-- Objective:
-- Identify the five categories with the highest sales in calendar year 2024.
--
-- Note:
-- order_lines is used because the case-study definition requests a count of
-- order-item rows rather than distinct orders.

SELECT
  p.category,
  ROUND(SUM(oi.sale_price), 2) AS sales,
  COUNT(*) AS order_lines,
  ROUND(AVG(p.retail_price), 2) AS avg_retail_price
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
WHERE EXTRACT(YEAR FROM oi.created_at) = 2024
GROUP BY p.category
ORDER BY sales DESC
LIMIT 5;

