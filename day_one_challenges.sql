SQL Country Database Challenges
WHERE

What is the population of the US?

SELECT
	code,
	population
FROM
	countries
WHERE
	code = 'USA';

----------------------------------------------------------------------------
What is the area of the US?

SELECT
	code,
	surfacearea
FROM
	countries
WHERE
	code = 'USA';

----------------------------------------------------------------------------
List the countries in Africa that have a population smaller than 30,000,000 and a life expectancy of more than 45?

SELECT
	name,
	population,
	lifeexpectancy
FROM
	countries
WHERE
	continent = 'Africa'
AND
	population < 30000000
AND
	lifeexpectancy > 45;

----------------------------------------------------------------------------
Which countries gained independence after 1910 that are also a republic?

SELECT
	name,
	indepyear,
	governmentform
FROM
	countries
WHERE
	indepyear > 1910
AND
	governmentform = 'Republic';
----------------------------------------------------------------------------
----------------------------------------------------------------------------

ORDER BY

Which fifteen countries have the lowest life expectancy?

SELECT
	name,
	lifeexpectancy,
	continent
FROM
	countries
WHERE
	lifeexpectancy > 0
ORDER BY
	lifeexpectancy ASC
LIMIT
	15;

----------------------------------------------------------------------------
Which five countries have the lowest population density?

SELECT
	name,
	population,
	surfacearea,
	continent,
	population / surfacearea AS population_density
FROM
	countries
WHERE
	population > 0
ORDER BY
	population_density ASC
LIMIT
	5;

----------------------------------------------------------------------------
Which is the smallest country, by area and population? the 10 smallest countries, by area and population?

SELECT
	name,
	population,
	surfacearea,
	continent
FROM
	countries
WHERE
	population > 0
ORDER BY
	surfacearea
LIMIT
	1;

  SELECT
  	name,
  	population,
  	surfacearea,
  	continent
  FROM
  	countries
  WHERE
  	population > 0
  ORDER BY
  	population
  LIMIT
  	10;
----------------------------------------------------------------------------
Which is the biggest country, by area and population? the 10 biggest countries, by area and population?

SELECT
	name,
	population,
	surfacearea,
	continent
FROM
	countries
WHERE
	population > 0
ORDER BY
	surfacearea DESC
LIMIT
	10;

----------------------------------------------------------------------------
----------------------------------------------------------------------------
WITH

Of the smallest 10 countries, which has the biggest gnp? (hint: use with and max)

WITH smallest_countries AS

(SELECT
	name,
	surfacearea,
	gnp,
	population

FROM
	countries
WHERE
	population > 0
ORDER BY
	surfacearea ASC, population

LIMIT
	10)

SELECT
	MAX(gnp)
FROM
	smallest_countries;

----------------------------------------------------------------------------
Of the smallest 10 countries, which has the biggest per capita gnp?

WITH smallest_countries AS

(SELECT
	name,
	surfacearea,
	gnp,
	population

FROM
	countries
WHERE
	population > 0
ORDER BY
	surfacearea ASC

LIMIT
	10)

SELECT
	MAX(gnp / population)
FROM
	smallest_countries;

----------------------------------------------------------------------------
Of the biggest 10 countries, which has the biggest gnp?

WITH biggest_countries AS

(SELECT
	name,
	surfacearea,
	gnp,
	population

FROM
	countries
WHERE
	population > 0
ORDER BY
	surfacearea DESC

LIMIT
	10)

SELECT
	MAX(gnp)
FROM
	biggest_countries;

----------------------------------------------------------------------------
Of the biggest 10 countries, which has the biggest per capita gnp?
WITH biggest_countries AS

(SELECT
	name,
	surfacearea,
	gnp,
	population

FROM
	countries
WHERE
	population > 0
ORDER BY
	surfacearea DESC

LIMIT
	10)

SELECT
	MAX(gnp / population)
FROM
	biggest_countries;

----------------------------------------------------------------------------
What is the sum of surface area of the 10 biggest countries in the world? The 10 smallest?

WITH biggest_countries AS

(SELECT
	name,
	surfacearea,
	gnp,
	population

FROM
	countries
WHERE
	population > 0
ORDER BY
	surfacearea DESC

LIMIT
	10)

SELECT
	SUM(surfacearea)
FROM
	biggest_countries;

----------------------------------------------------------------------------
----------------------------------------------------------------------------

GROUP BY

How big are the continents in term of area and population?

SELECT
	continent,
	SUM(surfacearea) AS continent_area
FROM
	countries
GROUP BY
	continent;


  SELECT
	continent,
	SUM(population) AS continent_population
FROM
	countries
GROUP BY
	continent;

----------------------------------------------------------------------------

Which region has the highest average gnp?

WITH average_gnp AS
(SELECT
	region,
	AVG(gnp) AS avg_gnp
FROM
	countries
GROUP BY
	region)
SELECT
	max(avg_gnp)
FROM
	average_gnp

----------------------------------------------------------------------------
Who is the most influential head of state measured by population?

SELECT
	headofstate,
	SUM(population) AS total_population
FROM
	countries
GROUP BY
	headofstate
ORDER BY
	total_population DESC
LIMIT
	1;


----------------------------------------------------------------------------
Who is the most influential head of state measured by surface area?

SELECT
	headofstate,
	SUM(surfacearea) AS total_surface_area
FROM
	countries
GROUP BY
	headofstate
ORDER BY
	total_surface_area DESC
LIMIT
	1;

----------------------------------------------------------------------------
What are the most common forms of government? (hint: use count(*))

SELECT
	governmentform,
	count(governmentform) AS most_common
FROM
	countries
GROUP BY
	governmentform
ORDER BY
	most_common DESC


----------------------------------------------------------------------------
What are the forms of government for the top ten countries by surface area?


WITH biggest_countries AS
(
SELECT
	name,
	surfacearea,
	governmentform
FROM
	countries
ORDER BY
	surfacearea DESC
LIMIT
	10)

SELECT
	governmentform,
	count(name)
FROM
	biggest_countries
GROUP BY
	governmentform
ORDER BY
	count(name) DESC


----------------------------------------------------------------------------
Interesting...

Which countries are in the top 5% in terms of area?

SELECT
	name,
	surfacearea
FROM
	countries
ORDER BY
	surfacearea DESC
LIMIT
	(SELECT count(name) * .05 as top_five_p FROM countries)
