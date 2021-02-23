-- 1
select
	count(distinct customer_id) as active_customers,
	year(rental_date) as y,
	month(rental_date) as m
from rental
group by y, m
order by y desc, m desc
limit 1
;

-- 2
select
	count(distinct customer_id) as active_customers,
	year(rental_date) as y,
	month(rental_date) as m
from rental
group by y, m
order by y desc, m desc
limit 1
offset 1
;
-- 3
select s1.active_customers as last_month, s2.active_customers as previous_month, round((s2.active_customers-s1.active_customers)/s1.active_customers*100,2) as rate_perc from
(select
	count(distinct customer_id) as active_customers,
	year(rental_date) as y,
	month(rental_date) as m
from rental
group by y, m
order by y desc, m desc
limit 1) s1
join
(select
	count(distinct customer_id) as active_customers,
	year(rental_date) as y,
	month(rental_date) as m
from rental
group by y, m
order by y desc, m desc
limit 1 
offset 1) s2;
-- 4
select y, m, active_customers as m1, active_customers-lag(active_customers,1) over() as retained_customers from
(select
	count(distinct customer_id) as active_customers,
	year(rental_date) as y,
	month(rental_date) as m
from rental
group by y, m
order by y asc, m asc) s1;