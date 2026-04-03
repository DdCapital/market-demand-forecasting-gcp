# Market Demand Forecasting on Google Cloud (BigQuery ML)

## Overview
This project implements an end-to-end, cloud-native forecasting pipeline designed to address inventory volatility and supply chain challenges. By leveraging Google BigQuery and BigQuery ML, the system transforms historical sales data into actionable insights, capturing seasonality and regional patterns to support data-driven procurement and logistics decisions.

---

## Key Highlights

- **Scalable Architecture:** Built a fully integrated GCP pipeline (GCS → BigQuery → BigQuery ML → Looker Studio)
- **SQL-Driven Pipeline:** Designed an end-to-end data workflow using SQL for data transformation, feature engineering, model training, and evaluation within BigQuery
- **Advanced Modeling:** Leveraged ARIMA_PLUS_XREG with external holiday regressors and automated model selection
- **Robust Validation:** Developed a backtesting framework (2014–2016 Train / 2017 Test) to ensure model reliability before deployment
- **Granular Forecasting:** Built both aggregated and segmented models (by Region + Category) to capture diverse market behaviors
- **High Precision:** Achieved a MAPE of 1.68% on aggregated monthly sales data, demonstrating strong predictive performance for high-volume product categories

---

## Exploratory Data Analysis

Performed exploratory analysis on historical sales data to identify trends, seasonality, and regional variations. Identified strong Q4 demand spikes and region-specific consumption patterns, which informed feature engineering and model segmentation strategy.

---

## Technical Implementation (Core Responsibilities)

This project was completed as part of a group assignment. I designed and implemented the modeling and evaluation components of the pipeline, with a focus on scalability and reproducibility:

- **Feature Engineering & Enrichment:** Engineered temporal and derived features (monthly aggregations, growth rates) and integrated holiday indicators as external regressors
- **Predictive Modeling:** Developed and tuned ARIMA_PLUS_XREG models in BigQuery ML
- **SQL-Driven Data Pipeline:** Designed and implemented end-to-end data transformation and modeling workflows entirely in SQL, ensuring reproducible and scalable analytics within the data warehouse
- **Evaluation Framework:** Implemented a validation framework calculating MAE, RMSE, and MAPE across different segments
- **Business Intelligence:** Designed interactive Looker Studio dashboards to visualize "Actual vs. Predicted" trends and identify regional demand patterns

---

## Data Pipeline & Workflow

```mermaid
graph LR
    A[Raw Data / GCS] --> B[Data Cleaning & Standardization]
    B --> C[Feature Engineering & SQL Aggregation]
    C --> D[BigQuery ML: ARIMA_PLUS_XREG]
    D --> E[Backtesting & Performance Metrics]
    E --> F[Looker Studio Dashboards]
```

 ---

## Modeling Workflow

### 1. Data Processing
- Handled missing values and standardized schema for multi-region sales data
- Aggregated granular transaction data into monthly metrics for time-series stability

### 2. Modeling & Evaluation
- **Training Window:** 2014–2016 historical data
- **Testing Window:** 2017 (backtesting against actuals)
- **Forecast Horizon:** 12-month forward-looking projections for 2018

---

## Results & Business Insights

- **Accuracy:** Achieved a 1.68% MAPE on aggregated data, enabling more accurate inventory planning and reducing the risk of overstocking and stockouts
- **Seasonality:** Identified strong recurring demand patterns during Q4 holiday periods and regional promotional cycles

---

## Tech Stack

- **Cloud Platform:** Google Cloud Platform (GCP)
- **Data Warehouse:** BigQuery
- **Machine Learning:** BigQuery ML (SQL-based ML)
- **Visualization:** Looker Studio
- **Workflow:** SQL, Google Cloud Storage (GCS)

---

## Project Structure

```text
sql/          # SQL scripts for data cleaning, feature engineering, model training, and evaluation
dashboards/   # Looker Studio dashboards (links or screenshots)
data/         # Data schema documentation and source description
```

---

## Notes

This is a cloud-native project using BigQuery datasets
SQL scripts are organized in the sql/ directory for reproducibility
