-- Find user whos consecutively purchased

create table user (
    id int,
    purchase_date date
)

insert into user values(101, '2024-01-01');
insert into user values(101, '2024-01-02');
insert into user values(102, '2024-01-03');
insert into user values(102, '2024-01-10');
insert into user values(103, '2024-02-05');
insert into user values(103, '2024-02-06');

insert into user values(102, '2024-01-04');
update user set purchase_date = '2024-01-11' where id = 103 and purchase_date = '2024-02-05';
select * from user;

with cte1 as ( -- adding previous purchase date for each user using lag function
    select *,
    lag(purchase_date,1,purchase_date) over (partition by id order by purchase_date) as prev_date
    from user
)select id from cte1 where DATEDIFF(purchase_date, prev_date) = 1; -- Finding the difference between current purchase date and previous purchase date to check if they are consecutive or not