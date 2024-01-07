

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT max(length) as max_duration , min(length) as min_duration
FROM film ;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.







-- 2.1 Calculate the number of days that the company has been operating.

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM rental;


-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select *,  DATE_FORMAT(rental_date, '%M') as Rental_Month, DATE_FORMAT(rental_date, '%W') as Rental_Weekday
from rental
limit 20;



-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT 
    *,
    DATE_FORMAT(rental_date, '%W') as Rental_Weekday,
    CASE 
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'Weekday'
        ELSE 'Weekend'
    END AS Date_type 
FROM 
    rental
LIMIT 20;


-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    title,
    CASE 
        WHEN rental_duration IS NULL THEN 'Not Available'
        ELSE rental_duration
    END AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;


-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT Concat(first_name," ",last_name), left (email,3)
FROM customer
Order by last_name asc ;





-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT Count(release_year)
from film ;





--  1.2 The number of films for each rating.
SELECT  distinct rating , Count(title)
from film 
group by rating;


-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT  distinct rating , Count(title) as movie_count
from film 
group by rating
order by movie_count desc ;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT distinct rating , round(avg(length),2 ) as avg_duration
from film
group by rating
order by avg_duration desc;


-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT distinct rating , round(avg(length),2 ) as avg_duration
from film
group by rating 
having avg_duration > 120;



-- Bonus: determine which last names are not repeated in the table actor.

SELECT distinct last_name
from customer;