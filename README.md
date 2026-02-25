# E-commerce Growth Intelligence Dashboard
**End-to-End E-commerce Analytics Solution using BigQuery & Power BI**

## Project Overview
This project analyzes the Google Analytics E-commerce Sample Dataset (~74K sessions, ~30K transactions) to uncover actionable insights across:
- Revenue performance
- Marketing channel effectiveness
- Customer retention behavior
- Conversion funnel leakage
- Product and category contribution
The objective was to simulate a real-world analytics workflow — from raw event-level data to business-ready dashboards — using production-style modeling practices.

## Business Objectives
- Analyze revenue trends
- Evaluate marketing channel performance
- Measure customer retention
- Identify funnel drop-offs
- Evaluate product contribution

## Dataset Details
Source: Google Analytics Public Dataset  
Dataset Used: `bigquery-public-data.google_analytics_sample.ga_sessions_201608*`  
Period: August 2016  

## Key Characteristics:
- 74K+ sessions
- 30K+ transactions
- Nested hit-level event structure
- Partitioned wildcard tables

## Tools & Technologies

- **SQL (BigQuery)** – Data extraction, transformation, aggregation
- **Power BI** – Data modeling, DAX measures, dashboard design
- **DAX** – KPI calculations & analytical metrics
- **Data Modeling** – Star schema with fact & dimension logic

## Data Modeling Approach
The raw dataset contained nested and partitioned session data.

Steps performed:

1. Flattened nested hit-level structure using `UNNEST()`
2. Created composite session keys to prevent wildcard duplication
3. Built clean analytical tables:

   - `sessions_clean`
   - `orders_clean`
   - `order_items_clean`
   - `funnel_events`

4. Designed relationships in Power BI:
   - Sessions → Orders → Order Items
   - Sessions → Funnel Events

Model Type: Star Schema (Fact + Dimensions)

# Dashboard Structure (4 Pages)

## Page 1 – Executive Overview

**Objective:** High-level business summary

KPIs:
- Total Revenue
- Total Orders
- Average Order Value (AOV)
- Returning Order %

Visuals:
- Revenue Trend Over Time
- Revenue by Marketing Channel
- Orders by Channel
- Conversion Rate
- Cart Drop-Off %

<img width="1432" height="812" alt="image" src="https://github.com/user-attachments/assets/98607480-133f-4d93-ae82-b1997c0a8952" />

## Page 2 – Marketing & Funnel Performance

**Objective:** Evaluate channel efficiency

Key Questions:
- Which channels drive revenue?
- Which channels convert efficiently?
- Where is funnel drop-off happening?

Visuals:
- Revenue by Channel
- AOV by Channel
- New vs Returning Split by Channel
- Funnel Stages (Sessions → Views → Add to Cart → Purchase)
- Conversion & Drop-Off KPIs

<img width="1439" height="804" alt="image" src="https://github.com/user-attachments/assets/27e2b671-286a-4ba6-b11c-70e884a3ada0" />

## Page 3 – Sales & Customer Insights

**Objective:** Analyze customer behavior

Key Questions:
- Are returning customers driving revenue?
- Who are the top customers?
- Are sales trends consistent?

Visuals:
- Revenue by Customer Type
- Top 10 Customers by Revenue
- Orders Trend
- Revenue Trend

<img width="1439" height="799" alt="image" src="https://github.com/user-attachments/assets/f162122b-f392-4cba-84da-05459a2c274a" />

## Page 4 – Product Performance Analysis

**Objective:** Identify revenue-driving SKUs

Note: Product categories were mostly "(not set)" in source data.  
Therefore, analysis was shifted to SKU-level performance.

KPIs:
- Total Product Revenue
- Total Quantity Sold
- Distinct Products
- Avg Revenue per Product

Visuals:
- Top 10 Products by Revenue
- Top 10 Products by Quantity
- Revenue Share Distribution (Top 10)

<img width="1432" height="798" alt="image" src="https://github.com/user-attachments/assets/0cf03301-ed26-4354-bdeb-ac93aa9e4b3d" />

# Challenges Faced
1️. Wildcard Partition Duplication

Using ga_sessions_201608* caused duplicate session IDs.
✔ Solved using composite session keys and proper GROUP BY logic.

2️. Ambiguous Relationships in Power BI

Multiple fact tables caused relationship conflicts.
✔ Fixed by restructuring relationships and enforcing 1-to-many joins.

3️. Scientific Notation in Customer IDs

Large numeric identifiers were converted to scientific notation during CSV export.
✔ Casted identifiers to STRING in BigQuery 

4️. Funnel Aggregation Issues

Add-to-cart values initially appeared as zero.
✔ Rebuilt funnel logic using proper event flags and session-level aggregation.

## Key KPIs Developed
- Total Revenue
- Total Orders
- Average Order Value (AOV)
- Returning Customer %
- Conversion Rate
- Cart Drop-off %
- Revenue by Channel
- Revenue by Category
- Top Product Contribution
All KPIs were built using DAX with null-safe logic.

## Key Business Insights
- ~63% of revenue driven by returning customers, highlighting strong retention.
- Direct channel contributes highest revenue, but Paid channels show higher AOV potential.
- Significant drop-off between product view and add-to-cart suggests optimization opportunity (~15–20% potential revenue uplift).
- Top 20% products contribute disproportionately to total revenue
