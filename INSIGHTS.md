- **Tool / validation:** Ran `sqlite3 bais_sqlite_lab.db -header -column < challenge.sql` locally to execute Tasks 1–4 and inspect results.

- **Top customers (Task 1):** Jacob Foster, Ethan Gomez, Sophia Ahmed, Lucas Hale, and Emma Young are the top five spenders (lifetime spends ≈ 8722.67, 8206.19, 5471.57, 4438.25, 4409.83). Business interpretation: these five are high-value customers and likely good candidates for VIP retention programs or targeted promotions to protect and grow lifetime value.

- **Category revenue (Task 2, all orders):** Electronics dominates (~25,364.23), followed by Furniture (~12,712.00). Grocery and Stationery contribute only small amounts (~405.72 and ~319.24).

- **Category revenue (Task 2, Delivered only):** Electronics and Furniture remain top categories, but delivered-only revenue for Electronics (~13,616.93) and Furniture (~8,750.00) is materially lower — this suggests a noticeable share of non-Delivered orders across categories; ranking remains the same.

- **Employees above dept avg (Task 3):** 5 of 12 employees earn strictly above their department average (5/12). By department: Finance 1/2, IT 1/3, Marketing 1/2, Operations 1/2, Sales 1/3. This indicates a small set of employees earning above peers in each department — useful for compensation review, promotions, or retention focus.

- **Cities with Gold customers (Task 4):** Tampa has 4 Gold customers out of 4 total customers (100% Gold rate), the highest Gold count and rate. Other cities each have 1 total customer and 0 Golds. This strong concentration may reflect a small sample or a market-specific effect (e.g., Tampa may be a headquarters or high-income market); interpret cautiously.

- **Loyalty distribution by city (Task 4 extension):** Detailed counts: Tampa 4/4 Gold, Brandon 0/1 Gold, Clearwater 0/1, Lakeland 0/1, Orlando 0/1, Sarasota 0/1, St. Petersburg 0/1. The Tampa concentration stands out both in count and rate.

- **Notes & caveats:**
  - `o.status = 'Delivered'` is case-sensitive; I used that literal string for the Delivered-only variant. If your dataset uses different casing/labels, adjust accordingly.
  - Rounding (`ROUND(...,2)`) used for readability; raw numeric aggregates remain available if exact decimals are needed.
  - The queries exclude NULL-linked entities naturally (inner joins). If you want to include products or departments with zero sales/employees, switch to LEFT JOIN and coalesce aggregates.

- **Suggested next steps:**
  - Inspect non-Delivered orders to understand why they are not Delivered (Cancelled? Pending?) and whether revenue should be recognized.
  - Break down Electronics revenue by product to find top-selling SKUs and margin contributors.
  - SQL alternative to visualization: add `hire_date` filters to Task 3 (e.g., `WHERE hire_date >= '2020-01-01'`) to compare whether newer hires or veterans are more likely to be above-average earners.
