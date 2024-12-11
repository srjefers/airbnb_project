import os
import json
import subprocess

def main():
    dbt_command = os.environ.get('dbt_command', 'dbt run --select silver && dbt run --select gold')
    subprocess.run(['sh','-c',dbt_command], check=True)

if __name__ == '__main__':
    print('Execution starts --->>')
    main()