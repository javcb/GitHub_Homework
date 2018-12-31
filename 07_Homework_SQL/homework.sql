-- 1a. Display the first and last names of all actors from the table `actor`.
select first_name, last_name from actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
SELECT CONCAT(first_name, " ", last_name) as "Actor Name" FROM actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id, first_name, last_name from actor where first_name = "Joe";

-- 2b. Find all actors whose last name contain the letters `GEN`:
select * from actor where last_name like "%GEN%";

-- 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
select * from actor where last_name like "%LI%" order by last_name, first_name asc;

-- 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
select country_id, country from country where country in ("Afghanistan", "Bangladesh", "China");

-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).
-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.

-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, count(actor_id) from actor group by last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(actor_id) as actorid_count from actor group by last_name where actorid_count > 1;

-- 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
-- 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.

-- 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
select staff.first_name, staff.last_name, address.address from staff 
inner join address on staff.address_id = address.address_id;

-- 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
select staff.first_name, staff.staff_id, staff.last_name, sum(payment.amount) as total_payment from staff 
inner join payment on staff.staff_id = payment.staff_id group by staff_id;

-- 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
select film.title, count(film_actor.actor_id) as actor_count from film 
inner join film_actor on film.film_id = film_actor.film_id group by title;

-- 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
select count(inventory_id) as inventory_count from inventory where film_id = 439;

-- 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
select customer.last_name, sum(payment.amount) as total_payment from customer
inner join payment on customer.customer_id = payment.customer_id group by last_name;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.

-- select title from film where title like "k%" or title like "q%" and language_id = 1;
-- select * from language;

select title from film where title like "k%" or title like "q%" and language_id IN
(select language_id from language where name IN ('English'));

-- 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
select first_name, last_name from actor where actor_id IN
(select actor_id from film_actor where film_id IN 
(select film_id from film where title IN ('Alone Trip')));

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
select first_name, last_name, email from customer where address_id IN
(select address_id from address where city_id IN
(select city_id from city where country_id IN 
(select country_id from country where country IN ('Canada'))));

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.

-- select * from category;

select title from film where film_id IN
(select film_id from film_category where category_id IN
(select category_id from category where name IN ('Family')));

-- 7e. Display the most frequently rented movies in descending order.
select film.title as film_name, count(rental.rental_id) as rental_count from inventory
inner join rental on inventory.inventory_id = rental.inventory_id
inner join film on inventory.film_id = film.film_id group by film_name order by rental_count desc;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
select * from sales_by_store;

-- 7g: Write a query to display for each store its store ID, city, and country.
select store.store_id, city.city, country.country from store
inner join address on store.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id;

-- 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select * from sales_by_film_category order by total_sales desc limit 5;

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW `top5genres` AS SELECT * from sales_by_film_category order by total_sales desc limit 5;

-- 8b. How would you display the view that you created in 8a?
select * from top5genres;

-- 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
DROP VIEW `top5genres`;
