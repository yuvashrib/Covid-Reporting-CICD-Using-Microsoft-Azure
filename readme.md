The COVID-19 pandemic needed a sophisticated data system to detect trends and anticipate viral propagation. Organizations and healthcare providers require COVID-19 data reporting that is accurate, timely, and consistent in order to make decisions and allocate resources effectively. Traditional data management approaches struggle to handle the amount, pace, and variety of pandemic data. Furthermore, they lack efficient, scalable systems for integrating several data sources and performing real-time analytics.

To solve these difficulties, this project intends to provide a cloud-based data engineering solution that uses Azure Data Factory (ADF) as the primary pipeline management tool, combining and converting data from many sources to enable data-driven insights. By leveraging Azure Storage, Databricks, HDInsight, and Power BI, this solution will produce daily updated reports and visualizations to assist in tracking COVID-19 trends.

Objectives:
- Data Ingestion & Integration - Consolidate COVID-19 data from sources like HTTP APIs, Azure Blob Storage, and Azure Data Lake Gen2 to manage historical and real-time data streams.
- Data Transformation & Processing - Design ADF pipelines for data cleaning and enrichment, implementing Mapping Data Flows for transformation logic (e.g., filtering, joining, aggregation) and using Databricks for advanced processing and HDInsight with Hive for batch tasks.
- Data Orchestration & Scheduling - Establish dependencies between pipelines and triggers to manage data flows, enabling real-time orchestration and monitoring.
- Data Storage & Access Control - Manage secure storage with Azure Data Lake Gen2 and Azure SQL Database, enforcing role-based access.
- Monitoring - Use Azure Monitor and Log Analytics for real-time pipeline monitoring and diagnostics.
- CI/CD Integration - Implement Azure DevOps pipelines for reliable development and deployment across environments.
