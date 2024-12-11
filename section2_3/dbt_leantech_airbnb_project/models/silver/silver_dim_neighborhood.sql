with final as (
    select 
    *
    from {{ source('silver_src', 'dim_neighborhood') }}
)
select * from final