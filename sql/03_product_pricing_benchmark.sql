-- TheLook E-commerce SQL Analysis
-- Question 3: Product Pricing Benchmark
-- Platform: Google BigQuery (GoogleSQL)
--
-- Objective:
-- Compare each product's retail price with the average price of products in
-- the same category and return the 20 largest positive differences.
--
-- Important interpretation:
-- This is an internal category benchmark, not an external market-price test.

WITH product_price_benchmark AS (
  SELECT
    id AS product_id,
    name,
    category,
    retail_price,
    AVG(retail_price) OVER (PARTITION BY category) AS avg_category_price
  FROM `bigquery-public-data.thelook_ecommerce.products`
)

SELECT
  product_id,
  name,
  category,
  retail_price,
  ROUND(avg_category_price, 2) AS avg_category_price,
  CASE
    WHEN retail_price > avg_category_price THEN 1
    ELSE 0
  END AS is_above_avg,
  ROUND(retail_price - avg_category_price, 2) AS price_delta
FROM product_price_benchmark
WHERE retail_price > avg_category_price
ORDER BY price_delta DESC
LIMIT 20;

