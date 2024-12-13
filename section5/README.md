
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

### Requirements
```bash
pip install -r requirements.txt
python3 script.py --file_path=./data/AB_NYC_2019.csv 
```

## References
* https://docs.snowflake.com/en/developer-guide/python-connector/python-connector-connect