
--1. How many actors are there with the last name ‘Wahlberg’?
SELECT COUNT(*) AS TotalActors
FROM actor
WHERE last_name = 'Wahlberg';

--2. How many payments were made between $3.99 and $5.99?
SELECT COUNT(*) AS TotalPayments
FROM payment
WHERE amount BETWEEN 3.99 AND 5.99;

--3. What film does the store have the most of? (search in inventory)
SELECT film.title AS MostStockedFilm
FROM film
JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title
ORDER BY COUNT(*) DESC
LIMIT 1;

--4. How many customers have the last name ‘William’?
SELECT COUNT(*) AS TotalCustomers
FROM customer
WHERE last_name = 'William';

--5. What store employee (get the id) sold the most rentals?
SELECT staff_id, COUNT(*) AS TotalRentalsSold
FROM rental
GROUP BY staff_id
ORDER BY TotalRentalsSold DESC
LIMIT 1;

--6. How many different district names are there?
SELECT COUNT(DISTINCT district) AS NumberOfDistricts
FROM address;

--7. What film has the most actors in it? (use film_actor table and get film_id)
SELECT film.film_id, film.title AS FilmTitle, COUNT(film_actor.actor_id) AS TotalActors
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id, FilmTitle
ORDER BY TotalActors DESC
LIMIT 1;


--8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)
SELECT COUNT(*) AS CustomersWithLastNameEndingEs
FROM customer
WHERE store_id = 1 AND last_name LIKE '%es';

--9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
--with ids between 380 and 430? (use group by and having > 250)
SELECT amount, NumberOfRentals
FROM (
    SELECT payment.amount, COUNT(*) AS NumberOfRentals
    FROM payment
    JOIN rental ON payment.rental_id = rental.rental_id
    JOIN customer ON rental.customer_id = customer.customer_id
    WHERE customer.customer_id BETWEEN 380 AND 430
    GROUP BY payment.amount
) AS Subquery
WHERE NumberOfRentals > 250;


--10. Within the film table, how many rating categories are there? And what rating has the most
--movies total?

-- Count the number of distinct rating categories
SELECT COUNT(DISTINCT rating) AS NumberOfRatingCategories
FROM film;

-- Identify the rating with the most movies
SELECT rating, COUNT(*) AS NumberOfMovies
FROM film
GROUP BY rating
ORDER BY NumberOfMovies DESC
LIMIT 1;