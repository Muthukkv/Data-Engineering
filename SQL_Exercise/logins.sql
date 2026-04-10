create table logins (
    user_id int,
    login_date date
);

INSERT INTO logins (user_name, login_date) VALUES
('Aarav', '2024-01-01'),
('Aarav', '2024-01-02'),
('Aarav', '2024-01-03'),
('Aarav', '2024-01-06'),
('Aarav', '2024-01-07'),
('Priya', '2024-01-02'),
('Priya', '2024-01-03'),
('Priya', '2024-01-04'),
('Priya', '2024-01-05'),
('Priya', '2024-01-10');
('Muthu', '2024-01-01'),
('Muthu', '2024-01-03'),
('Muthu', '2024-01-05'),
('Muthu', '2024-01-07');


select * from logins;

with cte1 as ( -- finding common difference between login date and row number to identify consecutive logins 
    select *, login_date - ROW_NUMBER() over(PARTITION BY user_name order by login_date) as grp
from logins
)select user_name,min(login_date) as streak_start, max(login_date) as streak_end, count(*) as strak_count from cte1 
group by user_name, grp
having count(*) >= 3