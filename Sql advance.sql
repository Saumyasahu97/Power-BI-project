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
	
Q2.LET invite the artist who have written the mosst rock music in our dataset. write a query that
   returns the artist name and total track count of the top 10 rock bands

Select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'rock'
order by number_of_songs desc
limit 10

Q3.return all track names that have a song length longer than the average somg length . Return the name 
and miliseconds for each track. order by the song length with the longest song listed first.


select name,miliseconds
from track
where miliseconds > (
	select Avg(miliseconds) as avg_track_length
	from track)
	order by milisecond desc;
	
Advance question
Q1. Find how much amount spent by each customer on artist? write a query to return customer name ,artist 
name and total spent.


with best_selling_artist as (
	select artist.artist_id as artist_id,artist.name as artist_name,
	sum (invoice_line.unit_price*invoice_line.quantity) as total_sales
	from invoice_line
	join track on track.track_id = invoice_line.track_id
	join album on album.album_id = track.album_id
	join artist on artist.artist_id = album.artist_id
	group by 1
	order by 3 desc
	limit 1
)
select c.customer_id,c.first_name,c.last_name, bsa.artist_name
sum(il.unit_price*il.quantity) as amount_spent
from invoice i
join customer c on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album alb on alb.album_id = t.album_id
join best_selling_artist bsa on bsa.artist_id = alb.artist_id
group by 1,2,3,4
order by 5 desc;

Q2.we want to find out most popular genre as the genre with the highest amount purchase .write a qyery
that returns each country along with the top genre ,for countries where the maximum number of purchase 
is shared return all genres.


with popular_genre as 
(
	select count (invoice_line.quantity) as purchase,customer.country,genre.name,genre.genre_id,
	row_number()over (partition by customer.country order by count(invoice_line.quantity)desc) as
	rowno
	from invoice_line
	join invoice on invoice.invoice_id = invoice_line.invoice_id
	join customer on customer.customer_id = invoice.customer_id
	join track on track.track_id = invoice_line.track_id
	join genre on genre.genre_id = track.genre_id
	group by 2,3,4
	order by 2 asc,1 desc
)
select from popular_genre where rowno <=1
	
