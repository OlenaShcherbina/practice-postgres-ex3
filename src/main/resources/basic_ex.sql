--Basic Exercises
--1. Using the customer table, extract the year from the create_date column for all customers.

SELECT EXTRACT(YEAR FROM create_date) AS year_creation, first_name, last_name
FROM customer;

--2. From the rental table, extract the month and year from the rental_date column.
SELECT rental_date, EXTRACT(YEAR FROM rental_date)AS year, EXTRACT(MONTH FROM rental_date) AS month
FROM rental
ORDER BY year DESC;

--3. Use TO_CHAR to format the last_update timestamp in the customer table as "Month DD, YYYY".
SELECT TO_CHAR(last_update, 'Month DD, YYYY') AS formatted, customer_id, last_update
FROM customer;

--4. Calculate the age of each customer as of today using the create_date from the customer table.
SELECT last_name, first_name, (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM create_date)) AS age
FROM customer;

--5. Find the day of the week (as a string) with the most rentals from the rental table.

SELECT TO_CHAR(rental_date, 'Dy') AS day_of_week, count(rental_id) AS rentals
FROM rental
GROUP BY day_of_week
ORDER BY rentals DESC ;