# Dataset Access

This project uses Google's public TheLook Ecommerce dataset in BigQuery:

```text
bigquery-public-data.thelook_ecommerce
```

The raw dataset is not copied into this repository. The SQL files query the public tables directly.

## Main Tables

- `users`
- `orders`
- `order_items`
- `products`

## How to Run the Queries

1. Open the Google Cloud Console and go to BigQuery Studio.
2. Create or select a Google Cloud project with BigQuery access.
3. Open any file in the repository's `sql/` directory.
4. Copy the query into the BigQuery editor.
5. Ensure the query uses GoogleSQL, then select **Run**.

The public dataset may be updated over time, so results can differ from the screenshots captured for the original case-study submission.

