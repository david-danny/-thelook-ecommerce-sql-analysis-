# TheLook E-commerce Performance & Customer Analysis

An end-to-end SQL case study using Google BigQuery to diagnose growth, product performance, pricing, repeat purchasing, returns, and customer health for TheLook, a fictional online fashion retailer.

> **Author:** David Danny  
> **Platform:** Google BigQuery  
> **Visualization:** Looker Studio  
> **Dataset:** `bigquery-public-data.thelook_ecommerce`

## Executive Summary

TheLook's leadership needs a focused Q4 plan after growth slowed and returns increased. This project answers six business questions across commercial performance, merchandising, pricing, acquisition versus retention, operational leakage, and market-level customer health.

The analysis indicates that:

- Monthly order growth closely tracks growth in unique buyers, while AOV increases more gradually. The pattern is therefore more consistent with buyer-base expansion than with material basket-size growth.
- Outerwear & Coats, Jeans, Sweaters, Swim, and Fashion Hoodies & Sweatshirts are the leading 2024 categories in the analysis output.
- The largest product price gaps are measured against internal category averages. They identify candidates for pricing review or stronger premium positioning, not proof that the products are overpriced relative to the external market.
- First purchases account for **63.8% of orders**, compared with **36.2%** for repeat purchases in the analysis snapshot.
- **Pants has the highest return rate at 11.12%**, while **Outerwear & Coats has the highest returned sales amount at 127,808.19** in the displayed results.
- Most users in the larger country segments are classified as churned/inactive, generally around 79%-81%, making targeted win-back analysis a priority alongside acquisition.

## Business Problem

TheLook is an online fashion retailer facing slower growth and rising returns. Leadership needs evidence to decide:

1. Whether sales growth is driven by more buyers, more orders, or higher order value.
2. Which categories deserve merchandising and promotional priority.
3. Which products sit far above their category's internal price benchmark.
4. Whether first-time or repeat purchases contribute more to order volume and revenue.
5. Which categories create the greatest return-related revenue leakage.
6. Which country markets have the strongest opportunities for reactivation.

## Dataset and Scope

The project uses the public TheLook Ecommerce dataset in BigQuery. The main tables are:

| Table | Purpose in this analysis |
|---|---|
| `order_items` | Line-item sales, product, order, user, and transaction timestamps |
| `orders` | Order status and order-level customer linkage |
| `products` | Product names, categories, and retail prices |
| `users` | Customer country and user identifiers |

The raw data is not stored in this repository because it is queried directly from BigQuery. Results may change as the public dataset is refreshed. See [data/README.md](data/README.md) and [docs/analysis-notes.md](docs/analysis-notes.md) for metric definitions and reproducibility notes.

## Tools and SQL Techniques

- **Google BigQuery / GoogleSQL**
- **Looker Studio** for result visualization
- Joins across transactional, product, order, and user tables
- Aggregate functions and conditional aggregation
- Common Table Expressions (CTEs)
- Window functions: `AVG() OVER`, `ROW_NUMBER()`, and partitioned totals
- Date functions and customer recency classification
- `CASE`, `SAFE_DIVIDE`, and explicit business metric definitions

## Analysis

### 1. Monthly Sales Pulse

**Business question:** How have monthly buyers, orders, sales, and AOV changed since 2019?

**Approach:** Aggregate line-item sales by month, count distinct buyers and orders, and calculate AOV as sales divided by distinct orders.

**Finding:** Orders and unique buyers move in a similar pattern, while AOV rises more gradually. This suggests growth is associated more strongly with an expanding buyer base than with large increases in basket value. Confirming order-frequency growth would require an additional `orders_per_buyer` metric.

![Monthly sales trend](assets/monthly-sales-trend.png)

[View SQL query](sql/01_monthly_sales_pulse.sql)

### 2. Top Categories in 2024

**Business question:** Which five product categories generated the highest sales in calendar year 2024?

**Approach:** Join order items to products, aggregate sales and order lines by category, and rank categories by sales.

**Finding:** Outerwear & Coats leads the visualized ranking, followed by Jeans, Sweaters, Swim, and Fashion Hoodies & Sweatshirts. These categories are candidates for prominent merchandising, but promotion decisions should also consider gross margin, stock availability, and return rates.

![Top categories by sales in 2024](assets/top-categories-2024.png)

[View SQL query](sql/02_top_categories_2024.sql)

### 3. Product Pricing Benchmark

**Business question:** Which products have the largest positive price difference from their category average?

**Approach:** Use a windowed category average, flag products priced above that benchmark, calculate the price delta, and return the 20 largest positive gaps.

**Finding:** The largest observed gap is for Alpha Industries Rip Stop Short: a retail price of 999 versus a category average of approximately 45.77, a delta of 953.23. These large internal gaps warrant data-quality checks and product-level review before pricing or promotional action.

![Products above category-average price](assets/product-pricing-benchmark.png)

[View SQL query](sql/03_product_pricing_benchmark.sql)

### 4. First vs. Repeat Purchases

**Business question:** How do order volume, sales, and AOV differ between first and repeat purchases?

**Approach:** Summarize order-level sales, rank each user's orders chronologically, label the first order, and aggregate the two order types.

**Finding:** First purchases represent **63.8% of order volume**, while repeat purchases represent **36.2%**. This supports continued acquisition and onboarding investment, but a budget decision should also compare revenue, AOV, retention cost, and customer lifetime value between the groups.

![First versus repeat purchases](assets/first-vs-repeat-purchases.png)

[View SQL query](sql/04_first_vs_repeat_purchases.sql)

### 5. Category Return Leakage

**Business question:** Which categories have the highest returned sales amount and returned-sales rate?

**Approach:** Calculate total category sales, isolate orders with `Returned` status, then compare distinct returned orders and returned sales with the category total.

**Finding:** Pants has the highest return rate (**11.12%**), followed by Leggings (**10.99%**) and Accessories (**10.88%**). Outerwear & Coats has the highest returned sales amount (**127,808.19**), followed by Jeans (**121,753.89**). Operations should therefore separate rate-based quality issues from high-value leakage.

![Category return analysis](assets/category-return-analysis.png)

[View SQL query](sql/05_category_return_analysis.sql)

### 6. Customer Health by Market

**Business question:** What share of each country's users is active, warm, or churned based on purchase recency?

**Approach:** Find each user's latest order date, classify recency into 0-30, 31-90, and 90+ day buckets, and calculate each bucket's share within country.

**Finding:** Larger markets show a broadly similar pattern, with roughly 79%-81% of users in the inactive/churned group in the visualized snapshot. Rather than treating retention as ineffective, this indicates a sizable win-back opportunity. Campaign prioritization should combine the percentage with user count, historical value, and reactivation cost.

![Customer health by country](assets/customer-health-by-country.png)

[View SQL query](sql/06_customer_health_by_market.sql)

## Recommended Actions

1. **Protect growth quality:** Track buyers, orders per buyer, AOV, repeat rate, and contribution margin together so that acquisition-led growth is not mistaken for stronger engagement.
2. **Prioritize categories with guardrails:** Give leading categories greater visibility only after validating margin, inventory coverage, and return exposure.
3. **Review extreme price gaps:** Validate product records, then test premium messaging, bundling, or pricing for products far above their category average.
4. **Improve the first-to-second-order journey:** Pair acquisition investment with onboarding and lifecycle experiments designed to convert first-time customers into repeat buyers.
5. **Use a two-axis return strategy:** Investigate Pants, Leggings, and Accessories for high return rates, while targeting Outerwear & Coats and Jeans for high returned-value leakage.
6. **Segment win-back campaigns:** Prioritize high-value churned users in the largest markets and measure incremental reactivation rather than relying on broad discounts.

## Repository Structure

```text
thelook-ecommerce-sql-analysis/
├── README.md
├── sql/
│   ├── 01_monthly_sales_pulse.sql
│   ├── 02_top_categories_2024.sql
│   ├── 03_product_pricing_benchmark.sql
│   ├── 04_first_vs_repeat_purchases.sql
│   ├── 05_category_return_analysis.sql
│   └── 06_customer_health_by_market.sql
├── assets/
│   ├── monthly-sales-trend.png
│   ├── top-categories-2024.png
│   ├── product-pricing-benchmark.png
│   ├── first-vs-repeat-purchases.png
│   ├── category-return-analysis.png
│   └── customer-health-by-country.png
├── data/
│   └── README.md
└── docs/
    ├── analysis-notes.md
    ├── cv-linkedin-copy.md
    └── upload-guide-id.md
```

## Credits

- Case study prompt: Digica Mini Bootcamp
- Dataset: Google BigQuery public dataset, `bigquery-public-data.thelook_ecommerce`
- Analysis and visualization: David Danny

