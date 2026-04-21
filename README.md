# Serverless Cyber Threat Intelligence Pipeline

## 🚀 Project Overview
This project demonstrates an end-to-end serverless data engineering pipeline designed to ingest, transform, and visualize global cyber threat intelligence. By leveraging AWS cloud-native services, the system converts raw network logs into actionable insights, identifying botnet density and high-intensity attack origins in real-time.


## 🛠️ Technical Stack
- **Cloud Provider:** AWS (S3, Glue, Athena)
- **Security Environment:** Kali Linux
- **Language:** Python (Boto3 SDK)
- **Data Engineering:** SQL (Athena Engine), Parquet Storage
- **Analytics & Visualization:** Power BI Desktop


## 🏗️ Architecture Flow
1. **Ingestion:** A Python-based automation script runs in Kali Linux to fetch malicious IP datasets and push them to an **Amazon S3** "Bronze" bucket.
2. **Cataloging:** **AWS Glue Crawlers** perform schema discovery and update the Data Catalog.
3. **Transformation:** **Amazon Athena** executes SQL queries (including IP-to-Integer conversion) to perform geospatial joins against Geo-IP datasets.
4. **Analysis:** **Power BI** connects via an ODBC/DSN bridge to render a SOC dashboard featuring global threat maps and scatter-plot anomaly detection.


## 📈 Key Visualizations
- **Global Threat Hotspots:** A map-based view of attack origins by volume.
- **Botnet Density Analysis:** A scatter plot correlating unique IPs vs. threat intensity to distinguish between distributed botnets and targeted attacks.
- **Pipeline Health Audit:** A gauge-based monitoring system for data enrichment success rates.

## 🔐 Security Note
All AWS Access Keys and sensitive credentials have been omitted. The pipeline utilizes IAM roles for secure cross-service communication.
