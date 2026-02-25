WITH orders_clean AS (
  SELECT
    o.fullVisitorId AS customer_id,
    CONCAT(o.fullVisitorId, '-', o.visitId) AS session_id,
    o.transaction_id,
    o.transaction_date,
    o.revenue,

    CASE
      WHEN LOWER(o.medium) IN ('cpc','ppc') THEN 'Paid Search'
      WHEN LOWER(o.source) LIKE '%facebook%'
        OR LOWER(o.source) LIKE '%instagram%' THEN 'Paid Social'
      WHEN LOWER(o.medium) = 'organic' THEN 'Organic Search'
      WHEN o.source = '(direct)' AND o.medium = '(none)' THEN 'Direct'
      WHEN LOWER(o.medium) = 'referral' THEN 'Referral'
      WHEN LOWER(o.medium) = 'email' THEN 'Email'
      ELSE 'Other'
    END AS marketing_channel,

    CASE
      WHEN s.visitNumber = 1 THEN 'New'
      ELSE 'Returning'
    END AS customer_type

  FROM (
    SELECT
      fullVisitorId,
      visitId,
      hits.transaction.transactionId AS transaction_id,
      PARSE_DATE('%Y%m%d', date) AS transaction_date,
      MAX(totals.totalTransactionRevenue) / 1000000 AS revenue,
      ANY_VALUE(trafficSource.source) AS source,
      ANY_VALUE(trafficSource.medium) AS medium
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201608*`,
    UNNEST(hits) AS hits
    WHERE hits.transaction.transactionId IS NOT NULL
    GROUP BY fullVisitorId, visitId, transaction_id, transaction_date
  ) o

  JOIN (
    SELECT
      fullVisitorId,
      visitId,
      ANY_VALUE(visitNumber) AS visitNumber
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201608*`
    GROUP BY fullVisitorId, visitId
  ) s
  ON o.fullVisitorId = s.fullVisitorId
  AND o.visitId = s.visitId
)
SELECT * FROM orders_clean;