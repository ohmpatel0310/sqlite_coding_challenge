-- SQLite Coding Challenge — Task Queries
-- Tooling & validation:
--  - Queries authored for SQLite (ANSI-compatible). To validate, run
--    them with the `sqlite3` CLI or VS Code SQLTools against the provided
--    database (bais_sqlite_lab.db). Example:
--      sqlite3 bais_sqlite_lab.db -header -column < challenge.sql
--  - I include all order statuses here; any exclusions or filters are
--    documented in INSIGHTS.md when applicable.

-- TASK 1 — Top 5 Customers by Total Spend
-- Goal: Identify five customers with highest lifetime spend.
-- Data logic: compute line totals at item level (quantity * unit_price),
-- roll up to order, then to customer. Do not exclude orders by status.

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

-- TASK 3 — Employees Earning Above Their Department Average
-- Goal: List employees with salary > department average.
-- Output: first_name, last_name, department_name, employee_salary, department_average
-- Approach: pre-calculate department averages via a subquery (davg)
-- and join to each employee row, then filter where employee salary > dept avg.

SELECT
  e.first_name,
  e.last_name,
  d.name AS department_name,
  e.salary AS employee_salary,
  ROUND(davg.avg_salary, 2) AS department_average
FROM employees e
JOIN departments d ON e.department_id = d.id
JOIN (
  SELECT department_id, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department_id
) davg ON e.department_id = davg.department_id
WHERE e.salary > davg.avg_salary
ORDER BY d.name, e.salary DESC;

-- TASK 4 — Cities with the Most Loyal Customers
-- Goal: Rank cities by the count of Gold loyalty customers. Also provide
-- a loyalty-level distribution by city.

-- Primary: cities ranked by number of Gold customers
SELECT
  city,
  COUNT(*) AS gold_customer_count
FROM customers
WHERE loyalty_level = 'Gold'
GROUP BY city
ORDER BY gold_customer_count DESC, city;

-- Extension: loyalty distribution (Gold/Silver/Bronze) by city
SELECT
  city,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN loyalty_level = 'Gold' THEN 1 ELSE 0 END) AS gold_count,
  SUM(CASE WHEN loyalty_level = 'Silver' THEN 1 ELSE 0 END) AS silver_count,
  SUM(CASE WHEN loyalty_level = 'Bronze' THEN 1 ELSE 0 END) AS bronze_count
FROM customers
GROUP BY city
ORDER BY gold_count DESC, city;
