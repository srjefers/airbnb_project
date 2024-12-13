from datetime import datetime, timedelta
from airflow import DAG
from airflow.providers.amazon.aws.transfers.s3_to_local import S3ToLocalOperator
from airflow.operators.bash import BashOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    'airbnb_etl',
    default_args=default_args,
    description='ETL pipeline for Airbnb data',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2023, 1, 1),
    catchup=False,
)

# Task 1: Extract data from S3
extract_task = S3ToLocalOperator(
    task_id='extract_data_from_s3',
    bucket_name='your-s3-bucket-name',
    object_name='path/to/airbnb_data.csv',
    filename='/tmp/airbnb_data.csv',
    aws_conn_id='aws_default',
    dag=dag,
)

# Task 2: Transform data using a Python script
transform_task = BashOperator(
    task_id='transform_data',
    bash_command='python3 script.py --file_path=./data/AB_NYC_2019.csv --export_path=./data/transformed_airbnb_data.csv',
    dag=dag,
)

# Task 3: Load data into PostgreSQL
load_task = PostgresOperator(
    task_id='load_data_to_postgres',
    postgres_conn_id='postgres_default',
    sql="""
    COPY airbnb_listings(id,name,host_id,host_name,neighbourhood_group,neighbourhood,latitude,longitude,room_type,price,minimum_nights,number_of_reviews,last_review,reviews_per_month,calculated_host_listings_count,availability_365)
    FROM './data/transformed_airbnb_data.csv'
    DELIMITER ','
    CSV HEADER;
    """,
    dag=dag,
)

extract_task >> transform_task >> load_task
