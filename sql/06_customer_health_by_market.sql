-- TheLook E-commerce SQL Analysis
-- Question 6: Customer Health by Market
-- Platform: Google BigQuery (GoogleSQL)
--
-- Objective:
-- Classify every registered user by purchase recency and calculate each
-- status bucket's share within country.
--
-- Recency rules:
-- active  = last purchase within 30 days
-- warm    = last purchase 31-90 days ago
-- churned = last purchase more than 90 days ago, or no recorded purchase
--
-- Reproducibility note:
-- CURRENT_DATE() makes this a live view. Replace it with a fixed DATE literal
-- when a stable historical snapshot is required.

WITH user_last_purchase AS (
  SELECT
    u.id AS user_id,
    COALESCE(u.country, 'Unknown') AS country,
    MAX(DATE(o.created_at)) AS last_purchase_date
  FROM `bigquery-public-data.thelook_ecommerce.users` AS u
  LEFT JOIN `bigquery-public-data.thelook_ecommerce.orders` AS o
    ON u.id = o.user_id
  GROUP BY u.id, country
),

user_status AS (
  SELECT
    user_id,
    country,
    last_purchase_date,
    CASE
      WHEN last_purchase_date IS NULL THEN 'churned'
      WHEN DATE_DIFF(CURRENT_DATE(), last_purchase_date, DAY) <= 30 THEN 'active'
      WHEN DATE_DIFF(CURRENT_DATE(), last_purchase_date, DAY) <= 90 THEN 'warm'
      ELSE 'churned'
    END AS status_bucket
  FROM user_last_purchase
),

country_status_counts AS (
  SELECT
    country,
    status_bucket,
    COUNT(*) AS user_count
  FROM user_status
  GROUP BY country, status_bucket
)

SELECT
  country,
  status_bucket,
  user_count,
  ROUND(
    100 * SAFE_DIVIDE(
      user_count,
      SUM(user_count) OVER (PARTITION BY country)
    ),
    2
  ) AS percent_of_users
FROM country_status_counts
ORDER BY country, status_bucket;

