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

-- TASK 2 — Total Revenue by Product Category (all orders)

SELECT
	p.category AS category,
	ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM products p
JOIN order_items oi ON oi.product_id = p.id
JOIN orders o ON oi.order_id = o.id
GROUP BY p.category
ORDER BY revenue DESC;

-- TASK 2 (Variant) — Total Revenue by Product Category (Delivered orders only)

SELECT
	p.category AS category,
	ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM products p
JOIN order_items oi ON oi.product_id = p.id
JOIN orders o ON oi.order_id = o.id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY revenue DESC;

