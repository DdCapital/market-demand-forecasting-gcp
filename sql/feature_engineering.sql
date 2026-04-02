#2 Feature engineering

-- Aggregate cleaned sales data into monthly features by region and category
-- Used as input for segmented forecasting and performance analysis

CREATE OR REPLACE TABLE `premium-origin-473803-v4.market_demand_analytics.sales_features` AS
SELECT
  Region,
  Category,
  EXTRACT(YEAR FROM `Order Date`) AS order_year,
  EXTRACT(MONTH FROM `Order Date`) AS order_month,
  DATE(EXTRACT(YEAR FROM `Order Date`), EXTRACT(MONTH FROM `Order Date`), 1) AS year_month,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  SAFE_DIVIDE(SUM(Profit), SUM(Sales)) * 100 AS profit_margin_percent,
  ROUND(AVG(Sales), 2) AS avg_sales_per_order,
  ROUND(AVG(Quantity), 2) AS avg_quantity_per_order,
  COUNT(DISTINCT `Customer ID`) AS unique_customers,
  COUNT(DISTINCT `Product ID`) AS unique_products
FROM `premium-origin-473803-v4.market_demand_analytics.cleaned_sales`
GROUP BY Region, Category, order_year, order_month, year_month
ORDER BY order_year, order_month;

--
CREATE OR REPLACE TABLE
  `premium-origin-473803-v4.market_demand_analytics.sales_features_with_holiday` AS
SELECT
  f.*,
  IF(h.holiday_date IS NOT NULL, 1, 0) AS is_holiday
FROM
  `premium-origin-473803-v4.market_demand_analytics.sales_features` f
LEFT JOIN
  `premium-origin-473803-v4.market_demand_analytics.holidays` h
ON
  DATE_TRUNC(f.year_month, MONTH) = DATE_TRUNC(h.holiday_date, MONTH)
ORDER BY
  f.year_month;
