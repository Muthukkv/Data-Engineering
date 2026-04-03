create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

-- Find total match, total win and total loss for each team

with cte1 as ( -- seperate team_1 and team_2 into single column
select team_1 as team, winner from icc_world_cup
union all
select team_2 as team, winner from icc_world_cup
),
total_match as ( -- count total match played by each team
    select team,count(*) as total_match from cte1 group by team
),
total_win as ( -- count total win by each team
select 
t1.team, count(t2.Winner) as total_win 
from total_match t1 left join icc_world_cup t2 on t1.team = t2.winner
group by 1
)-- final output with total match, total win and total loss
select t1.team,t1.total_match,t2.total_win , (t1.total_match - t2.total_win) as total_loss
from total_match t1 left join total_win t2 on t1.team = t2.team