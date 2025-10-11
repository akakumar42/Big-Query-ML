
# Big-Query-ML

## Overview
This project demonstrates how to use Google BigQuery for large-scale data processing, partitioning, clustering, and building machine learning models directly within BigQuery SQL. The focus is on New York City taxi trip data, with workflows for efficient data storage and predictive modeling of taxi tips.

## Project Structure

- `Partition_and_cluster.sql`: SQL scripts for creating external tables from Google Cloud Storage, partitioning and clustering data tables, and demonstrating the impact of these optimizations on query performance.
- `Tip_prediction_model.sql`: SQL scripts for feature selection, data preparation, model creation (linear regression for tip prediction), model evaluation, prediction, feature explanation, and hyperparameter tuning using BigQuery ML.

## Workflow

1. **Data Ingestion & Preparation**
	- Create external tables referencing raw CSV data in Google Cloud Storage.
	- Load data into BigQuery tables, applying partitioning (by pickup date) and clustering (by VendorID) to optimize query performance and reduce costs.

2. **Partitioning & Clustering**
	- Compare query performance and scanned data size between non-partitioned, partitioned, and partitioned-clustered tables.
	- Use `Partition_and_cluster.sql` to create and analyze these tables.

3. **Machine Learning Model**
	- Select relevant features and prepare a clean ML-ready table.
	- Build a linear regression model to predict taxi tip amounts using BigQuery ML.
	- Evaluate model performance, inspect feature importance, and perform predictions.
	- Tune hyperparameters for improved model accuracy.
	- All steps are available in `Tip_prediction_model.sql`.

## Usage

1. Open the SQL scripts in the BigQuery Console or your preferred SQL editor.
2. Execute the statements in order, starting with data ingestion and preparation, followed by partitioning/clustering, and finally the ML workflow.
3. Adjust dataset and table names as needed for your GCP project.

## Requirements

- Google Cloud Platform account with BigQuery and Cloud Storage access
- NYC taxi trip data in a GCS bucket (update URIs as needed)

## License

This project is provided for educational purposes. Please review and update the license as appropriate for your use case.
