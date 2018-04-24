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
join payment on staff.staff_id=payment.staff_id;
-- 6c
select film.title,count(actor_id)
from film
inner join film_actor on film_actor.film_id=film.film_id
group by title;
-- 6d
select film.title, count(inventory.film_id)
from film
join inventory on inventory.inventory_id=film.film_id
where title in ('Hunchback Impossible');
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
drop view top_five_genres