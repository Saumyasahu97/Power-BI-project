Q1. who is the senior employee based on job title?

select * from employee
order by levels desc
limit 1
Q2. which country have the most invoices ?

select count (*) as c,billing_country
from invoice
group by billing_country
order by c desc

Q3. what are the top 3 values of total invoice?

select total from invoice
order by total desc
limit 3

Q4.which city has the best customers? we would like throw a promotionalmusic festival in the city 
   we made the most money . write a query that returns one city that has the highest sum of invoice total.
   return both the city name & sum of all invoice totals
   
select sum(total) as invoice_total,billing_city
from invoice 
group by billing_city
order by invoice_total desc

Q5. who is the best customer? The customer who has spent the most money will be declared the best customer 
    write a query that returns the person who has spent the most money
	
Select customer.customer_id,customer.first_name,customer.last_name, SUM(invoice.total) as total
from customer	
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

