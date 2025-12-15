CREATE SCHEMA IF NOT EXISTS ecommerce;

DROP TABLE IF EXISTS ecommerce.events_staging;

CREATE TABLE ecommerce.events_staging (
  event_time    TEXT,
  event_type    TEXT,
  product_id    TEXT,
  category_id   TEXT,
  category_code TEXT,
  brand         TEXT,
  price         TEXT,
  user_id       TEXT,
  user_session  TEXT
);
SELECT
    current_database() AS db,
    current_user AS usr;
    