Azure Churn & Revenue Optimization Project
📌 Overview

This project simulates an enterprise subscription business scenario where the objective is to reduce customer churn and maximize retention profitability using Azure-based data infrastructure, SQL optimization, statistical testing, and predictive modeling.

The project demonstrates end-to-end capabilities in:

Data Engineering (Azure SQL + ADF)

Data Modeling (Star Schema)

SQL Performance Optimization

A/B Testing & Hypothesis Testing

Churn Prediction Modeling

Business Profit Optimization

🎯 Business Problem

A subscription-based company is experiencing customer churn and needs to:

Identify churn drivers

Evaluate effectiveness of discount interventions

Optimize retention targeting strategy

Improve query performance for large datasets

Build scalable cloud-based analytics infrastructure

🏗️ Architecture

Azure SQL Database – Data warehouse layer

Azure Data Factory – ETL orchestration

Star Schema Design

Fact_SubscriptionRevenue

Dim_Customer

Dim_Contract

Foreign Key constraints for referential integrity

⚡ SQL Performance Optimization

Identified table scans via execution plans

Measured logical reads using SET STATISTICS IO

Created non-clustered indexes

Evaluated selectivity thresholds (~40% rule)

Reduced logical reads significantly in selective queries

🧪 A/B Testing

Designed randomized control vs treatment experiment

Null Hypothesis: Discount has no impact on churn

Conducted Chi-square test

Achieved statistically significant result (p < 0.001)

🤖 Churn Prediction Model

Logistic Regression model

ROC-AUC: 0.84

Key drivers:

Tenure (negative correlation)

Long-term contracts reduce churn

Higher monthly charges increase churn risk

💰 Profit Optimization

Built financial model:

Profit = 500,000(p − 0.5)

Where p = probability of retention success.

Translated statistical findings into executive-level decision framework.

📊 Key Skills Demonstrated

Azure Data Engineering

SQL Performance Tuning

Hypothesis Testing

Statistical Modeling

Business Decision Analytics

End-to-End Data Pipeline Design

🚀 Future Improvements

Uplift modeling implementation

Time-series forecasting for revenue

Deployment as Streamlit dashboard

⭐ Why This Project Matters

This project demonstrates the ability to combine cloud infrastructure, advanced SQL, statistical testing, and predictive modeling into a business-focused retention optimization framework — bridging data engineering and analytics for real-world decision-making.
