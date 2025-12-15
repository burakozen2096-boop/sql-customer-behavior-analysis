-- Funnel analysis: event-level vs user-level
-- View -> Cart -> Purchase

WITH event_funnel AS (
  SELECT
    COUNT(*) FILTER (WHERE event_type = 'view')     AS views,
    COUNT(*) FILTER (WHERE event_type = 'cart')     AS carts,
    COUNT(*) FILTER (WHERE event_type = 'purchase') AS purchases
  FROM ecommerce.events_clean
),
user_funnel AS (
  SELECT
    COUNT(DISTINCT user_id) FILTER (WHERE event_type = 'view')     AS view_users,
    COUNT(DISTINCT user_id) FILTER (WHERE event_type = 'cart')     AS cart_users,
    COUNT(DISTINCT user_id) FILTER (WHERE event_type = 'purchase') AS purchase_users
  FROM ecommerce.events_clean
)
SELECT
  -- event-level
  views,
  carts,
  purchases,
  ROUND(carts::numeric / NULLIF(views, 0), 4)     AS event_view_to_cart_rate,
  ROUND(purchases::numeric / NULLIF(carts, 0), 4) AS event_cart_to_purchase_rate,
  ROUND(purchases::numeric / NULLIF(views, 0), 4) AS event_view_to_purchase_rate,

  -- user-level
  view_users,
  cart_users,
  purchase_users,
  ROUND(cart_users::numeric / NULLIF(view_users, 0), 4)     AS user_view_to_cart_rate,
  ROUND(purchase_users::numeric / NULLIF(cart_users, 0), 4) AS user_cart_to_purchase_rate,
  ROUND(purchase_users::numeric / NULLIF(view_users, 0), 4) AS user_view_to_purchase_rate
FROM event_funnel, user_funnel;
