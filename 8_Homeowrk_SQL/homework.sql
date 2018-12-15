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
SHOW CREATE TABLE address;

-- 6a
select staff.first_name, staff.last_name, address.address from staff 
inner join address on staff.address_id = address.address_id;

-- 6b
select staff.first_name, staff.last_name, sum(payment.amount) as total_payment from staff 
inner join payment on staff.staff_id = payment.staff_id;

-- 6c
select film.title, count(film_actor.actor_id) as actor_count from film 
inner join film_actor on film.film_id = film_actor.film_id;

-- 6d
select count(inventory_id) as inventory_count from inventory where film_id = 439;

-- 6e
select customer.last_name, sum(payment.amount) as total_payment from customer
inner join payment on customer.customer_id = payment.customer_id;

-- 7a
-- select title from film where title like "k%" or title like "q%" and language_id = 1;
-- select * from language;

select title from film where title like "k%" or title like "q%" and language_id IN
(select language_id from language where name IN ('English'));

-- 7b
select first_name, last_name from actor where actor_id IN
(select actor_id from film_actor where film_id IN 
(select film_id from film where title IN ('Alone Trip')));

-- 7c
select first_name, last_name, email from customer where address_id IN
(select address_id from address where city_id IN
(select city_id from city where country_id IN 
(select country_id from country where country IN ('Canada'))));

-- 7d
-- select * from category;

select title from film where film_id IN
(select film_id from film_category where category_id IN
(select category_id from category where name IN ('Family')));

-- 7e
select inventory.film_id, count(rental.rental_id) as rental_count from inventory
inner join rental on inventory.inventory_id = rental.inventory_id;

select customer.last_name, sum(payment.amount) as total_payment from customer
inner join payment on customer.customer_id = payment.customer_id;

-- 7f
-- 7g
-- 7h

-- 8a
-- 8b
-- 8c

