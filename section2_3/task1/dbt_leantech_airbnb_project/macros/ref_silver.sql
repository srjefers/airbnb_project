{% macro ref_silver(model_name) -%}

    {%- set silver_sch = "sch_silver_airbnb" %}
    {%- set normal_ref_relation = ref(model_name) -%}

    {%  set silver_ref = adapter.get_relation(
            database = target.dbname,
            schema = silver_sch,
            identifier = normal_ref_relation.identifier
            )
    %}

    {{ return(silver_ref) }}

{%- endmacro %}