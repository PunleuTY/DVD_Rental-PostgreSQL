-- Rank customers by total payment amount.
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_payment DESC;

-- Show rental count by city.
SELECT 
    ci.city,
    COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city
ORDER BY rental_count DESC;

-- Find most rented categories.
SELECT 
    c.name AS category,
    COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY rental_count DESC;

-- Get customer payment percentiles.
SELECT 
    customer_id,
    total_payment,
    PERCENT_RANK() OVER (ORDER BY total_payment) AS payment_percentile
FROM (
    SELECT 
        p.customer_id,
        SUM(p.amount) AS total_payment
    FROM payment p
    GROUP BY p.customer_id
) sub;

-- Use CTE to filter high-value customers.
WITH customer_totals AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_payment
    FROM payment
    GROUP BY customer_id
)
SELECT 
    ct.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ct.total_payment
FROM customer_totals ct
JOIN customer c ON ct.customer_id = c.customer_id
WHERE ct.total_payment > 200
ORDER BY ct.total_payment DESC;
