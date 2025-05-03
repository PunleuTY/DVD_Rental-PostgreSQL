
-- Calculate total revenue.
SELECT SUM(amount) AS total_revenue FROM payment;

-- Analyze monthly revenue trends.
SELECT DATE_TRUNC('month', payment_date) AS month, SUM(amount) AS revenue
FROM payment
GROUP BY month
ORDER BY month;

-- Find revenue per store.
SELECT store_id, SUM(amount) AS store_revenue
FROM payment
JOIN staff USING(staff_id)
GROUP BY store_id;

-- Top 10 films by revenue.
SELECT 
    f.title AS Film_Title,
    SUM(p.amount) AS Total_Revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Compare revenue by category.
SELECT 
    c.name AS Category,
    SUM(p.amount) AS Total_Revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY Total_Revenue DESC;
