# 3 Model Training

-- --------------------------------------------------
-- 1. Production Model (used for final forecasting)
-- Trained on full historical data
-- --------------------------------------------------

CREATE OR REPLACE MODEL
  `premium-origin-473803-v4.market_demand_analytics.sales_forecast_model_total_v2_prod`
OPTIONS(
  MODEL_TYPE = 'ARIMA_PLUS_XREG',
  TIME_SERIES_TIMESTAMP_COL = 'year_month',
  TIME_SERIES_DATA_COL = 'total_sales',
  AUTO_ARIMA = TRUE,
  HOLIDAY_REGION = 'US'
)
AS
SELECT
  year_month,
  total_sales,
  CAST(is_holiday AS FLOAT64) AS is_holiday
FROM
  `premium-origin-473803-v4.market_demand_analytics.sales_features_with_holiday`
ORDER BY
  year_month;


-- --------------------------------------------------
-- 2. Evaluation Model (used for backtesting)
-- Trained on 2014–2016 data, used to predict 2017
-- --------------------------------------------------

CREATE OR REPLACE MODEL
  `premium-origin-473803-v4.market_demand_analytics.sales_forecast_model_total_v2_eval`
OPTIONS(
  MODEL_TYPE = 'ARIMA_PLUS_XREG',
  TIME_SERIES_TIMESTAMP_COL = 'year_month',
  TIME_SERIES_DATA_COL = 'total_sales',
  AUTO_ARIMA = TRUE,
  HOLIDAY_REGION = 'US'
)
AS
SELECT
  year_month,
  total_sales,
  CAST(is_holiday AS FLOAT64) AS is_holiday
FROM
  `premium-origin-473803-v4.market_demand_analytics.sales_features_with_holiday`
WHERE year_month < DATE('2017-01-01')   -- use 2014–2016 as training data
ORDER BY
  year_month;


-- --------------------------------------------------
-- 3. Segmented Model (region + category level forecasting)
-- --------------------------------------------------

CREATE OR REPLACE MODEL
  `premium-origin-473803-v4.market_demand_analytics.sales_forecast_model_seg_v2`
OPTIONS(
  MODEL_TYPE = 'ARIMA_PLUS_XREG',
  TIME_SERIES_TIMESTAMP_COL = 'year_month',
  TIME_SERIES_DATA_COL = 'total_sales',
  TIME_SERIES_ID_COL = 'series_id',
  AUTO_ARIMA = TRUE,
  HOLIDAY_REGION = 'US'
)
AS
SELECT
  year_month,
  total_sales,
  CONCAT(Region, ' | ', Category) AS series_id,
  CAST(is_holiday AS FLOAT64)     AS is_holiday
FROM
  `premium-origin-473803-v4.market_demand_analytics.sales_features_with_holiday`
ORDER BY
  year_month;
