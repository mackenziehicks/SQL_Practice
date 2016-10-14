DVD Rental Outer Join Challenges
What are the categories of the movies that have never sold?

SELECT DISTINCT
  c.name
FROM
	category c LEFT OUTER JOIN film_categories fc ON c.category_id = fc.category_id
	LEFT OUTER JOIN films f ON f.film_id = fc.film_id
	LEFT OUTER JOIN inventory i ON i.film_id = f.film_id
	LEFT OUTER JOIN rentals r  ON r.inventory_id = i.inventory_id

WHERE
	r.rental_date is null
-------------------------------------------------------------------------------
Which customers did not order a movie in the second half of 2004?
-------------------------------------------------------------------------------
What was the total sales revenue in June, 2004? In California?
-------------------------------------------------------------------------------
What is the average number of lines in an order?
-------------------------------------------------------------------------------
Which categories of movies appeared in the biggest single sale(s) on December 1?
