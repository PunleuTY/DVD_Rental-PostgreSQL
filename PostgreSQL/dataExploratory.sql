-- Show the first and last names of all customers. (Q1)
SELECT first_name, last_name FROM customer;

-- List all cities in alphabetical order. (Q2)
SELECT city FROM city ORDER BY city ASC;

-- Show all films with rental duration > 5 days. (Q3)
SELECT film FROM film WHERE rental_duration > 5;

-- Display distinct film ratings. (Q5)
SELECT DISTINCT rating  from film;

-- List all languages used in films. (Q9)
SELECT * from language;

-- Get the total number of customers. (Q7)
SELECT COUNT(*) Total_NumberOf_Customer FROM customer;

-- Find the average rental rate of all films. (Q8)
SELECT avg(rental_rate) Rental_Rate FROM film; 


