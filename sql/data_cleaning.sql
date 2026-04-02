#1 Data Cleaning
  
-- Create a cleaned sales table for downstream analysis and forecasting
-- Removes invalid records and derives core time- and profitability-related fields

CREATE OR REPLACE TABLE `premium-origin-473803-v4.market_demand_analytics.cleaned_sales` AS
SELECT
  `Row ID`,
  `Order ID`,
  `Order Date`,
  `Ship Date`,
  DATE_DIFF(`Ship Date`, `Order Date`, DAY) AS shipping_days,
  EXTRACT(YEAR FROM `Order Date`) AS order_year,
  EXTRACT(MONTH FROM `Order Date`) AS order_month,
  EXTRACT(QUARTER FROM `Order Date`) AS order_quarter,
  `Ship Mode`,
  `Customer ID`,
  `Customer Name`,
  `Segment`,
  `Country`,
  `City`,
  `State`,
  `Postal Code`,
  `Region`,
  `Product ID`,
  `Category`,
  `Sub-Category`,
  `Product Name`,
  `Sales`,
  `Quantity`,
  `Discount`,
  `Profit`,
  SAFE_DIVIDE(`Profit`, NULLIF(`Sales`, 0)) AS profit_ratio
FROM `premium-origin-473803-v4.market_demand_analytics.superstore_sales`
WHERE `Sales` > 0
  AND `Profit` IS NOT NULL
  AND `Order Date` IS NOT NULL
  AND `Category` IS NOT NULL;
