-- Model that provides monthly booking counts per neighborhood.
with fct_home_cte as (
    select 
        home_id,
        fk_review_id,
        fk_neighborhood_id
    from {{ ref_silver('silver_fct_home') }}
),
dim_review_cte as (
    select 
        review_id,
        number_of_reviews,
        last_review,
        reviews_per_month
    from {{ ref_silver('silver_dim_review') }}
),
dim_neighborhood_cte as (
    select 
        neighborhood_id,
        neighbourhood_group,
        neighbourhood_name
    from {{ ref_silver('silver_dim_neighborhood') }}
),
final as (
    select 
        dim_neighborhood_cte.neighbourhood_group,
        dim_neighborhood_cte.neighbourhood_name,
        to_char(dim_review_cte.last_review::date, 'Month') booking_month,
        sum(dim_review_cte.reviews_per_month) total_booking
    from fct_home_cte
    inner join dim_neighborhood_cte
        on fct_home_cte.fk_neighborhood_id = dim_neighborhood_cte.neighborhood_id
    inner join dim_review_cte
        on fct_home_cte.fk_review_id = dim_review_cte.review_id
    group by dim_neighborhood_cte.neighbourhood_group,
        dim_neighborhood_cte.neighbourhood_name,
        to_char(dim_review_cte.last_review::date, 'Month')
)
select * from final