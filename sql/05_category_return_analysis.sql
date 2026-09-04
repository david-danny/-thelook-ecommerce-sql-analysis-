-- TheLook E-commerce SQL Analysis
-- Question 5: Category Return Leakage
-- Platform: Google BigQuery (GoogleSQL)
--
-- Objective:
-- Measure distinct returned orders, returned sales amount, and returned-sales
-- rate for each product category.
--
-- Metric definition:
-- returned_sales_rate_pct = returned sales / total category sales * 100

WITH category_sales AS (
  SELECT
    p.category,
    SUM(oi.sale_price) AS total_sales
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
    ON oi.product_id = p.id
  GROUP BY p.category
),

category_returns AS (
  SELECT
    p.category,
    COUNT(DISTINCT oi.order_id) AS returned_orders,
    SUM(oi.sale_price) AS returned_sales
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  INNER JOIN `bigquery-public-data.thelook_ecommerce.orders` AS o
    ON oi.order_id = o.order_id
  LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
    ON oi.product_id = p.id
  WHERE o.status = 'Returned'
  GROUP BY p.category
)

SELECT
  cr.category,
  cr.returned_orders,
  ROUND(cr.returned_sales, 2) AS returned_sales,
  ROUND(
    100 * SAFE_DIVIDE(cr.returned_sales, cs.total_sales),
    2
  ) AS returned_sales_rate_pct
FROM category_returns AS cr
INNER JOIN category_sales AS cs
  ON cr.category = cs.category
ORDER BY returned_sales_rate_pct DESC;

