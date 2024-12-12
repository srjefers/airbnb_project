with final as (
    select 
        distinct
        *
    from {{ source('silver_src', 'dim_room_type') }}
)
select * from final