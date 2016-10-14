DVD Rental Database Challenges

Which customer placed the orders on the earliest date? What did they order?
--Charlotte Hunter -> Blanket Beverly

SELECT
	customers.customer_id,
	customers.first_name,
	customers.last_name,
	rentals.rental_date,
	films.title

FROM
  public.customers,
  public.films,
  public.inventory,
  public.rentals
WHERE
  films.film_id = inventory.film_id AND
  inventory.inventory_id = rentals.inventory_id AND
  rentals.customer_id = customers.customer_id
ORDER BY
	rentals.rental_date

-------------------------------------------------------------------------------
Which product do we have the most of? Find the order ids and customer names for all orders for that item.


-------------------------------------------------------------------------------
What orders have there been from Texas? In June?
-------------------------------------------------------------------------------
How many orders have we had for sci-fi films? From Texas?
-------------------------------------------------------------------------------
Which actors have not appeared in a Sci-Fi film?
-------------------------------------------------------------------------------
Find all customers who have not ordered a Sci-Fi film.
