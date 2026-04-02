CREATE TABLE revenue(  
    month VARCHAR(20) NOT NULL,
    amounnt DECIMAL(10, 2) NOT NULL
);

insert into revenue values('January', 40000);
insert into revenue values('February', 55000);
insert into revenue values('March', 45000);
insert into revenue values('April', 70000);
insert into revenue values('May', 62000);
insert into revenue values('June', 80000);
insert into revenue values('July', 78000);
insert into revenue values('August', 91000);


select * FROM revenue;

with cte1 as (
    select *,
    lag(amount) over () as prev_month_amount
    from revenue
)select month,amount,prev_month_amount from cte1 
where prev_month_amount > amount 