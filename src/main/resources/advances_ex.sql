--Advanced Exercises
--11. For each customer, find the total number of rentals they made in the year 2005.

SELECT customer_id, count(*) AS rentals_2005
FROM rental
WHERE EXTRACT(YEAR FROM rental_date) = 2005
GROUP BY customer_id;

--12. Calculate the average rental duration in days for all rentals made in 2005.

SELECT AVG(EXTRACT(DAY FROM (return_date - rental_date))) AS days
FROM rental
WHERE EXTRACT(YEAR FROM rental_date) = 2005;

--13. Find the month in 2005 with the highest number of rentals.
SELECT TO_CHAR(rental_date, 'Mon') AS month, SUM(rental_id) AS rents
FROM rental
WHERE EXTRACT(YEAR FROM rental_date) = 2005
GROUP BY month
ORDER BY  rents DESC
    LIMIT 1;

--14. For each customer, find their last rental date in 2005 and format it as "Month DD, YYYY".
SELECT customer_id, TO_CHAR((SELECT rental_date
                             FROM rental r2
                             WHERE EXTRACT(YEAR FROM rental_date) = 2005
                               AND r2.customer_id = r1.customer_id
                             ORDER BY rental_date DESC
    LIMIT 1
    ),'Month DD, YYYY') AS last_rental_date
FROM rental r1
GROUP BY customer_id
ORDER BY customer_id;

-- last rental date in 2005 for customer with id = 19
SELECT rental_date
FROM rental r2
WHERE EXTRACT(YEAR FROM rental_date) = 2005
  AND customer_id = 19
ORDER BY rental_date DESC
    LIMIT 1;

--15. Count the number of rentals made on the first day of each month in 2005.
SELECT TO_CHAR(rental_date, 'DD MON'), SUM(rental_id) AS rents
FROM rental
WHERE EXTRACT(YEAR FROM rental_date) = 2005
  AND EXTRACT(DAY FROM rental_date) = 01
GROUP BY TO_CHAR(rental_date, 'DD MON')
ORDER BY rents DESC ;
