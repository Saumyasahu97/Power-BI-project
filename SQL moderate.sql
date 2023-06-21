Q1. write query to return the email,first name,last name & gener of all rock music listiner.Return your 
    list order alphabetically by email	starting with A
	
select distinct email,first_name,last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice line on invoice.invoice_id = invoice.invoice_id
	WHERE track_id IN(
	select track_id from track
	join genre on track.genre_id = genre.genre_id
	where genre.name like 'Rock'
)
	order by email;
	
Q2.LET'S invite the artist who have written the mosst rock music in our dataset. write a query that
   returns the artist name and total track count of the top 10 rock bands

Select artist.artist_id from artist