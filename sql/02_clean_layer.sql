-- Clean (typed) layer derived from staging (TEXT)

CREATE OR REPLACE VIEW ecommerce.vw_events_clean AS
SELECT
  to_timestamp(replace(event_time, ' UTC', ''), 'YYYY-MM-DD HH24:MI:SS') AS event_time,
  nullif(event_type, '') AS event_type,
  nullif(product_id, '')::bigint AS product_id,
  nullif(category_id, '')::bigint AS category_id,
  nullif(category_code, '') AS category_code,
  nullif(brand, '') AS brand,
  nullif(price, '')::numeric(10,2) AS price,
  nullif(user_id, '')::bigint AS user_id,
  nullif(user_session, '')::uuid AS user_session
FROM ecommerce.events_staging;

DROP TABLE IF EXISTS ecommerce.events_clean;

CREATE TABLE ecommerce.events_clean AS
SELECT *
FROM ecommerce.vw_events_clean;

CREATE INDEX IF NOT EXISTS idx_ec_event_time  ON ecommerce.events_clean(event_time);
CREATE INDEX IF NOT EXISTS idx_ec_user_id     ON ecommerce.events_clean(user_id);
CREATE INDEX IF NOT EXISTS idx_ec_event_type  ON ecommerce.events_clean(event_type);
CREATE INDEX IF NOT EXISTS idx_ec_session     ON ecommerce.events_clean(user_session);

ANALYZE ecommerce.events_clean;
