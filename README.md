# SQL Customer Behavior Analysis

## Overview
This project analyzes user behavior data from an e-commerce platform using PostgreSQL.
The goal is to understand user conversion patterns and short-term retention behavior
based on event-level data.

## Dataset
- Source: E-commerce user events dataset
- Time range: November 2019 (single-month snapshot)
- Granularity: Event-level (view, cart, purchase)
- Size: ~67 million events

⚠️ Note: The dataset covers a single calendar month. As a result, retention analysis
reflects same-month repeat purchase behavior rather than cross-month retention.

## Data Pipeline
1. **Staging layer**
   - Raw CSV ingested with all fields as TEXT
   - No hard deletions applied to preserve original data

2. **Clean layer**
   - Data types normalized (timestamps, numerics, UUIDs)
   - Empty strings converted to NULL
   - Indexed for analytical performance

3. **Analysis layer**
   - Event-level funnel analysis
   - User-level funnel analysis
   - Same-month repeat purchase (early retention)

## Key Analyses

### Funnel Analysis
- View → Cart → Purchase conversion measured at:
  - Event level
  - User level
- Comparison highlights high browsing activity per user
  and stronger conversion when measured per unique user.

### Same-Month Retention
- Cohort defined as users making their first purchase in November 2019
- Retention measured as users making 2+ purchases within the same month
- Result:
  - ~38% of purchasing users made at least one additional purchase
    within the same month

This metric represents short-term repeat behavior rather than long-term loyalty.

## Data Quality Decisions
- Null values were normalized but not hard-deleted
- Duplicate-looking events were not blindly removed due to
  the event-level nature of the dataset
- All filtering was applied at analysis time to maintain data integrity

## How to Run
1. Run `sql/01_schema.sql`
2. Load data via `psql \copy`
3. Run `sql/02_clean_layer.sql`
4. Run analysis scripts:
   - `sql/03_funnel.sql`
   - `sql/04_cohort_retention.sql`

## Tools
- PostgreSQL
- SQL
- Git & GitHub
