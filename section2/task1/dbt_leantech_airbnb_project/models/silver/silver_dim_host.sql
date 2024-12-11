with final as (
    select 
    *
    from {{ source('silver_src', 'dim_host') }}
)
select * from final