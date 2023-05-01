--Вывести все страны вместе с количеством городов
SELECT countryCode, COUNT(countryCode)
FROM city
GROUP BY countryCode;

--Вывести все страны вместес количеством городов, оставить только страны, в которых не менее 2-х городов
SELECT countryCode, COUNT(countryCode)
FROM city
GROUP BY countryCode
HAVING COUNT(countryCode) >= 2;

--Вывести все страны вместес количеством городов, в которых не менее 1 млн человек, оставить только страны, в которых не менее 2-х таких городов
SELECT countryCode, COUNT(countryCode)
FROM city
WHERE Population >= 1000000
GROUP BY countryCode
HAVING COUNT(countryCode) >= 2;

--Найти среднюю численность населения городов по каждой стране, вывести в порядке убывания средней численности
SELECT countryCode, AVG(population) AS averagePopulation
FROM city
GROUP BY countryCode
ORDER BY averagePopulation DESC;

--Вывести все строки, но только столбцы имя и дистрикт
SELECT name, district
FROM city;

--Выведите только города из России, отсортируйте по имени
SELECT * FROM city
WHERE countryCode = 'RUS'
ORDER BY name;

--Выведите города из Испании, Португалии и Греции, отсортируйте по имени по убыванию
SELECT * FROM city
WHERE countryCode IN ('ESP', 'PRT', 'GRC')
ORDER BY name DESC;

--Вывести города, у которых население лежит в диапазоне от 300000 до 500000
SELECT name 
FROM city
WHERE Population BETWEEN 300000 AND 500000;

--Вывести города, начинающиеся с буквы "А"
SELECT name 
FROM city
WHERE name LIKE 'a%';

--Вывести города, содержащие букву "А"
SELECT name 
FROM city
WHERE name LIKE '%a%';

--Вывести города из России с начелением не менее 1 млн
SELECT name 
FROM city
WHERE countryCode = 'RUS' AND population >= 1000000;

--Вывести города из Испании, начинающиеся с буквы "А" и города из Греции с численностью до 200000 человек
SELECT name 
FROM city
WHERE (countryCode = 'ESP' AND name LIKE 'a%') OR (countryCode = 'GRC' AND Population < 200000);

--Выведите страны в порядке убывания длины названия. Пусть название страны будет в верхнем регистре, а название континента - в нижнем
SELECT UPPER(name), LOWER(continent), CHAR_LENGTH(name)
FROM country
ORDER BY CHAR_LENGTH(name) DESC;

--Для каждой страны найдите радиус окружности, у которой площадь круга такая же, как площадь этой страны. Отсортируйте результат по убыванию радиуса
SELECT name, SQRT(SurfaceArea / PI()) AS radius
FROM country
ORDER BY radius DESC;

--Вывести все страны вместе с количеством городов
SELECT countryCode, COUNT(countryCode)
FROM city
GROUP BY countryCode;

--Вывести все страны вместес количеством городов, оставить только страны, в которых не менее 2-х городов
SELECT countryCode, COUNT(countryCode)
FROM city
GROUP BY countryCode
HAVING COUNT(countryCode) >= 2;

--Вывести все страны вместес количеством городов, в которых не менее 1 млн человек, оставить только страны, в которых не менее 2-х таких городов
SELECT countryCode, COUNT(countryCode)
FROM city
WHERE Population >= 1000000
GROUP BY countryCode
HAVING COUNT(countryCode) >= 2;

--Найти среднюю численность населения городов по каждой стране, вывести в порядке убывания средней численности
SELECT countryCode, AVG(population) AS averagePopulation
FROM city
GROUP BY countryCode
ORDER BY averagePopulation DESC;