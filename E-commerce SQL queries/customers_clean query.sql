WITH customers_clean AS (
SELECT
  fullVisitorId AS customer_id,
  MIN(PARSE_DATE('%Y%m%d', date)) AS first_visit_date,
  COUNT(DISTINCT visitId) AS total_sessions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201608*`
GROUP BY fullVisitorId
)
SELECT *
FROM customers_clean;