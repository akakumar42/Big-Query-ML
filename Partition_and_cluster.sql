-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `kestra-bigq-project.kestra_gcp.external_green_tripdata`
OPTIONS (
  format = 'CSV',
  uris = ['gs://gcp-ny-taxi-bucket/green_tripdata_2019-*.csv']
);

-- Check yello trip data
SELECT * FROM kestra-bigq-project.kestra_gcp.external_green_tripdata limit 10;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE kestra-bigq-project.kestra_gcp.green_tripdata_non_partitioned AS
SELECT * FROM kestra-bigq-project.kestra_gcp.external_green_tripdata;


-- Create a partitioned table from external table
CREATE OR REPLACE TABLE kestra-bigq-project.kestra_gcp.green_tripdata_partitioned
PARTITION BY
  DATE(lpep_pickup_datetime) AS
SELECT * FROM kestra-bigq-project.kestra_gcp.external_green_tripdata;

-- Impact of partition
-- Scanning 1.6GB of data
SELECT DISTINCT(VendorID)
FROM kestra-bigq-project.kestra_gcp.green_tripdata_non_partitioned
WHERE DATE(lpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Scanning ~106 MB of DATA
SELECT DISTINCT(VendorID)
FROM  kestra-bigq-project.kestra_gcp.green_tripdata_partitioned
WHERE DATE(lpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Let's look into the partitions
SELECT table_name, partition_id, total_rows
FROM `kestra_gcp.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'green_tripdata_partitioned'
ORDER BY total_rows DESC;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE kestra-bigq-project.kestra_gcp.green_tripdata_partitioned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT * FROM kestra-bigq-project.kestra_gcp.external_green_tripdata;

-- Query scans 1.1 GB
SELECT count(*) as trips
FROM kestra-bigq-project.kestra_gcp.green_tripdata_partitioned
WHERE DATE(lpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;

-- Query scans 864.5 MB
SELECT count(*) as trips
FROM kestra-bigq-project.kestra_gcp.green_tripdata_partitioned_clustered
WHERE DATE(lpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;