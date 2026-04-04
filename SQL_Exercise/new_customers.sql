
-- Find the number of new customers and old customers for each day.
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

select * from customer_orders

with first_visit as ( -- Find each customers first visit date
select 
customer_id, min(order_date) as first_visit_date
from customer_orders group by customer_id
)
-- find the new and old customer count, logic is if fisrt visit and order data is same for the cutomer id then new else old
select 
co.order_date,
sum(case when co.order_date = fv.first_visit_date then 1 else 0 end) as new_count,
count(*) - sum(case when co.order_date = fv.first_visit_date then 1 else 0 end) as old_count
from customer_orders co join first_visit fv 
on co.customer_id = fv.customer_id
group by co.order_date


-- approach with window function

with cte1 as (
    select *,
    row_number() over (partition by customer_id order by order_date) as rn
    from customer_orders
),cte2 as (
    select order_date,
    sum(case when rn = 1 then 1 else 0 end) as new_cust,
    count(*) - sum(case when rn = 1 then 1 else 0 end) as old_cust
    from cte1 group by order_date
)
select * from cte2