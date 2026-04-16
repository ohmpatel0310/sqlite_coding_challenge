-- TASK 1 — Top 5 Customers by Total Spend

SELECT
	c.first_name || ' ' || c.last_name AS customer_full_name,
	ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spend
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id
ORDER BY total_spend DESC
LIMIT 5;

