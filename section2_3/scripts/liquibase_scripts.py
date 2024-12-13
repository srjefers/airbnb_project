import os
import subprocess
import argparse

def main(params: dict) -> None:
    """
        main -> Void
        @parms  dict    params provided by argparse
    """
    command = str(params.execute)
    docker_meta = {}
    if command == 'tag':
        docker_meta['liquibase'] = 'liquibase_tag'
        docker_meta['docker_file'] = 'docker-compose.liquibase.tag.yml'
    elif command == 'update':
        docker_meta['liquibase'] = 'liquibase_update'
        docker_meta['docker_file'] = 'docker-compose.liquibase.update.yml'
    elif command == 'rollback':
        docker_meta['liquibase'] = 'liquibase_rollback'
        docker_meta['docker_file'] = 'docker-compose.liquibase.rollback.yml'

    liquibase_command = os.environ.get(f'{docker_meta["liquibase"]}_up', f'docker-compose -f { docker_meta["docker_file"] } up')
    liquibase_down = os.environ.get(f'{docker_meta["liquibase"]}_down', f'docker-compose -f { docker_meta["docker_file"] } down')
    subprocess.run(['sh','-c',liquibase_command], check=True)
    subprocess.run(['sh','-c',liquibase_down], check=True)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Execute different liquibase commands')
    parser.add_argument('--execute', help='username for postgres')
    args = parser.parse_args()

    print('Execution starts --->>')
    main(args)