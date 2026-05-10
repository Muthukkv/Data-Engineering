
-- Report the users current credit and whether they have breached their credit limit. 
--A user breaches their credit limit if the total amount they have paid exceeds the total amount they have received plus their credit limit.
-- Table: Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    credit_limit INT
);

-- Table: Transactions
CREATE TABLE Transactionss (
    trans_id INT PRIMARY KEY,
    paid_by INT,
    paid_to INT,
    amount INT,
    trans_date DATE,
    FOREIGN KEY (paid_by) REFERENCES Users(user_id),
    FOREIGN KEY (paid_to) REFERENCES Users(user_id)
);

INSERT INTO Users (user_id, user_name, credit_limit) VALUES
(1, 'Peter', 100),
(2, 'Roger', 200),
(3, 'Jack', 10000),
(4, 'John', 800);

INSERT INTO transactionss (trans_id, paid_by, paid_to, amount, trans_date) VALUES
(1, 1, 3, 400, '2024-01-01'),
(2, 3, 2, 500, '2024-02-01'),
(3, 2, 1, 200, '2024-02-01');

select * from users;
select * from transactionss;

with cte1 as ( -- adding +veve and -ve amount for paid_to and paid_by respectively
    select paid_by as user_id, -amount as amount from transactionss
    union all
    select paid_to as user_id, amount as amount from transactionss
),-- Finding all users currret credit by adding amount to credit limit and checking if it is breached or not
cte2 as (select user_id, sum(amount) as amount from cte1 group by user_id
) select u.user_id,u.user_name, COALESCE(c.amount,0)+u.credit_limit as credit,
case when COALESCE(c.amount,0)+u.credit_limit < 0 then 'Yes' else 'No' end as is_breached
from users u left join cte2 c on u.user_id = c.user_id;