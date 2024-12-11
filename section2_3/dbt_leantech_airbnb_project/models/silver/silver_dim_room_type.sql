with final as (
    select 
    *
    from {{ source('silver_src', 'dim_room_type') }}
)
select * from final