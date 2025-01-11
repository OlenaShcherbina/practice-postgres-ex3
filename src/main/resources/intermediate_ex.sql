--Intermediate Exercises
--6. (Advanced) For each customer in the customer table, calculate how many days have passed
-- since their create_date until the last rental_date in the rental table. (Hint: here)


--last rental date for particular customer
SELECT rental_date
FROM rental
WHERE customer_id = 1
ORDER BY rental_date DESC
    LIMIT 1;


--solution
SELECT last_name, first_name, EXTRACT(DAY FROM((SELECT rental_date
                                                FROM rental r1
                                                WHERE r1.customer_id = c.customer_id
                                                ORDER BY rental_date DESC
                                      LIMIT 1) - create_date)) AS days
FROM customer c
         JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY c.customer_id;


--7. Find the average rental duration in days and hours for each customer using the rental table.
SELECT (EXTRACT(DAY FROM AVG(return_date - rental_date)) || ' d, ' || EXTRACT(HOUR FROM AVG(return_date - rental_date)) || ' hr') AS avg_duration,
       first_name, last_name
FROM customer
         JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY rental.customer_id, first_name, last_name;
--8. Use TO_CHAR to display the rental_date and return_date from the rental table in the format "Day, DD Mon YYYY at HH24:MI:SS".
SELECT TO_CHAR(rental_date, 'Day, DD Mon YYYY at HH24:MI:SS') AS rental_date,
       TO_CHAR(return_date, 'Day, DD Mon YYYY at HH24:MI:SS') AS return_date,
       rental_id AS id
FROM rental
ORDER BY id DESC;

--9. For each month in 2005, count the number of rentals and format the month as "Mon YYYY" using TO_CHAR.
SELECT count(rental_id) AS rentals, TO_CHAR(rental_date, 'Mon YYYY') AS month
FROM rental
WHERE EXTRACT(YEAR FROM rental_date)= 2005
GROUP BY month;

--10.(Advanced) Find the customers who have rented movies on weekends more often than on weekdays. (Hint: here)

--count rented movies for each customer on weekends
SELECT customer_id, count(*) AS rents
FROM rental
WHERE EXTRACT(dow FROM rental_date) = 0
   OR EXTRACT(dow FROM rental_date) = 6
GROUP BY customer_id
ORDER BY rents DESC;

--count rented movies for each customer on weekdays
SELECT customer_id, count(*) AS rents
FROM rental
WHERE EXTRACT(dow FROM rental_date) != 0
   OR EXTRACT(dow FROM rental_date) != 6
GROUP BY customer_id
ORDER BY customer_id;

--select rents on weekends and rents on weekdays for each customer

SELECT r1.customer_id, (SELECT count(*)
                        FROM rental r2
                        WHERE r1.customer_id = r2.customer_id AND
                            (EXTRACT(dow FROM rental_date) = 0
                                OR EXTRACT(dow FROM rental_date) = 6)
) AS rents_weekend,
       (SELECT count(*)
        FROM rental r2
        WHERE r1.customer_id = r2.customer_id AND
            EXTRACT(dow FROM rental_date) != 0
        OR EXTRACT(dow FROM rental_date) != 6

        ) AS rents_days
FROM rental r1
GROUP BY r1.customer_id;

--solution

SELECT r1.customer_id, count(*) AS rents
FROM rental r1
WHERE (SELECT count(*)
       FROM rental r2
       WHERE r2.customer_id = r1.customer_id
         AND (
           EXTRACT(dow FROM rental_date) = 0
               OR EXTRACT(dow FROM rental_date) = 6)
      ) - (SELECT count(*)
           FROM rental r2
           WHERE r2.customer_id = r1.customer_id AND
               (EXTRACT(dow FROM rental_date) != 0
                            OR EXTRACT(dow FROM rental_date) != 6)
      ) > 0
GROUP BY r1.customer_id;

--solution using CASE

SELECT customer_id,
       CASE WHEN (SELECT count(*)
                  FROM rental r2
                  WHERE r2.customer_id = r1.customer_id
                    AND (
                      EXTRACT(dow FROM rental_date) = 0
                          OR EXTRACT(dow FROM rental_date) = 6)
                 ) - (SELECT count(*)
                      FROM rental r2
                      WHERE r2.customer_id = r1.customer_id AND
                          (EXTRACT(dow FROM rental_date) != 0
                         OR EXTRACT(dow FROM rental_date) != 6)
                 ) > 0 THEN true
            ELSE false
           END AS weekends
FROM rental r1
GROUP BY r1.customer_id;