-- Same-month repeat purchase analysis
-- Measures short-term retention within a single-month dataset

WITH purchases AS (
  SELECT
    user_id,
    date_trunc('month', event_time) AS purchase_month,
    COUNT(*) AS purchase_count
  FROM ecommerce.events_clean
  WHERE event_type = 'purchase'
  GROUP BY user_id, date_trunc('month', event_time)
),

cohort_size AS (
  SELECT
    purchase_month,
    COUNT(DISTINCT user_id) AS total_users
  FROM purchases
  GROUP BY purchase_month
),

repeat_users AS (
  SELECT
    purchase_month,
    COUNT(DISTINCT user_id) AS repeat_users
  FROM purchases
  WHERE purchase_count > 1
  GROUP BY purchase_month
)

SELECT
  c.purchase_month AS cohort_month,
  c.total_users,
  COALESCE(r.repeat_users, 0) AS repeat_users,
  ROUND(
    COALESCE(r.repeat_users, 0)::numeric / c.total_users,
    4
  ) AS same_month_repeat_rate
FROM cohort_size c
LEFT JOIN repeat_users r
  ON c.purchase_month = r.purchase_month
ORDER BY cohort_month;
