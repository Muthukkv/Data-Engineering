-- Find the each customers longest gap between orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    cust_id VARCHAR(50),
    order_date DATE,
    amount INT
);

INSERT INTO orders (order_id, cust_id, order_date, amount) VALUES
(101, 'Aarav', '2024-01-05', 500),
(102, 'Aarav', '2024-01-12', 300),
(103, 'Aarav', '2024-03-20', 800),
(104, 'Aarav', '2024-03-25', 450),
(105, 'Priya', '2024-02-01', 600),
(106, 'Priya', '2024-02-15', 400),
(107, 'Priya', '2024-02-28', 700),
(108, 'Priya', '2024-03-10', 500),
(109, 'Rahul', '2024-01-10', 250),
(110, 'Rahul', '2024-01-20', 350),
(111, 'Rahul', '2024-04-01', 900);

select * from orders;

with cte1 as( -- bring the prev date to current row 
    select *,
    lag(order_date,1,order_date) over (partition by cust_id order by order_date) as prev_date
from orders
),
cte2 as ( -- calculate the gap between current order date and previous order date
    select *,
    DATEDIFF(order_date, prev_date) as gap
    from cte1
),
cte3 as ( -- rank the gap and selcte the highest gap
    select *, rank() over (partition by cust_id order by gap desc) as rn from cte2
) select cust_id,prev_date as gap_start_date, order_date as gap_end_date, gap from cte3 where rn = 1;