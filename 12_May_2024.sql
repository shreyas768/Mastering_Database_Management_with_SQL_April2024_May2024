


CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);



INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

SELECT * FROM events;

WITH cte AS(
SELECT GOLD AS player_name, 'gold' AS medal_type FROM events
UNION ALL SELECT SILVER AS player_name, 'silver' AS medal_type FROM events
UNION ALL SELECT BRONZE AS player_name, 'bronze' AS medal_type FROM events)
SELECT player_name, COUNT(*) AS no_of_medals
FROM cte
GROUP BY player_name
HAVING COUNT(DISTINCT medal_type) AND MAX(medal_type) = 'gold';

DROP TABLE hospital;

create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

-- we need to find no of employees inside the hospital

SELECT * FROM hospital;
WITH CTE1 AS (
SELECT *,
RANK() OVER (PARTITION BY emp_id ORDER BY time DESC) AS rnk
FROM hospital)
SELECT COUNT(*) AS no_of_employees_inside FROM CTE1
WHERE action = 'in'
AND rnk = 1;


create table employee 
(
emp_name varchar(10),
dep_id int,
salary int
);

insert into employee values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000);

WITH cte AS (SELECT 
*,
MAX(salary) OVER (PARTITION BY dep_id) AS max_salary,
MIN(salary) OVER (PARTITION BY dep_id) AS min_salary
FROM employee
ORDER BY dep_id)
SELECT dep_id,
MAX(CASE WHEN salary = cte.max_salary THEN emp_name END) AS max_sal_emp,
MAX(CASE WHEN salary = cte.min_salary THEN emp_name END) AS min_sal_emp
FROM cte
GROUP BY dep_id;




create table icc_world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);
INSERT INTO icc_world_cup values(1,'ENG','NZ','NZ');
INSERT INTO icc_world_cup values(2,'PAK','NED','PAK');
INSERT INTO icc_world_cup values(3,'AFG','BAN','BAN');
INSERT INTO icc_world_cup values(4,'SA','SL','SA');
INSERT INTO icc_world_cup values(5,'AUS','IND','IND');
INSERT INTO icc_world_cup values(6,'NZ','NED','NZ');
INSERT INTO icc_world_cup values(7,'ENG','BAN','ENG');
INSERT INTO icc_world_cup values(8,'SL','PAK','PAK');
INSERT INTO icc_world_cup values(9,'AFG','IND','IND');
INSERT INTO icc_world_cup values(10,'SA','AUS','SA');
INSERT INTO icc_world_cup values(11,'BAN','NZ','NZ');
INSERT INTO icc_world_cup values(12,'PAK','IND','IND');
INSERT INTO icc_world_cup values(12,'SA','IND','DRAW');

SELECT * FROM icc_world_cup;


WITH cte1 AS (SELECT team, SUM(match_played) AS match_played, SUM(win_flag) AS wins, SUM(NR) AS NR 
FROM
(SELECT team_1 AS team, COUNT(*) AS match_played,
SUM(CASE WHEN winner = team_1 then 1 else 0 END) AS win_flag,
SUM(CASE WHEN winner = 'DRAW' then 1 else 0 END) AS NR
FROM icc_world_cup GROUP BY team_1
UNION ALL
SELECT team_2 AS team, COUNT(*) AS match_played,
SUM(CASE WHEN winner = team_2 then 1 else 0 END) AS win_flag,
SUM(CASE WHEN winner = 'DRAW' then 1 else 0 END) AS NR
FROM icc_world_cup GROUP BY team_2) a
GROUP BY team)
SELECT *, match_played-wins, wins*2+NR*1 AS pts
FROM cte1
ORDER BY wins DESC;



CREATE TABLE movies (
id INT PRIMARY KEY,
genre VARCHAR(50),
title VARCHAR(100)
);
-- Create reviews table
CREATE TABLE reviews (
    movie_id INT,
    rating DECIMAL(3,1),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

-- Insert sample data into movies table
INSERT INTO movies (id, genre, title) VALUES
(1, 'Action', 'The Dark Knight'),
(2, 'Action', 'Avengers: Infinity War'),
(3, 'Action', 'Gladiator'),
(4, 'Action', 'Die Hard'),
(5, 'Action', 'Mad Max: Fury Road'),
(6, 'Drama', 'The Shawshank Redemption'),
(7, 'Drama', 'Forrest Gump'),
(8, 'Drama', 'The Godfather'),
(9, 'Drama', 'Schindler''s List'),
(10, 'Drama', 'Fight Club'),
(11, 'Comedy', 'The Hangover'),
(12, 'Comedy', 'Superbad'),
(13, 'Comedy', 'Dumb and Dumber'),
(14, 'Comedy', 'Bridesmaids'),
(15, 'Comedy', 'Anchorman: The Legend of Ron Burgundy');

-- Insert sample data into reviews table
INSERT INTO reviews (movie_id, rating) VALUES
(1, 4.5),
(1, 4.0),
(1, 5.0),
(2, 4.2),
(2, 4.8),
(2, 3.9),
(3, 4.6),
(3, 3.8),
(3, 4.3),
(4, 4.1),
(4, 3.7),
(4, 4.4),
(5, 3.9),
(5, 4.5),
(5, 4.2),
(6, 4.8),
(6, 4.7),
(6, 4.9),
(7, 4.6),
(7, 4.9),
(7, 4.3),
(8, 4.9),
(8, 5.0),
(8, 4.8),
(9, 4.7),
(9, 4.9),
(9, 4.5),
(10, 4.6),
(10, 4.3),
(10, 4.7),
(11, 3.9),
(11, 4.0),
(11, 3.5),
(12, 3.7),
(12, 3.8),
(12, 4.2),
(13, 3.2),
(13, 3.5),
(13, 3.8),
(14, 3.8),
(14, 4.0),
(14, 4.2),
(15, 3.9),
(15, 4.0),
(15, 4.1);



WITH cte AS (
SELECT m.genre, m.title, AVG(r.rating) AS avg_rating,
ROW_NUMBER() OVER(PARTITION BY m.genre ORDER BY AVG(r.rating) DESC) AS rnk
FROM movies m
INNER JOIN reviews r
ON m.id = r.movie_id
GROUP BY m.genre, m.title)
SELECT genre, title, ROUND(avg_rating,0)AS avg_rating,
REPEAT('*', ROUND(avg_rating,0)) AS stars
FROM cte
WHERE rnk = 1;