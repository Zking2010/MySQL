use sakila;
-- 1a
select first_name,last_name
from actor;
-- 1b
select upper(concat(first_name,last_name))
as 'Actor Name';
-- 2a
select actor_id,first_name,last_name
from actor
where first_name like 'JOE';
-- 2b
select first_name,last_name
from actor
where last_name like '%GEN%';
-- 2c
select last_name,first_name
from actor
where last_name like '%LI%';
-- 2d
select country_id, country
from country
where country in ('Afghanistan','Bangladesh','China');
-- 3a
alter table actor
add column middle_name varchar(50) after first_name;
-- 3b
alter table actor
modify column middle_name blob;
-- 3c
alter table actor
drop column middle_name;
-- 4a
select last_name,count(*)
from actor
group by last_name;
-- 4b
select last_name,count(*)
from actor
group by last_name
having count(*) > 2;
-- 4c
update actor
set first_name = 'HARPO'
where actor_id = 172;
-- checking whether it changed
select * from actor
where first_name LIKE 'HARPO';
-- 4d
update actor
set first_name = 'GROUCHO'
where actor_id = 172;
-- 5a
create schema address;
-- 6a
select staff.first_name,staff.last_name,address.address
from address 
join staff on staff.address_id=address.address_id;
-- 6b
select staff.first_name, staff.last_name,sum(payment.amount)
from staff
join payment on staff.staff_id=payment.staff_id
group by staff.staff_id;
-- 6c
select film.title,count(actor_id)
from film
inner join film_actor on film_actor.film_id=film.film_id
group by title;
-- 6d
select film.title, count(inventory.inventory_id)
from film
join inventory on inventory.film_id=film.film_id
where title in ('Hunchback Impossible');
-- 6e
select first_name, last_name, sum(amount) as 'Total Paid'
from payment p
inner join customer c
on p.customer_id = c.customer_id
group by p.customer_id
order by last_name asc;
-- 7a
select title
from film
where language_id in 
(select language_id
from language
where name = 'English')
and (title like 'K%') or (title like 'Q%');
-- 7b
select first_name,last_name 
from actor
where actor_id in
(select actor_id
from film_actor
where film_id in 
(select film_id 
from film
where title = 'Alone Trip'));

-- 7c
select first_name,last_name, email
from customer
inner join customer_list
on customer.customer_id = customer_list.ID
where country = 'Canada';
-- 7d
select title, name
from category,film,film_category
where category.category_id = film_category.category_id
and film_category.film_id = film.film_id
and name = 'Family';
-- 7e
select title as 'Movie Title',count(rental_date) as 'Rental Count'
from film,inventory,rental
where film.film_id = inventory.film_id
and inventory.inventory_id = rental.inventory_id
group by title
order by count(rental_date) desc;
-- 7f
select store.store_id as 'Store',sum(amount) as 'Total Payment'
from store,staff,payment
where store.store_id = staff.store_id
and staff.staff_id = payment.staff_id
group by store.store_id
order by sum(amount) desc;
-- 7g
select store_id, city, country
from store,address,city,country
where store.address_id = address.address_id
and address.city_id = city.city_id
and city.country_id = country.country_id;
-- 7h
select name,sum(amount) as 'Gross_Revenue'
from category,film_category,inventory,rental,payment
where category.category_id = film_category.category_id
and film_category.film_id = inventory.film_id
and inventory.inventory_id=rental.inventory_id
and rental.rental_id = payment.rental_id
group by name
order by Gross_Revenue desc
limit 5;
-- 8a
create view top_five_genres as 
select name,sum(amount) as 'gross_revenue'
from category,film_category,inventory,rental,payment
where category.category_id = film_category.category_id
and film_category.film_id = inventory.film_id
and inventory.inventory_id=rental.inventory_id
and rental.rental_id = payment.rental_id
group by name
order by gross_revenue desc
limit 5;
-- 8b
select * from top_five_genres;
-- 8c
drop view top_five_genres