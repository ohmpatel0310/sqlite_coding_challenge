-- SQLite Coding Challenge — Task Queries
-- Tooling & validation:
--  - Queries authored for SQLite (ANSI-compatible). To validate, run
--    them with the `sqlite3` CLI or VS Code SQLTools against the provided
--    database (e.g. `sqlite3 mydb.sqlite < challenge.sql`) and inspect results.
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
