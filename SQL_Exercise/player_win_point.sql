CREATE TABLE matches (
    id INT PRIMARY KEY,
    team_1 VARCHAR(50),
    team_2 VARCHAR(50),
    winner VARCHAR(50)
);

INSERT INTO matches (id, team_1, team_2, winner) VALUES
(1, 'India', 'Australia', 'India'),
(2, 'England', 'Sri Lanka', 'Sri Lanka'),
(3, 'New Zealand', 'India', 'New Zealand'),
(4, 'India', 'Sri Lanka', 'India'),
(5, 'England', 'India', 'India'),
(6, 'South Africa', 'West Indies', 'South Africa'),
(7, 'Australia', 'England', 'Australia'),
(8, 'West Indies', 'India', 'India'),
(9, 'South Africa', 'New Zealand', 'South Africa'),
(10, 'Australia', 'Sri Lanka', 'Australia'),
(11, 'West Indies', 'England', 'West Indies'),
(12, 'New Zealand', 'Sri Lanka', 'New Zealand');

select * from matches;

with all_teams as (select team_1 as team, winner from matches
union all
select team_2 as team, winner from matches
)
select team, count(*) as total_matches,
sum(case when winner = team then 1 else 0 end) as total_win,
sum(case when winner != team then 1 else 0 end) as total_loss
from all_teams group by team order by total_win desc;
