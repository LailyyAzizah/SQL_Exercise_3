
use sakila;

-- 1. Tampilkan daftar semua film yang tersedia di toko
select	title, description 
from 	film
limit 10;


-- 2. Siapa staff yang paling banyak melakukan transaksi peminjaman
select	stf.first_name, 
		stf.last_name,
		count(r.staff_id) as rental_count
from staff stf
join rental r on r.staff_id = stf.staff_id 
group by 1, 2
order by 3 desc
limit 1;


-- 3. Tampilkan daftar 10 aktor pertama berdasarkan abjad
select	first_name, last_name
from 	actor
order by 1, 2
limit 10;


-- 4. Tampilkan 5 film dengan durasi paling lama
select	f.title, f.`length`  
from film f
order by 2 desc
limit 5;


-- 5. Hitung Jumlah pinjaman yang dilakukan setiap bulan dalam setahun
select 	extract(year from r.rental_date) as `year`,
		extract(month from r.rental_date) as `month`,
		count(*) as rental_count
from rental r
group by 1, 2;


-- 6. Tampilkan daftar film yang memiliki kata "Drama" dalam deskripsi mereka
select	sub_tab.title
from (
	select	film_id, title, description
	from film
	where description like ('%Drama%')
)sub_tab
limit 10;


-- 7. Hitung total pendapatan dari peminjaman pada hari jumat
select	sum(p.amount) as 'sum'
from payment p 
where dayname(p.payment_date) = 'Friday';


-- 8. Tampilkan 5 kota dengan total pendapatan peminjaman tertinggi
select	ct.city_id, ct.city,
		sum(p.amount) as total_revenue
from	payment p 
join customer cust on cust.customer_id = p.customer_id 
join address addr on addr.address_id = cust.address_id 
join city ct on ct.city_id = addr.city_id 
group by 1, 2
order by 3 desc
limit 5;


-- 9. Tampilkann 7 pelanggan yang paling sering terlambat mengembalikan film
select 	cust.customer_id, 
		cust.first_name, 
		cust.last_name,
		count(r.return_date) as late_return_count
from rental r 
join customer cust on cust.customer_id = r.customer_id
join 	inventory i on i.inventory_id = r.inventory_id 
join 	film f on f.film_id = i.film_id
where datediff(r.return_date, r.rental_date) >  f.rental_duration 
group by 1, 2, 3
order by 4 desc
limit 7;


-- 10. Tampilkan daftar film yang tidak pernah dipinjam
select f.film_id, f.title
from film f
where f.film_id not in (
	select i.film_id
	from inventory i);



















































