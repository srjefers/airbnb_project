{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schame= target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schame }}
    {%- elif default_schame.upper() == 'DBT_PROD' -%}
        {{ custom_schema_name | trim }}
    {%- else -%}
        {{ default_schame }}_{{ custom_schema_name | trim }}
    {%- endif -%}

{%- endmacro %}
