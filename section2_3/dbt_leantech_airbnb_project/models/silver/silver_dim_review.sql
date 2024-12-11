with final as (
    select 
    *
    from {{ source('silver_src', 'dim_review') }}
)
select * from final