CREATE TABLE subscribers (
  customer_id INT,
  subscription_date DATE,
  plan_value INT
);

INSERT INTO subscribers VALUES
(1, '2023-03-02', 799),
(1, '2023-04-01', 599),
(1, '2023-05-01', 499),
(2, '2023-04-02', 799),
(2, '2023-07-01', 599),
(2, '2023-09-01', 499),
(3, '2023-01-01', 499),
(3, '2023-04-01', 599),
(3, '2023-07-02', 799),
(4, '2023-04-01', 499),
(4, '2023-09-01', 599),
(4, '2023-10-02', 499),
(4, '2023-11-02', 799),
(5, '2023-10-02', 799),
(5, '2023-11-02', 799),
(6, '2023-03-01', 499);


select * from subscribers;

-- Find unique customers
with uniqu_subs as (
    select *,
    row_number() over (partition by customer_id order by subscription_date) as rn
    from subscribers
)select * from uniqu_subs where rn =1;

-- Find min and max spend for each customer

select customer_id, min(plan_value) min_spend, max(plan_value) as max_spend
from subscribers group by customer_id;

-- List customers  with who have upgraded or downgraded their plan at least once
with cte1 as ( -- adding previous plan value for each subscription
    select *,
    lag(plan_value,1,plan_value) over (partition by customer_id order by subscription_date) as prev_value
    from subscribers
),
cte2 as ( -- checking if there is any upgrade or downgrade for each customer
          -- atleast one upgrade or downgarde so used max to find it
    select 
    customer_id,
    max(case when plan_value > prev_value then 1 else 0 end) as has_upgraded,
    max(case when plan_value < prev_value then 1 else 0 end) as has_downgraded
    from cte1 group by customer_id
)select -- Adding Yes or No for upgrade and downgrade
customer_id,
case when has_upgraded = 1 then "Yes" else "No" end as isupgraded,
case when has_downgraded = 1 then "Yes" else "No" end as isdowngraded
from cte2