
# Section 5: Comprehensive Case Study 
## Summary
### Case Study: Data Pipeline Migration
* Scenario: Your company plans to migrate its data pipeline from an on-premises
PostgreSQL database to Snowflake. The current pipeline processes daily Airbnb
booking data and uses Python scripts for ETL operations.
#### Tasks:
1. Propose a new architecture leveraging Snowflake and Airflow for orchestrating the ETL
processes.
2. Identify potential challenges in the migration and suggest mitigation strategies.
3. Provide a Python script example that utilizes the Snowflake Connector to load data into Snowflake.
#### Deliverables:
1. Architecture diagram and explanatory notes.
2. Python script for data loading into Snowflake.

## Solution
### Architecture Diagram
<p align="center">
    <img width="700" alt="Architecture" src="https://github.com/srjefers/airbnb_project/blob/master/section5/Architecture_diagram.jpeg?raw=true">
</p>

### Explanatory Notes
#### Data Ingestion
To ingest data and to get data into the aws S3 data lake we are going to use a python script, since we are using AWS for storage, it would be perfect if we can also have it for serverless compute, such like storing the python script into an aws ecr and creating an ecs fargate task to run the process as serverless.

Also to run it we can use airflow or aws mwaa to orchestrate the first steps of our pipeline.

#### Data Loading
We are going to load the data into Snowflake with the aws sqs and the snowflake storage integration object, that is going to be connected to aws s3, soon as a file is going to be uploaded it is going to detect and is going to be able for us to read it from snowflake. Also we are going to have a snowpipe that is going to orchestrate a copy command between the external table that was loaded with the snowflake storage integration, the snowpipe is going to COPY the data into the bronze layer.

#### Data Cleaning
Soon as the last step was run and the bronze layer table as loaded, we are going to detect the changes with an stream object, that is going to trigger a task, the task is going to have the `when system$stream_has_data('stream_name_object')`, that is going to detect changes and is going to run a store procedure.

The store procedure is going to have a sql script that is going to read data from the bronze layer into the silver layer tables.

#### Warehouse architecture?
We want to implement an ELT medallin warehouse architecture.

#### Why views and not table for Gold layer?
The gold layer is going to be full fill of views, we can have tables if we need, but most of them are going to be views, since the data in the silver layer is going to be changing, we are going to save storage cost by just using views.

### Requirements
```bash
pip install -r requirements.txt
python3 script.py --file_path=./data/AB_NYC_2019.csv 
```

## References
* https://aws.amazon.com/es/compare/the-difference-between-etl-and-elt/
* https://www.databricks.com/glossary/medallion-architecture
* https://docs.snowflake.com/en/developer-guide/python-connector/python-connector-connect