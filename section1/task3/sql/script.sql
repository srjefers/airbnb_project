/*
Develop SQL queries to:
1. List the top 5 neighborhoods with the highest average listing prices.
*/
with dim_neighborhood_cte as (
    select 
        distinct
        neighborhood_id,
        neighbourhood_group,
        neighbourhood_name
    from sch_airbnb.dim_neighborhood
),
fact_home_cte as (
    select
        home_id,
        home_price,
        fk_neighborhood_id
    from sch_airbnb.fct_home
),
final as (
    select
        dim_neighborhood_cte.neighbourhood_name,
        avg(fact_home_cte.home_price) as average_price
    from fact_home_cte
    inner join dim_neighborhood_cte 
        on dim_neighborhood_cte.neighborhood_id = fact_home_cte.fk_neighborhood_id
    group by dim_neighborhood_cte.neighbourhood_name
    order by average_price desc
)
select * from final
limit 5;
-- oracle
FETCH FIRST 5 ROWS ONLY;


/*
2. Identify hosts with more than 5 listings.
*/
with dim_host_cte as (
    select 
        host_id,
        host_name,
        host_calculated_listings_count
    from sch_airbnb.dim_host
),
final as (
    select 
        host_id,
        host_name,
        host_calculated_listings_count
    from dim_host_cte
    where host_calculated_listings_count > 5
)
select * from final;

/*
3. Calculate the average number of reviews per listing for each neighborhood.
*/
--+ SOLUTION1
with dim_host_cte as (
    select 
        distinct
        host_id,
        host_calculated_listings_count
    from sch_airbnb.dim_host
),
dim_review_cte as (
    select 
        distinct
        review_id,
        number_of_reviews
    from sch_airbnb.dim_review
),
dim_neighborhood_cte as (
    select 
        distinct
        neighborhood_id,
        neighbourhood_group,
        neighbourhood_name
    from sch_airbnb.dim_neighborhood
),
fact_home_cte as (
    select
        home_id,
        fk_neighborhood_id,
        fk_host_id,
        fk_review_id
    from sch_airbnb.fct_home
),
final as (
    select 
        dim_neighborhood_cte.neighbourhood_group,
        dim_neighborhood_cte.neighbourhood_name,
        dim_host_cte.host_calculated_listings_count,
        avg(dim_review_cte.number_of_reviews) avg_number_of_reviews
    from fact_home_cte 
    left join dim_neighborhood_cte 
        on fact_home_cte.fk_neighborhood_id = dim_neighborhood_cte.neighborhood_id
    left join dim_review_cte
        on fact_home_cte.fk_review_id = dim_review_cte.review_id
    left join dim_host_cte
        on fact_home_cte.fk_host_id = dim_host_cte.host_id
    group by dim_neighborhood_cte.neighbourhood_group,
        dim_neighborhood_cte.neighbourhood_name,
        dim_host_cte.host_calculated_listings_count
)
select * from final;

--+ SOLUTION2
with dim_host_cte as (
    select 
        distinct
        host_id,
        host_calculated_listings_count
    from sch_airbnb.dim_host
),
dim_review_cte as (
    select 
        distinct
        review_id,
        number_of_reviews
    from sch_airbnb.dim_review
),
dim_neighborhood_cte as (
    select 
        distinct
        neighborhood_id,
        neighbourhood_group,
        neighbourhood_name
    from sch_airbnb.dim_neighborhood
),
fact_home_cte as (
    select
        home_id,
        fk_neighborhood_id,
        fk_host_id,
        fk_review_id
    from sch_airbnb.fct_home
),
final as (
    select 
        dim_neighborhood_cte.neighbourhood_group,
        dim_neighborhood_cte.neighbourhood_name,
        dim_host_cte.host_calculated_listings_count,
        avg(dim_review_cte.number_of_reviews) over (
            partition by dim_neighborhood_cte.neighbourhood_group,
                dim_neighborhood_cte.neighbourhood_name,
                dim_host_cte.host_calculated_listings_count 
            order by dim_neighborhood_cte.neighbourhood_name) avg_number_of_reviews
    from fact_home_cte 
    left join dim_neighborhood_cte 
        on fact_home_cte.fk_neighborhood_id = dim_neighborhood_cte.neighborhood_id
    left join dim_review_cte
        on fact_home_cte.fk_review_id = dim_review_cte.review_id
    left join dim_host_cte
        on fact_home_cte.fk_host_id = dim_host_cte.host_id
)
select * from final;
