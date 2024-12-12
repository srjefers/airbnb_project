```bash
docker-compose up -d
docker-compose -f docker-compose.liquibase.tag.yml up
docker-compose -f docker-compose.liquibase.update.yml up
docker-compose -f docker-compose.liquibase.rollback.yml up

```


https://docs.liquibase.com/workflows/liquibase-community/using-liquibase-and-docker.html
https://docs.liquibase.com/start/tutorials/postgresql/postgresql.html

https://docs.docker.com/compose/install/
https://forum.liquibase.org/t/add-liquibase-with-docker-compose/6891
https://docs.liquibase.com/concepts/connections/creating-config-properties.html
https://github.com/ergulcu/poc-liquibase-docker/blob/master/docker-compose.liquibase.update.yml
https://hub.docker.com/r/liquibase/liquibase


https://docs.liquibase.com/commands/init/project.html


https://docs.liquibase.com/commands/inspection/generate-changelog.html
https://docs.liquibase.com/workflows/liquibase-community/using-jdbc-url-in-liquibase.html
https://docs.liquibase.com/start/tutorials/postgresql/postgresql.html#xml_example


https://docs.liquibase.com/workflows/liquibase-community/diffing-multiple-schemas-in-liquibase.html

## Referenes
* https://github.com/dbt-labs/dbt-core/pkgs/container/dbt-postgres
* https://docs.getdbt.com/docs/core/pip-install

https://docs.liquibase.com/change-types/enddelimiter-sql.html#xml_example
https://docs.liquibase.com/commands/update/update.html
https://docs.liquibase.com/commands/utility/tag.html