# Task 1: Snowflake Query Optimization
> A query on a large Snowflake table is performing poorly. It filters data based on the neighborhood column. How would you improve its performance?


## Solution
Since we are working with a large table, I think that I would follow the next steps:
1. Snowflake has the EXPLAIN PLAN function, that is going to describe how the sql script is being executed, I mean there is also a diagram that snowflake provides to see how much time it takes to perform a join or a group by function, so we would be able to see where it is taking too long time.
2. Snowflake has another feature that is about clustering the columns, `alter table airbnb cluster by (neighborhood)`, with that line we would be able to set a cluster key at the airbnb table and optimize the filters that we perform based on that specific column, if the table was already clustered, maybe we have to recluster the table on the same column, just to reorganize the way as it was being clustered. It would be great if we have another column such like dates or country that we can use to prunning, so we can reduce the amount of data that is being read.
3. If the query is frequentlly used, we can use the `cache` to be able to run the same query many times and get the result that we are expecting without running the query again.
4. We can enable the auto-scaling at the warehouse that we are using to run the query, so we would be able to dynamically allocate more reources if we need to run the query.