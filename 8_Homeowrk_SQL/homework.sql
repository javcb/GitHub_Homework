-- 1a
select first_name, last_name from actor;

-- 1b
SELECT CONCAT(first_name, " ", last_name) as "Actor Name" FROM actor;

-- 2a
select actor_id, first_name, last_name from actor where first_name = "Joe";

-- 2b
select * from actor where last_name like "%GEN%";

-- 2c
select * from actor where last_name like "%LI%" order by last_name, first_name asc;

-- 2d
select country_id, country from country where country in ("Afghanistan", "Bangladesh", "China");

-- 3a
-- 3b
-- 4a
-- 4b
-- 4c
-- 4d

-- 5a
SHOW CREATE TABLE address

-- 6a

-- 6b
-- 6c
-- 6d
-- 6e

-- 7a
-- 7b
-- 7c
-- 7d
-- 7e
-- 7f
-- 7g
-- 7h

-- 8a
-- 8b
-- 8c

