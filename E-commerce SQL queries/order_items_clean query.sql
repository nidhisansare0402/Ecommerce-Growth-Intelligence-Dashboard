WITH order_items_clean AS (
  SELECT
    fullVisitorId AS customer_id,
    CONCAT(fullVisitorId, '-', visitId) AS session_id,
    hits.transaction.transactionId AS transaction_id,
    PARSE_DATE('%Y%m%d', date) AS transaction_date,

    product.v2ProductName AS product_name,
    product.v2ProductCategory AS product_category,
    product.productQuantity AS quantity,
    product.productRevenue / 1000000 AS product_revenue

  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201608*`,
  UNNEST(hits) AS hits,
  UNNEST(hits.product) AS product

  WHERE hits.transaction.transactionId IS NOT NULL
  AND product.productRevenue IS NOT NULL
)

SELECT * FROM order_items_clean;
