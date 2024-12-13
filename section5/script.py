import snowflake.connector
import argparse

SNOWFLAKE_ACCOUNT = "account.snowflakecomputing.com"
SNOWFLAKE_USER = "srv_python"
SNOWFLAKE_PASSWORD = "root"
SNOWFLAKE_DATABASE = "db_airbnb"
SNOWFLAKE_SCHEMA = "sch_airbnb"
SNOWFLAKE_WAREHOUSE = "warehouse_medium"
SNOWFLAKE_TABLE = "tbl_airbnb"

def load_data_to_snowflake(file_path: str, table_name: str) -> None:
    """
        load_data_to_snowflake -> None
        @file_path  str
        @table_name str
    """
    conn = snowflake.connector.connect(
        account=SNOWFLAKE_ACCOUNT,
        user=SNOWFLAKE_USER,
        password=SNOWFLAKE_PASSWORD,
        warehouse=SNOWFLAKE_WAREHOUSE,
        database=SNOWFLAKE_DATABASE,
        schema=SNOWFLAKE_SCHEMA
    )
    try:
        cursor = conn.cursor()
        cursor.execute(f"PUT {file_path} @%{table_name}")
        cursor.execute(f"COPY INTO {table_name} FROM @%{table_name} FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='\"' SKIP_HEADER=0)")

    except Exception as e:
        print(f"Error loading data: {e}")
    finally:
        cursor.close()
        conn.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Read, clean and export.')

    parser.add_argument('--file_path', help='File path')
    args = parser.parse_args()
    file_path = args.file_path

    load_data_to_snowflake(file_path, SNOWFLAKE_TABLE)



