with final as (
    select 
    *
    from {{ source('silver_src', 'fct_home') }}
)
select * from final