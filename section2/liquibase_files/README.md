# Liquibase commands to run localy

```bash
liquibase init project --project-dir=/Users/jefersonargueta/Documents/projects/LeanTech/section2 --changelog-file=changelog.xml --format=xml --project-defaults-file=liquibase.properties --url=jdbc:postgresql://localhost:5432/leantech_prjct_airbnb_db --username=postgres --password=root

liquibase status --username=postgres --password=root --changelog-file=./changelog.xml

liquibase generate-changelog --changelog-file=./changelog.xml --url=jdbc:postgresql://localhost:5432/leantech_prjct_airbnb_db --username=root --password=root --schemas=sch_airbnb

liquibase update --changelog-file=./changelog.xml --schemas=sch_airbnb

```