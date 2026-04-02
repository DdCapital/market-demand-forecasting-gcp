# Market Demand Forecasting on Google Cloud (BigQuery ML)

## Overview
This project builds a cloud-based data analytics and forecasting pipeline using Google BigQuery and BigQuery ML to analyze historical sales data and predict future demand.

The goal is to support data-driven decision-making by identifying sales trends, seasonality, and regional patterns.

---
## My Contribution

This project was completed as part of a group assignment.

My primary contributions focused on the modeling and forecasting stages:

- Performed feature engineering for time series modeling, including date-based and additional derived features
- Developed forecasting models using BigQuery ML (ARIMA and ARIMA_PLUS_XREG)
- Enhanced the baseline model by incorporating additional features to improve predictive performance
- Built SQL queries for model training, evaluation, and prediction
- Created visualizations to compare forecasted results with actual values and analyze model performance

Other team member contributions included historical data preparation， initial visualization.

## Tech Stack
- **Cloud Platform**: Google Cloud Platform (GCP)
- **Data Warehouse**: BigQuery
- **Modeling**: BigQuery ML
- **Language**: SQL
- **Visualization**: Looker Studio

---

## Workflow

### 1. Data Validation
- Checked missing values, anomalies, and distribution
- Ensured data consistency before modeling

### 2. Data Cleaning
- Normalized and transformed raw data
- Handled inconsistent formats

### 3. Exploratory Analysis
- Monthly sales trends
- Regional and category-level analysis

### 4. Feature Engineering
- Time-based features (month, year)
- Holiday indicators
- Aggregated sales metrics

### 5. Modeling
- Built ARIMA and ARIMA_PLUS_XREG models in BigQuery ML
- Performed segmented forecasting by region and category

### 6. Evaluation
- Compared actual vs predicted values
- Used MAPE to evaluate model performance

### 7. Forecasting
- Generated 12-month future demand predictions

---

## Key Insights
- Sales show strong seasonal patterns across regions
- Holiday periods significantly impact demand
- Segmented models improve forecasting accuracy compared to overall models

---

## Notes
- This is a cloud-based project using BigQuery datasets
- SQL scripts are organized for reproducibility
