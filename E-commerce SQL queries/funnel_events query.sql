WITH funnel_events AS (
  SELECT
    fullVisitorId AS customer_id,
    CONCAT(fullVisitorId, '-', visitId) AS session_id,
    trafficSource.source,
    trafficSource.medium,

    MAX(CASE
          WHEN product.v2ProductName IS NOT NULL THEN 1
          ELSE 0
        END) AS product_view_flag,

    MAX(CASE 
          WHEN LOWER(hits.eventInfo.eventAction) = 'add to cart'
          THEN 1 ELSE 0 
        END) AS add_to_cart_flag,

    MAX(CASE
          WHEN hits.transaction.transactionId IS NOT NULL THEN 1
          ELSE 0
        END) AS purchase_flag

  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201608*`,
  UNNEST(hits) AS hits
  LEFT JOIN UNNEST(hits.product) AS product

  GROUP BY fullVisitorId, visitId, trafficSource.source, trafficSource.medium
)

SELECT * FROM funnel_events;
