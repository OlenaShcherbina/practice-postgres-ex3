# PostgreSQL Date/Time Functions Practice Exercises

## Basic Exercises

1. Using the `customer` table, extract the year from the `create_date` column for all customers.

2. From the `rental` table, extract the month and year from the `rental_date` column.

3. Use TO_CHAR to format the `last_update` timestamp in the `customer` table as "Month DD, YYYY".

4. Calculate the age of each customer as of today using the `create_date` from the `customer` table.

5. Find the day of the week (as a string) with the most rentals from the `rental` table.

## Intermediate Exercises

6. (Advanced) For each customer in the `customer` table, calculate how many days have passed since their `create_date` until the last `rental_date` in the `rental` table.
   (Hint: [here](https://www.w3schools.com/postgresql/postgresql_inner_join.php))

7. Find the average rental duration in days and hours for each customer using the `rental` table.

8. Use TO_CHAR to display the `rental_date` and `return_date` from the `rental` table in the format "Day, DD Mon YYYY at HH24:MI:SS".

9. For each month in 2005, count the number of rentals and format the month as "Mon YYYY" using TO_CHAR.

10. (Advanced) Find the customers who have rented movies on weekends more often than on weekdays.
    (Hint: [here](https://www.w3schools.com/postgresql/postgresql_case.php))

## Advanced Exercises

11. For each customer, find the total number of rentals they made in the year 2005.

12. Calculate the average rental duration in days for all rentals made in 2005.

13. Find the month in 2005 with the highest number of rentals.

14. For each customer, find their last rental date in 2005 and format it as "Month DD, YYYY".

15. Count the number of rentals made on the first day of each month in 2005.
