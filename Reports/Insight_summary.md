# 🔍 Exploratory Insights

## Q1: Show the first and last names of all customers

```sql
SELECT first_name, last_name FROM customer;
```

✅ Result: 599 customers listed

📌 Insight: Knowing who your customers are is the foundation for segmentation, marketing, and personalization strategies.

## Q2: List all cities in alphabetical order

```sql
SELECT city FROM city ORDER BY city ASC;
```

✅ Result: 600+ unique cities displayed

📌 Insight:Geographic diversity can inform regional marketing and logistics planning.

## Q3: Show all films with rental duration > 5 days

```sql
SELECT title FROM film WHERE rental_duration > 5;
```

✅ Result: Returns films more likely to be long-form or popular for extended viewing

📌 Insight: These films might warrant higher pricing tiers or extended promo periods.

## Q4: Display distinct film ratings

```sql
SELECT DISTINCT rating FROM film;
```

✅ Result: G, PG, PG-13, R, NC-17

📌 Insight: Understanding content classification helps target audiences and control inventory by age group.

# 👥 Customer Behavior

## Q1: Count active vs. inactive customers

```sql
SELECT active, COUNT(*) FROM customer GROUP BY active;
```

✅ Result: Active: 599 | Inactive: 0

📌 Insight: This system marks nearly all users as active. However, deeper engagement metrics should supplement this status.

## Q2: Top 10 customers by rental count

```sql
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS name, COUNT(r.rental_id) AS rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, name
ORDER BY rentals DESC
LIMIT 10;
```

✅ Result: Shows 10 customers with highest rental frequency

📌 Insight: High-frequency renters are potential VIPs—great for upselling, loyalty programs, or exclusive access.

## Q3: Average rentals per customer

```sql
SELECT ROUND(COUNT(*) * 1.0 / (SELECT COUNT(*) FROM customer), 2) AS avg_rentals_per_customer FROM rental;
```

✅ Result: ~11 rentals per customer on average

📌 Insight: A benchmark metric to evaluate customer engagement over time or between cohorts.

## Q4: Customers who haven’t rented in the last 6 months

```sql
SELECT customer_id, MAX(rental_date) AS last_rental
FROM rental
GROUP BY customer_id
HAVING MAX(rental_date) < CURRENT_DATE - INTERVAL '6 months';
```

✅ Result: 189 customers inactive

📌 Insight: These customers can be targeted for re-engagement campaigns.

# 💸 Revenue Analysis

## Q1: Total revenue generated

```SQL
SELECT SUM(amount) AS total_revenue FROM payment;
```

✅ Result: Total revenue: ~$61,000

📌 Insight: This forms your baseline revenue to measure per-store, per-category, and customer-level performance.

## Q2: Revenue by film category

```SQL
SELECT c.name AS category, SUM(p.amount) AS revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY revenue DESC;
```

✅ Result: Sports, Action, Sci-Fi top the list

📌 Insight: Categories that drive revenue should receive prime promotion or inventory prioritization.

## Q3: Top 10 films by revenue

```sql
SELECT f.title, SUM(p.amount) AS revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY revenue DESC
LIMIT 10;
```

✅ Result: Top films account for significant sales

📌 Insight: These titles are key profit drivers—bundle them or feature them in promotional content.

# 🎯 Advanced SQL Findings

## Q1: Rank customers by total payment

```sql
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS name, SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, name
ORDER BY total_paid DESC;
```

✅ Result: Ranks top-paying customers

📌 Insight: High spenders deserve VIP treatment and early-access deals.

## Q2: Rental count by city

```sql
SELECT ci.city, COUNT(r.rental_id) AS rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city
ORDER BY rentals DESC;
```

✅ Result: Most rentals from select urban hubs

📌 Insight: Focus inventory and marketing in high-rental cities for maximum impact.

## Q3: Most rented categories

```sql
SELECT c.name AS category, COUNT(*) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY total_rentals DESC;
```

✅ Result: Comedy and Sports dominate

📌 Insight: These categories should always be in stock and promoted to align with consumer demand.
