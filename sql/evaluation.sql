# 4 Model Evaluation

-- --------------------------------------------------
-- 1. Forecast 2017 using evaluation model
-- --------------------------------------------------

CREATE OR REPLACE TABLE
  `premium-origin-473803-v4.market_demand_analytics.sales_forecast_total_2017_v2` AS
SELECT
  *
FROM ML.FORECAST(
  MODEL `premium-origin-473803-v4.market_demand_analytics.sales_forecast_model_total_v2_eval`,
  STRUCT(12 AS horizon, 0.9 AS confidence_level),
  TABLE `premium-origin-473803-v4.market_demand_analytics.xreg_2017`
);


-- --------------------------------------------------
-- 2. Compare predicted vs actual (2017)
-- --------------------------------------------------

CREATE OR REPLACE TABLE
  `premium-origin-473803-v4.market_demand_analytics.total_2017_eval_v2` AS
SELECT
  a.year_month,
  a.total_sales                         AS actual_total_sales,
  f.forecast_value                      AS predicted_total_sales,
  ABS(a.total_sales - f.forecast_value) AS abs_error,
  SAFE_DIVIDE(
    ABS(a.total_sales - f.forecast_value),
    a.total_sales
  )                                     AS abs_pct_error
FROM
  `premium-origin-473803-v4.market_demand_analytics.sales_features_with_holiday` a
JOIN
  `premium-origin-473803-v4.market_demand_analytics.sales_forecast_total_2017_v2` f
ON
  a.year_month = DATE(f.forecast_timestamp)
WHERE
  EXTRACT(YEAR FROM a.year_month) = 2017
ORDER BY
  a.year_month;


-- --------------------------------------------------
-- 3. Evaluation Metrics
-- --------------------------------------------------

SELECT
  AVG(abs_error)                        AS MAE,
  SQRT(AVG(POW(abs_error, 2)))          AS RMSE,
  AVG(abs_pct_error)                   AS MAPE
FROM
  `premium-origin-473803-v4.market_demand_analytics.total_2017_eval_v2`;


# 5 Model Prediction

-- --------------------------------------------------
-- 4. Forecast 2018 using production model
-- --------------------------------------------------

CREATE OR REPLACE TABLE
  `premium-origin-473803-v4.market_demand_analytics.sales_forecast_total_2018_v2` AS
SELECT
  forecast_timestamp AS year_month,
  forecast_value     AS predicted_total_sales,
  prediction_interval_lower_bound,
  prediction_interval_upper_bound
FROM ML.FORECAST(
  MODEL `premium-origin-473803-v4.market_demand_analytics.sales_forecast_model_total_v2_prod`,
  STRUCT(12 AS horizon, 0.9 AS confidence_level),
  TABLE `premium-origin-473803-v4.market_demand_analytics.xreg_2018`
);
