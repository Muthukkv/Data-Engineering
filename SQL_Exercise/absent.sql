--Find employee who absent for 3 consecutive days

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE attendance (
    eid INT,
    att_date DATE,
    status VARCHAR(10) CHECK (status IN ('Present', 'Absent')),
    PRIMARY KEY (eid, att_date),
    FOREIGN KEY (eid) REFERENCES employees(id)
);

INSERT INTO employees (id, name) VALUES 
(1, 'Aarav'),
(2, 'Priya'),
(3, 'Rahul'),
(4, 'Sneha');
INSERT INTO attendance (eid, att_date, status) VALUES 
(1, '2024-03-01', 'Present'),
(1, '2024-03-02', 'Absent'),
(1, '2024-03-03', 'Absent'),
(1, '2024-03-04', 'Absent'),
(1, '2024-03-05', 'Present'),
(2, '2024-03-01', 'Absent'),
(2, '2024-03-02', 'Absent'),
(2, '2024-03-03', 'Present'),
(2, '2024-03-04', 'Absent'),
(3, '2024-03-01', 'Absent'),
(3, '2024-03-02', 'Absent'),
(3, '2024-03-03', 'Absent'),
(3, '2024-03-04', 'Absent'),
(3, '2024-03-05', 'Present'),
(4, '2024-03-01', 'Absent'),
(4, '2024-03-02', 'Present'),
(4, '2024-03-03', 'Absent');


with cte1 as (
    select *,
    -- adding row number to each row and then subtracting the day of date with row number to get the same value for consecutive days
    day(att_date)-row_number() over(PARTITION BY eid order by att_date) as grp
     from attendance where status = 'Absent'
     -- result of this cte is intermediate result with has grp column, see this result to understand the logic of grp column
),
cte2 as (
    select eid, min(att_date) as start_date, max(att_date) as end_date
    from cte1
    group by eid,grp having count(*) >= 3 -- group by eid and newly created grp to get the consecutive days and then filter those groups which have count of 3 or more
    
)select e.id, e.name, c.start_date, c.end_date from employees e join cte2 c on e.id = c.eid;