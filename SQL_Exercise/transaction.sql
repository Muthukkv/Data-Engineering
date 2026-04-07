-- Find the balnce after each transaction

create table TRANSACTIONS (
    txn_id int primary key,
    txn_date date,
    type ENUM('debit', 'credit'),
    amount decimal(10, 2)
)

insert into transactions values (1, '2024-01-01', 'credit', 5000.00);
insert into transactions values (2, '2024-01-03', 'debit', 1000.00);
insert into transactions values (3, '2024-01-07', 'credit', 3000.00);
insert into transactions values (4, '2024-01-12', 'debit', 2500.00);
insert into transactions values (5, '2024-01-18', 'credit', 4000.00);
insert into transactions values (6, '2024-01-25', 'debit', 1500.00);

select * from TRANSACTIONS;

with cte1 as ( -- Adding signs to easch transaction amount based on the type of transaction
    select *,
    CASE 
        WHEN type='credit' THEN amount
        ELSE  -amount
    END as signed_amount
    from transactions
)
select -- Finding the sum of signed_amount from 1st day to current day to get the running balance after each transaction
txn_id, txn_date, type, amount,
sum(signed_amount) over(order by txn_date) as running_balance -- txn_id can add on the order by clause to avoid the tie if multiple transactions happen on the same day
 from cte1;
