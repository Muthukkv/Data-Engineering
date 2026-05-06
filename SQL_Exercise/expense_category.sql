-- DDL
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);

-- DML
INSERT INTO customers (id, name, city) VALUES
(1, 'Aarav', 'Mumbai'),
(2, 'Priya', 'Delhi'),
(3, 'Rahul', 'Bangalore'),
(4, 'Sneha', 'Chennai'),
(5, 'Amit', 'Pune'),
(6, 'Neha', 'Hyderabad'),
(7, 'Vikram', 'Kolkata'),
(8, 'Kavita', 'Ahmedabad');

-- DDL
CREATE TABLE order_expense (
    order_id INT PRIMARY KEY,
    cid INT,
    amount INT,
    order_date DATE,
    FOREIGN KEY (cid) REFERENCES customers(id)
);

-- DML
INSERT INTO order_expense (order_id, cid, amount, order_date) VALUES
(101, 1, 2500, '2024-01-05'),
(102, 1, 3200, '2024-02-10'),
(103, 2, 800, '2024-01-12'),
(104, 2, 600, '2024-03-05'),
(105, 3, 5500, '2024-01-20'),
(106, 3, 4800, '2024-02-28'),
(107, 4, 1200, '2024-02-14'),
(108, 4, 900, '2024-03-10'),
(109, 5, 7200, '2024-01-08'),
(110, 5, 6800, '2024-03-22'),
(111, 6, 3100, '2024-02-05'),
(112, 6, 2900, '2024-03-18'),
(113, 7, 450, '2024-01-30'),
(114, 8, 350, '2024-02-20');

select * from customers;
select * from order_expense;

-- Find the total expense for each customer and categorize them into 'Platinum', 'Gold', 'Silver' and 'Bronze' based on the total amount spent.

with cte1 as ( -- Dividing into 4 equal groups based on total amount spent with NTILE function
    select cid,sum(amount) as total_amount,
    NTILE(4) over(order by sum(amount) desc) as ord
    from order_expense
    group by cid
    order by ord
    ),
    cte2 as ( -- joining the total amount and category with customer details
        select c.*, cte1.total_amount,cte1.ord from customers c join cte1 
on c.id = cte1.cid
    )  select name, total_amount, -- providing category based on the order of total amount spent
    case when ord = 1 then 'Platinum'
         when ord = 2 then 'Gold'
         when ord = 3 then 'Silver'
         else 'Bronze' end as category from cte2
         order by total_amount desc;