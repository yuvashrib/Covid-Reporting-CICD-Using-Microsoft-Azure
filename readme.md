The COVID-19 pandemic needed a sophisticated data system to detect trends and anticipate viral propagation. Organizations and healthcare providers require COVID-19 data reporting that is accurate, timely, and consistent in order to make decisions and allocate resources effectively. Traditional data management approaches struggle to handle the amount, pace, and variety of pandemic data. Furthermore, they lack efficient, scalable systems for integrating several data sources and performing real-time analytics.

This project, guided by the Udemy course Real-World Project for Data Engineers using Azure Data Factory, SQL, Data Lake, Databricks, HDInsight, CI/CD [DP203] by Ramesh Retnasamy, aims to develop a scalable, cloud-based data engineering solution to track and predict COVID-19 trends. Using Azure Data Factory (ADF) as the primary orchestration tool, it integrates and processes pandemic data from multiple sources, enabling timely insights for healthcare organizations and policymakers.

Objectives:
- Data Ingestion & Integration - Consolidate COVID-19 data from sources like HTTP APIs, Azure Blob Storage, and Azure Data Lake Gen2 to manage historical and real-time data streams.
- Data Transformation & Processing - Design ADF pipelines for data cleaning and enrichment, implementing Mapping Data Flows for transformation logic (e.g., filtering, joining, aggregation) and using Databricks for advanced processing and HDInsight with Hive for batch tasks.
- Data Orchestration & Scheduling - Establish dependencies between pipelines and triggers to manage data flows, enabling real-time orchestration and monitoring.
- Data Storage & Access Control - Manage secure storage with Azure Data Lake Gen2 and Azure SQL Database, enforcing role-based access.
- Monitoring - Use Azure Monitor and Log Analytics for real-time pipeline monitoring and diagnostics.
- CI/CD Integration - Implement Azure DevOps pipelines for reliable development and deployment across environments.
