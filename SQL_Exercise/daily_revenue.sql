-- Find the roll up sum for a weekly revenue
create table sales (
    sales_date date,
    amount int
)

INSERT INTO sales (sales_date, amount) VALUES
('2024-01-01', 800),
('2024-01-02', 700),
('2024-01-03', 450),
('2024-01-04', 200),
('2024-01-05', 900),
('2024-01-06', 150),
('2024-01-07', 600),
('2024-01-08', 400),
('2024-01-11', 350),
('2024-01-12', 550),
('2024-01-15', 800),
('2024-01-16', 650),
('2024-01-17', 300);

select * from sales;

select *, -- used range betweeb interval 6 day which endures the calender day week revenue and not the 7 rows of data with skipped date
sum(amount) over(order by sales_date RANGE BETWEEN INTERVAL '6' DAY PRECEDING  AND CURRENT ROW) as cumulative_revenue
from sales