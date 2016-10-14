What languages are spoken in the 20 poorest (GNP/ capita) countries in the world? Hint: Use DISTINCT to remove duplicates

WITH poorest AS
(
SELECT DISTINCT
	c.code AS code,
	c.name AS name,
	c.gnp / c.population AS gnp_per_capita

FROM
	countries c JOIN countrylanguages cl ON c.code = cl.countrycode
WHERE
	c.gnp > 0
AND
	c.population > 0
ORDER BY
	gnp_per_capita ASC

LIMIT
	20)
SELECT
	cl.language
FROM
	poorest p JOIN countrylanguages cl ON p.code = cl.countrycode
GROUP BY
	cl.language

-------------------------------------------------------------------------------
Are there any countries without an official language?
WITH official AS
(
SELECT
	c.code AS code,
	c.name AS name,
	cl.isofficial,
	cl.language

FROM
	countries c JOIN countrylanguages cl ON c.code = cl.countrycode
WHERE
	cl.isofficial = 't'),

unofficial AS
(
SELECT
	c.code AS code,
	c.name AS name,
	cl.isofficial,
	cl.language

FROM
	countries c JOIN countrylanguages cl ON c.code = cl.countrycode
WHERE
	cl.isofficial = 'f')
SELECT unofficial.name FROM unofficial
EXCEPT
SELECT official.name FROM official

-------------------------------------------------------------------------------

What are the cities in the countries with no official language?

WITH official AS
(
SELECT
	c.code AS code,
	c.name AS name,
	cl.isofficial,
	cl.language

FROM
	countries c JOIN countrylanguages cl ON c.code = cl.countrycode
WHERE
	cl.isofficial = 't'),

unofficial AS
(
SELECT
	c.code AS code,
	c.name AS name,
	cl.isofficial,
	cl.language

FROM
	countries c JOIN countrylanguages cl ON c.code = cl.countrycode
WHERE
	cl.isofficial = 'f'),
no_language AS
(
SELECT unofficial.name, unofficial.code AS code FROM unofficial
EXCEPT
SELECT official.name, official.code FROM official)
SELECT
	c.name
FROM
	no_language nl JOIN cities c ON nl.code = c.countrycode

-------------------------------------------------------------------------------
Which languages are spoken in the ten largest (area) countries?


WITH top_ten AS
(SELECT DISTINCT
	surfacearea,
	name,
	code
FROM
	countries
ORDER BY
	surfacearea DESC
LIMIT
	10)
SELECT DISTINCT
	cl.language
FROM
	top_ten t JOIN countrylanguages cl ON t.code = cl.countrycode



-------------------------------------------------------------------------------
What is the total population of cities where English is the official language? Spanish? Hint: The official language of a city is based on country.

WITH english_countries AS
(
SELECT
	c.code AS code,
	c.name,
	cl.language
FROM
	countries c JOIN countrylanguages cl ON c.code = cl.countrycode
WHERE
	cl.language = 'English'
AND
	cl.isofficial = 't'
)
SELECT
	SUM(population)
FROM
	english_countries ec JOIN cities ct ON ec.code = ct.countrycode


-------------------------------------------------------------------------------
How many countries have no cities? --7


SELECT
	code,
	name
FROM
	countries

EXCEPT


SELECT
	c.code,
	c.name
FROM
	countries c JOIN cities ct ON c.code = ct.countrycode

-------------------------------------------------------------------------------
Which countries have the 100 biggest cities in the world?

WITH biggest_cities AS
(
SELECT
	countrycode,
	name,
	population
FROM
	cities
ORDER BY
	population DESC
LIMIT
	100)
SELECT DISTINCT
	c.name,
	c.code
FROM
	biggest_cities bc JOIN countries c ON bc.countrycode = c.code

-------------------------------------------------------------------------------
What languages are spoken in the countries with the 100 biggest cities in the world?

WITH biggest_cities AS
(
SELECT
	countrycode,
	name,
	population
FROM
	cities
ORDER BY
	population DESC
LIMIT
	100),
top_countries AS
(
SELECT DISTINCT
	c.name AS name,
	c.code AS code
FROM
	biggest_cities bc JOIN countries c ON bc.countrycode = c.code)


SELECT DISTINCT

	cl.language
FROM
	top_countries tc JOIN countrylanguages cl ON tc.code = cl.countrycode

-------------------------------------------------------------------------------
Which country or countries have the most official languages?


SELECT
	COUNT(cl.language) AS count,
	c.name AS name

FROM
	countrylanguages cl JOIN countries c ON cl.countrycode = c.code

WHERE
	cl.isofficial = 't'

GROUP BY
	c.name

ORDER BY
	count DESC

-------------------------------------------------------------------------------
Which country or countries speak the most languages?


SELECT
	COUNT(cl.language) AS count,
	c.name AS name

FROM
	countrylanguages cl JOIN countries c ON cl.countrycode = c.code

GROUP BY
	c.name

ORDER BY
	count DESC

-------------------------------------------------------------------------------
Which countries have the highest proportion of official language speakers? The lowest?

SELECT
	cl.percentage,
	cl.countrycode,
	cl.isofficial,
	c.name
FROM
	countrylanguages cl JOIN countries c ON cl.countrycode = c.code
WHERE
	isofficial = 't'
ORDER BY
	percentage DESC

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
What languages are spoken in the United States? (12) Brazil? (not Spanish...) Belgium? (6)

SELECT
	cl.language
FROM
	countrylanguages cl JOIN countries c ON cl.countrycode = c.code
WHERE
	c.name = 'United States'


-------------------------------------------------------------------------------

What are the cities of the US? (274) India? (341)
SELECT
	ct.name
FROM
	cities ct JOIN countries c ON ct.countrycode = c.code
WHERE
	c.name = 'United States'

-------------------------------------------------------------------------------
What are the official languages of Belgium?

-------------------------------------------------------------------------------
What are the languages spoken in the countries with no official language?

-------------------------------------------------------------------------------
What is the most spoken language in the world?

-------------------------------------------------------------------------------
What is the population of the United States? What is the city population of the United States?
-------------------------------------------------------------------------------
What is the population of the India? What is the city population of the India?
