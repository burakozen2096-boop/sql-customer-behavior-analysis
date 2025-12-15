-- Quick sanity checks (run anytime)

SELECT current_database() AS db, current_user AS usr;

-- Is schema/table present?
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'ecommerce'
ORDER BY table_name;

-- Row counts
SELECT COUNT(*) AS staging_rows FROM ecommerce.events_staging;
SELECT COUNT(*) AS clean_rows   FROM ecommerce.events_clean;

-- Time range
SELECT MIN(event_time) AS min_time, MAX(event_time) AS max_time
FROM ecommerce.events_clean;

-- Event type distribution (funnel basis)
SELECT event_type, COUNT(*) 
FROM ecommerce.events_clean
GROUP BY 1
ORDER BY 2 DESC;

-- Null checks on key fields
SELECT
  COUNT(*) AS total,
  COUNT(*) FILTER (WHERE event_time IS NULL) AS null_event_time,
  COUNT(*) FILTER (WHERE user_id IS NULL) AS null_user_id,
  COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product_id
FROM ecommerce.events_clean;
