-- Count active vs. inactive customers.
--> Active
SELECT 
    COUNT(active) ActiveCustomer 
FROM customer;
--> Inactive
SELECT 
    COUNT(*) - COUNT(active) InactiveCustomer 
FROM customer;

-- Find customers with 10 most rentals.
SELECT c.customer_id as Customer_id, 
    CONCAT(c.first_name, ' ', c.last_name) as Customer_Name,
    COUNT(r.rental_id) as Rental_count 
FROM 
    customer c 
JOIN 
    rental r 
ON 
    c.customer_id = r.customer_id
GROUP BY 
    c.customer_id, Customer_Name
ORDER BY 
    Rental_count DESC
LIMIT 10;

-- Calculate average rentals per customer.
SELECT 
  c.customer_id AS Customer_ID,
  CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name,
  COUNT(r.rental_id) AS Total_Rentals,
  ROUND(COUNT(r.rental_id) * 1.0 / (
    SELECT COUNT(*) FROM customer
  ), 2) AS Avg_Rental_Per_Customer
FROM 
  customer c
JOIN 
  rental r ON c.customer_id = r.customer_id
GROUP BY 
  c.customer_id, Customer_Name
ORDER BY 
  Avg_Rental_Per_Customer DESC;

-- List customers who haven’t rented in 6 months.
SELECT CONCAT(c.first_name, ' ', c.last_name) as customer_name ,c.customer_id, MAX(r.rental_date) AS last_rental
FROM rental r FULL JOIN customer c ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING MAX(r.rental_date) < CURRENT_DATE - INTERVAL '6 months';


-- Top 5 customers by total payment amount.
SELECT CONCAT(c.first_name, ' ', c.last_name) as customer_name, c.customer_id, SUM(p.amount) AS total_paid
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_paid DESC
LIMIT 5;
