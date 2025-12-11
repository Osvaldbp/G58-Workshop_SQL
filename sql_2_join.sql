# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
#
SELECT name
FROM city
WHERE name LIKE 'ping%'
ORDER BY Population ASC;
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
#
SELECT name
FROM city
WHERE name LIKE 'ran%'
ORDER BY Population DESC;
#
# 3: Count all cities
#
SELECT COUNT(*)
FROM city
#
# 4: Get the average population of all cities
#
SELECT AVG (Population)
FROM city
#
# 5: Get the biggest population found in any of the cities
#
SELECT *
FROM city
ORDER BY Population DESC
LIMIT 1;
#
# 6: Get the smallest population found in any of the cities
#
SELECT *
FROM city
ORDER BY Population ASC
LIMIT 1;
#
# 7: Sum the population of all cities with a population below 10000
#
// I noticed if you have space between SUM() it wont work
SELECT SUM(Population)
FROM city
WHERE Population < 10000
#
# 8: Count the cities with the countrycodes MOZ and VNM
#
SELECT COUNT(*)
FROM city
WHERE CountryCode IN ('MOZ', 'VNM')
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
#
SELECT COUNT(*)
FROM city
WHERE CountryCode IN ('MOZ', 'VNM')
GROUP BY CountryCode
#
# 10: Get average population of cities in MOZ and VNM
#
SELECT AVG(Population)
FROM city
WHERE CountryCode IN ('MOZ', 'VNM')
GROUP BY CountryCode
#
# 11: Get the countrycodes with more than 200 cities
#
SELECT CountryCode, COUNT(*)
FROM city
GROUP BY CountryCode
HAVING COUNT(*) > 200
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
#
SELECT CountryCode, COUNT(*) AS city_count
FROM city
GROUP BY CountryCode
HAVING COUNT(*) > 200
ORDER BY city_count DESC
#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
#
SELECT c.name, cl.language
FROM (
SELECT *
FROM city
WHERE Population BETWEEN 400 AND 500
) AS c
JOIN countrylanguage cl ON c.CountryCode = cl.CountryCode
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
#
SELECT c.name, cl.language
FROM (
SELECT *
FROM city
WHERE Population BETWEEN 500 AND 600
) AS c
JOIN countrylanguage cl ON c.CountryCode = cl.CountryCode
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
#
SELECT c2.name
FROM city AS c1
JOIN city AS c2 ON c1.CountryCode = c2.CountryCode
WHERE c1.Population = 122199;
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
#
SELECT c2.name
FROM city AS c1
JOIN city AS c2 ON c1.CountryCode = c2.CountryCode
WHERE c1.Population = 122199
AND c2.Population <> 122199;
#
# 17: What are the city names in the country where Luanda is capital?
#
SELECT c.name
FROM city c
JOIN country co ON c.CountryCode = co.Code
JOIN city cap ON co.Capital = cap.ID
WHERE cap.name ='Luanda';
// the cities are Huambo, Lobito, Benguela and Namibe.
#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
#
SELECT cap.name AS Capital
FROM country co
JOIN city cap ON co.Capital = cap.ID
WHERE co.Region = (
SELECT co2.Region
FROM country co2
JOIN city c2 ON co2.Code = c2.CountryCode
WHERE c2.name ='Yaren'
);
// the capital cities are Palikir, Agana, Bairiki, Dalap-Uliga-Darrit, Garapan and koror
#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga
#
SELECT DISTINCT cl.language
FROM country co
JOIN countrylanguage cl ON co.Code = cl.CountryCode
JOIN city c ON c.CountryCode = co.Code
WHERE c.name ='Riga';
// Belorussian, Latvian, Lithuanian, Polish, Russian and Ukrainian
#
# 20: Get the name of the most populous city
#
SELECT Population, city.name
FROM city
ORDER BY Population DESC
LIMIT 1
// Mumbai(Bombay)