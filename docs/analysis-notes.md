# Analysis Notes and Metric Definitions

This document records the decisions used to convert the completed mini-bootcamp assignment into a portfolio-ready project.

## Portfolio Hardening

The submitted analysis was retained as the source of the business questions, query logic, and displayed findings. The repository version adds several production-style clarifications:

1. **Category ranking follows the stated objective.** The top-five query is sorted by sales, not by the number of order-item rows.
2. **Pricing language is more precise.** A category average is an internal benchmark; it does not prove that a product is overpriced relative to competitors or the market.
3. **Returned orders use a distinct count.** This avoids counting multiple returned line items from the same order as multiple orders.
4. **Users with no orders remain in customer-health analysis.** A left join from users to orders keeps registered users who have never purchased.
5. **The status label matches the case definition.** The 90+ day group is called `churned`, while the original visualization used `inactive`.
6. **Division is protected with `SAFE_DIVIDE`.** This makes rate calculations more robust to zero denominators.
7. **Ties in order sequence are deterministic.** `order_id` is added as a secondary sort key after order date.

## Metric Definitions

| Metric | Definition |
|---|---|
| Sales | Sum of `order_items.sale_price` |
| Unique buyers | Distinct `user_id` values in order items |
| Orders | Distinct `order_id`, except the category query where the assignment explicitly asks for order lines |
| AOV | Sales divided by distinct order count |
| Average category price | Average product `retail_price` within category |
| Price delta | Product retail price minus average category price |
| Returned orders | Distinct returned `order_id` values |
| Returned sales rate | Returned sales divided by total category sales |
| Active | Purchased within the last 30 days |
| Warm | Purchased 31-90 days ago |
| Churned | Last purchase was over 90 days ago, or no purchase is recorded |

## Interpretation Guardrails

- The monthly trend does not by itself prove that order frequency increased. Add `orders / unique_buyers` before making that claim.
- High sales do not necessarily mean high profit. Category decisions should include product cost, margin, inventory, and returns.
- A large price delta can reflect a premium product, data-quality issue, pack size, or category heterogeneity. It is a review flag, not a pricing verdict.
- First-purchase share should not be used alone to choose acquisition over retention. Compare AOV, revenue, customer lifetime value, and channel cost.
- Return rate identifies where to investigate, not the root cause. A SKU-, size-, brand-, supplier-, and reason-level analysis is required.
- Country percentages should be read alongside absolute user counts; small markets can produce extreme percentages.
- The BigQuery public dataset is dynamic. Use a fixed analysis date or export result tables if exact reproduction of a historical snapshot is required.

