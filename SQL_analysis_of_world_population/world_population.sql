create database project;
use  project;
DESCRIBE world_population;

use  project;
-- Rename the columns
ALTER TABLE world_population1 CHANGE column`World Population Percentage`  `world_population_percentage` double;
ALTER TABLE world_population1 CHANGE column `Area (kmÂ²)`  `area` int;
ALTER TABLE world_population1 CHANGE column`Country/Territory`  `country` varchar (100);
ALTER TABLE world_population1 CHANGE column`Growth Rate`  `growth_rate` double;
ALTER TABLE world_population1 CHANGE column `Density (per kmÂ²)`  `pop_density` double;
ALTER TABLE world_population1 
CHANGE column  `2022 Population` `2022_population` int,
CHANGE column `2020 Population`  `2020_population` int,
CHANGE column`2015 Population`  `2015_population` int,
CHANGE column `2010 Population`  `2010_population` int,
CHANGE column`2000 Population`  `2000_population` int,
CHANGE column `1990 Population`  `1990_population` int,
CHANGE column `1980 Population`  `1980_population` int,
CHANGE column`1970 Population`  `1970_population` int,
CHANGE column`CCA3` `cca3` varchar(100),
CHANGE column`Capital` `capital_city` varchar(100);
ALTER TABLE world_population CHANGE COLUMN `Rank` `Rank_` INT;

-- Find the country, capital city and continent from the table
SELECT country, MAX(capital_city) AS capital_city, Continent
FROM world_population
WHERE Continent IS NOT NULL
GROUP BY country, Continent
ORDER BY country DESC
LIMIT 0, 1000;

-- Find the distinct countries
SELECT count(DISTINCT(country)) as Number_of_countries FROM world_population
WHERE country IS NOT NULL;

-- Find the distinct continents
SELECT COUNT(DISTINCT continent) AS continents
FROM world_population;

-- Find the average population of each continent in 2022
SELECT continent, ROUND(AVG(2022_population),2) AS avg_population
FROM world_population
GROUP BY continent
ORDER BY avg_population DESC;

-- Find the highest and lowest population in 2022
SELECT MAX(2022_population) AS max_population_2022,
MIN(2022_population) AS min_population_2022
FROM world_population;

-- Find the countries with the highest and lowest population in 1970
SELECT MAX(1970_population) AS max_population_1970,country
FROM world_population
WHERE continent IS NOT NULL
group by country
order by max_population_1970 desc
limit 10;

SELECT MIN(1970_population) AS min_population_1970, country 
FROM world_population 
GROUP BY country
ORDER BY min_population_1970 ASC
LIMIT 10;

-- Find the population of North America with a capital city called The Valley in the year 2022
SELECT continent, 2022_population
FROM world_population
WHERE continent = "North America"
AND capital_city = "The Valley";

-- Find the top 10  populated countries in 2022
SELECT country, MAX(2022_population) AS highest_population
FROM world_population
GROUP BY country
ORDER BY 2022_population DESC
LIMIT 10;

-- Find the bottom 10 populated countries in 2022
SELECT country, MIN(2022_population) AS lowest_population
FROM world_population
GROUP BY country
ORDER BY lowest_population ASC
LIMIT 10;

-- Find the countries whose total population is greater than the average population

WITH cte AS (SELECT AVG(2022_population) AS avg_population FROM world_population)
SELECT 2022_population, country 
FROM world_population
WHERE 2022_population > (SELECT avg_population FROM cte) 
ORDER BY 2022_population DESC;

-- Find the number of countries whose population is less than the highest population in 2022
SELECT COUNT(country)
FROM world_population
 WHERE 2022_population < (SELECT MAX(2022_population)FROM world_population);
 
 -- Find the average population and area of the year 2020
SELECT AVG(2020_population) AS avg_population, AVG(area) AS avg_area
FROM world_population
WHERE continent IS NOT NULL;

-- Finding the most dense populated countries in 2022
SELECT country, 2022_population, area
FROM world_population
WHERE 2022_population > (SELECT AVG(2022_population)FROM world_population) AND area < (SELECT AVG(area)FROM world_population);

-- Find the rank and dense rank of countries population in the year 2015 
SELECT country,2022_population,
rank() OVER (ORDER BY 2022_population DESC),
dense_rank() OVER (ORDER BY 2022_population DESC)
FROM world_population
LIMIT 10;

-- Find the highest and minimum population growth rate
SELECT MAX(growth_rate) AS max_pop_growth,
	   MIN(growth_rate) AS min_pop_growth 
FROM world_population;

-- Find the largest and smallest area
SELECT MAX(area) AS max_area,MIN(area) AS min_area FROM world_population;
  
-- Find the country with the smallest area
SELECT country, min(area) as area FROM world_population;

-- Create a new field of area sizes. Return the country, continent, country code and area. Order them in descending order.
SELECT country, continent, cca3, area,
    CASE WHEN area > 2000000
            THEN 'large'
	   WHEN area > 40000
            THEN 'medium'
	   ELSE 'small' END
       as area_size_group
FROM world_population;




