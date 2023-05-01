-- создание БД
CREATE DATABASE shop;

USE shop;

-- создание таблиц
CREATE TABLE categories
(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(50) NOT NULL
);

CREATE TABLE products
(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(50) NOT NULL,
	price DECIMAL(8, 2) NOT NULL,
	category_id INT NOT NULL,
	FOREIGN KEY (category_id) REFERENCES categories(id)
		ON UPDATE CASCADE
);

-- вставка данных в таблицы
INSERT INTO categories(id, name)
VALUES (1, 'Хлебобулочные изделия'),
	(2, 'Молочные изделия'),
	(3, 'Напитки');

INSERT INTO products(name, price, category_id)
VALUES ('Батон', 40, 1),
	('Хлеб', 30.5, 1), 
	('Сыр', 120.5, 2), 
	('Молоко', 80, 2), 
	('Сок', 70.5, 3), 
	('Газировка', 60, 3);

-- сменить название с "Батон" на "Булка", цену с 40 на 45
UPDATE products
SET name = 'Булка', price = 45
WHERE id = 1;

-- удалить продукты с ценой более 100
DELETE FROM products
WHERE price > 100;

-- вывод даты отдельными полями день, месяц, год
SELECT name,
	DAY(date) AS day,
	MONTH(date) AS month,
	YEAR(date) AS year
FROM products;

-- вывод количества товаров в каждый год
SELECT YEAR(date) AS year, COUNT(date) AS amount
FROM products
GROUP BY YEAR(date)
ORDER BY year;