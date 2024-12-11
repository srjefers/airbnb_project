https://docs.liquibase.com/workflows/liquibase-community/using-liquibase-and-docker.html
https://docs.liquibase.com/start/tutorials/postgresql/postgresql.html

https://docs.docker.com/compose/install/
https://forum.liquibase.org/t/add-liquibase-with-docker-compose/6891
https://docs.liquibase.com/concepts/connections/creating-config-properties.html
https://github.com/ergulcu/poc-liquibase-docker/blob/master/docker-compose.liquibase.update.yml
https://hub.docker.com/r/liquibase/liquibase


https://docs.liquibase.com/commands/init/project.html


liquibase init project --project-dir=/Users/jefersonargueta/Documents/projects/LeanTech/section2 --changelog-file=changelog.xml --format=xml --project-defaults-file=liquibase.properties --url=jdbc:postgresql://localhost:5432/leantech_prjct_airbnb_db --username=postgres --password=root


liquibase status --username=postgres --password=root --changelog-file=./changelog.xml

liquibase update --changelog-file=./changelog.xml  

liquibase generate-changelog --changelog-file=./changelog.xml --url=jdbc:postgresql://localhost:5432/leantech_prjct_airbnb_db --username=root --password=root --schemas=sch_airbnb