WITH sessions_clean AS (
  SELECT
    fullVisitorId AS customer_id,
    CONCAT(fullVisitorId, '-', visitId) AS session_id,

    MIN(PARSE_DATE('%Y%m%d', date)) AS session_date,

    ANY_VALUE(trafficSource.source) AS source,
    ANY_VALUE(trafficSource.medium) AS medium,
    ANY_VALUE(trafficSource.campaign) AS campaign,
    ANY_VALUE(device.deviceCategory) AS deviceCategory,
    ANY_VALUE(geoNetwork.country) AS country,

    MAX(totals.visits) AS visits,
    MAX(totals.pageviews) AS pageviews,
    MAX(totals.bounces) AS bounces,
    MAX(totals.timeOnSite) AS timeOnSite

  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201608*`
  GROUP BY fullVisitorId, visitId
)

SELECT
  * REPLACE (CAST(customer_id AS STRING) AS customer_id)
FROM sessions_clean;


