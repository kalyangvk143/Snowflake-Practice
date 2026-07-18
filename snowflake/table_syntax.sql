-- Snowflake table syntax examples
-- File: snowflake/table_syntax.sql

-- 1) Permanent table (default)
CREATE TABLE IF NOT EXISTS snowflake_practice.public.permanent_table (
  id INTEGER AUTOINCREMENT,
  name STRING,
  created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP
);

-- Set Time Travel (data retention) for a permanent table (days)
-- Default allowance depends on account; this sets the retention window for Time Travel
ALTER TABLE snowflake_practice.public.permanent_table
  SET DATA_RETENTION_TIME_IN_DAYS = 7;


-- 2) Transient table (no Fail-safe, lower storage cost)
CREATE TRANSIENT TABLE IF NOT EXISTS snowflake_practice.public.transient_table (
  id INTEGER,
  payload VARIANT,
  loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP
);

-- 3) Temporary table (session-scoped)
-- Exists only for the duration of the session that created it
CREATE TEMPORARY TABLE temp_session_table (
  key STRING,
  value STRING
);


-- 4) External table (references data in an external stage)
-- Pre-requisite: a named stage (e.g., @my_stage) and a FILE FORMAT (e.g., MY_CSV_FORMAT)
-- Example file format (create once):
-- CREATE FILE FORMAT my_csv_format TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1;

CREATE EXTERNAL TABLE IF NOT EXISTS ext_db.public.sales_external (
  sale_id INTEGER,
  amount FLOAT,
  sale_date DATE
)
WITH LOCATION = @my_stage/sales/
FILE_FORMAT = (FORMAT_NAME = 'MY_CSV_FORMAT');


-- 5) Zero-copy clone (logical snapshot)
-- Creates a lightweight copy that shares storage with the source until modified
CREATE TABLE dev.public.permanent_table_clone CLONE snowflake_practice.public.permanent_table;


-- 6) Materialized view (pre-computed results)
-- Note: materialized views are not base tables; they store results of a query to speed reads
CREATE MATERIALIZED VIEW IF NOT EXISTS analytics.public.sales_summary_mv AS
SELECT
  DATE_TRUNC('day', sale_date) AS day,
  COUNT(*) AS total_sales,
  SUM(amount) AS total_amount
FROM snowflake_practice.public.permanent_table
GROUP BY DATE_TRUNC('day', sale_date);

-- Refresh behavior: Snowflake incrementally maintains MVs automatically, but consider compute and storage cost.

-- Notes:
-- - Replace database/schema names (e.g., snowflake_practice.public) with your target DB and schema.
-- - Temporary tables are session-scoped and dropped automatically at session end.
-- - Transient tables support Time Travel but not Fail-safe.
-- - External tables only hold metadata in Snowflake; the data remains in external storage (stage).
-- - CLONE creates a zero-copy snapshot; the clone diverges only on writes.
