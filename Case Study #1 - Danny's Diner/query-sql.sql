/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
-- 2. How many days has each customer visited the restaurant?
-- 3. What was the first item from the menu purchased by each customer?
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- 5. Which item was the most popular for each customer?
-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
-- 11. Recreate the table provided.
-- 12. Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.

-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
 s.customer_id,
 SUM(price) AS total_spent
FROM dannys_diner.sales AS s 
INNER JOIN dannys_diner.menu AS m 
ON s.product_id = m.product_id
GROUP BY 1
ORDER BY 1;

--Result:
+──────────────+──────────────+
| customer_id  | total_spent  |
+──────────────+──────────────+
| A            | 76           |
| B            | 74           |
| C            | 36           |
+──────────────+──────────────+

-- 2. How many days has each customer visited the restaurant?
SELECT
 customer_id,
 COUNT(DISTINCT order_date) AS num_of_days
FROM dannys_diner.sales
GROUP BY 1
ORDER BY 1;

--Result:
+──────────────+───────────────+
| customer_id  | num_of_days   |
+──────────────+───────────────+
| A            | 4             |
| B            | 6             |
| C            | 2             |
+──────────────+───────────────+

-- 3. What was the first item from the menu purchased by each customer?
WITH ordered_sales AS (
SELECT
 s.customer_id,
 m.product_name,
RANK() OVER (
 PARTITION BY customer_id
 ORDER BY order_date
) AS order_rank
FROM dannys_diner.sales AS s 
INNER JOIN dannys_diner.menu AS m 
ON s.product_id = m.product_id
)
SELECT 
 DISTINCT customer_id,
 product_name
FROM ordered_sales
WHERE order_rank = 1;

--Result:
+──────────────+───────────────+
| customer_id  | product_name  |
+──────────────+───────────────+
| A            | curry         |
| A            | sushi         |
| B            | curry         | 
| C            | ramen         |
+──────────────+───────────────+

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
WITH ordered_products AS (
SELECT
m.product_name,
s.product_id,
RANK() OVER (
 ORDER BY SUM(m.price) DESC
) AS product_rank
FROM dannys_diner.sales AS s 
INNER JOIN dannys_diner.menu AS m 
ON s.product_id = m.product_id
GROUP BY 1,2
),
count_of_products AS (
SELECT 
product_id,
COUNT(product_id) AS times_ordered
FROM dannys_diner.sales
GROUP BY 1
)
SELECT 
o.product_name,
c.times_ordered
FROM ordered_products AS o 
INNER JOIN count_of_products AS c 
ON o.product_id = c.product_id
WHERE product_rank = 1;

--Result:
+───────────────+───────────────+
| product_name  | times_ordered |
+───────────────+───────────────+
| ramen         | 8             |
+───────────────+───────────────+

--Alternative Solution
SELECT
 m.product_name,
 COUNT(s.*) AS times_ordered
FROM dannys_diner.sales AS s 
INNER JOIN dannys_diner.menu AS m 
ON s.product_id = m.product_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- 5. Which item was the most popular for each customer?
WITH popular_rank AS (
SELECT
 s.customer_id,
 m.product_name,
 COUNT(s.*) AS times_ordered,
 RANK() OVER (
  PARTITION BY customer_id
  ORDER BY COUNT(s.product_id) DESC
 ) AS rnk
FROM dannys_diner.sales AS s 
INNER JOIN dannys_diner.menu AS m 
ON s.product_id = m.product_id
GROUP BY 1,2
)
SELECT 
 customer_id,
 product_name,
 times_ordered
FROM popular_rank
WHERE rnk = 1;

--Result:
+──────────────+───────────────+───────────────+
| customer_id  | product_name  | times_ordered |
+──────────────+───────────────+───────────────+
| A            | ramen         | 3             |
| B            | sushi         | 2             |
| B            | curry         | 2             |
| B            | ramen         | 2             |
| C            | ramen         | 3             |
+──────────────+───────────────+───────────────+

-- 6. Which item was purchased first by the customer after they became a member?
WITH purchase_first AS (
 SELECT
  s.customer_id,
  m.product_name,
  s.order_date,
  mem.join_date,
  RANK() OVER (
   PARTITION BY s.customer_id
   ORDER BY s.order_date
  ) AS purchased_rank
FROM dannys_diner.menu AS m 
INNER JOIN dannys_diner.sales AS s
ON s.product_id = m.product_id
INNER JOIN dannys_diner.members AS mem 
ON mem.customer_id = s.customer_id
WHERE s.order_date >= mem.join_date
)
SELECT DISTINCT
 customer_id,
 order_date,
 product_name
FROM purchase_first
WHERE purchased_rank = 1;

--Result:
+──────────────+───────────+──────────────+
| customer_id  |order_date | product_name |
+──────────────+───────────+──────────────+
| A            |2021-01-07 |curry         |
| B            |2021-01-11 |sushi         |
+──────────────+───────────+──────────────+

-- 7. Which item was purchased just before the customer became a member?
WITH before_member_rank AS (
SELECT
 s.customer_id,
 s.order_date,
 m.product_name,
 RANK() OVER (
  PARTITION BY s.customer_id
  ORDER BY s.order_date DESC
 ) AS order_rank
FROM dannys_diner.menu AS m 
INNER JOIN dannys_diner.sales AS s 
ON s.product_id = m.product_id
INNER JOIN dannys_diner.members AS mem 
ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
)
SELECT DISTINCT
 customer_id,
 order_date,
 product_name
FROM before_member_rank
WHERE order_rank = 1;

--Result:
+──────────────+───────────+──────────────+
| customer_id  |order_date | product_name |
+──────────────+───────────+──────────────+
| A            |2021-01-01 |curry         |
| A            |2021-01-01 |sushi         |
| B            |2021-01-04 |sushi         | 
+──────────────+───────────+──────────────+

-- 8. What is the total items and amount spent for each member before they became a member?
SELECT
 s.customer_id,
 COUNT(DISTINCT s.product_id) AS unique_items,
 SUM(m.price) AS amount_spent
FROM dannys_diner.menu AS m 
INNER JOIN dannys_diner.sales AS s 
ON s.product_id = m.product_id
INNER JOIN dannys_diner.members AS mem 
ON mem.customer_id = s.customer_id
WHERE s.order_date < mem.join_date
GROUP BY 1;

--Result:
+──────────────+──────────────+──────────────+
| customer_id  | unique_items | amount_spent |
+──────────────+──────────────+──────────────+
| A            | 2            | 25           |
| B            | 2            | 40           |
+──────────────+──────────────+──────────────+

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT
customer_id,
SUM(CASE WHEN m.product_name = 'sushi' THEN 2 * 10 * m.price ELSE 10 * m.price
    END) AS total_points
FROM dannys_diner.sales AS s
INNER JOIN dannys_diner.menu AS m
ON s.product_id = m.product_id
GROUP BY 1
ORDER BY 1;

--Result:
+──────────────+───────────────+
| customer_id  | total_points  |
+──────────────+───────────────+
| A            | 860           |
| B            | 940           |
| C            | 360           |
+──────────────+───────────────+

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
SELECT 
 s.customer_id,
 SUM(CASE WHEN product_name = 'sushi' AND s.order_date < mem.join_date THEN 2 * 10 * m.price 
     WHEN product_name != 'sushi' AND s.order_date < mem.join_date THEN 10 * m.price
     WHEN s.order_date BETWEEN mem.join_date AND mem.join_date::DATE + 6 THEN 2 * 10 * m.price ELSE 10 * m.price
     END) AS total_points
FROM dannys_diner.menu AS m
INNER JOIN dannys_diner.sales AS s
ON s.product_id = m.product_id
INNER JOIN dannys_diner.members AS mem 
ON mem.customer_id = s.customer_id
WHERE s.order_date BETWEEN '2021-01-01' AND '2021-01-31'
GROUP BY 1
ORDER BY 1;

--Result:
+──────────────+───────────────+
| customer_id  | total_points  |
+──────────────+───────────────|
| A            | 1370          |
| B            | 820           |
+──────────────+───────────────+

--Another alternative solution is below, which was way more fun 😀:
WITH before_member AS (
 SELECT
  s.customer_id, 
  SUM(CASE WHEN m.product_name = 'sushi' THEN 2 * 10 * m.price ELSE 10 * m.price 
     END) AS total_1
 FROM dannys_diner.menu AS m 
 INNER JOIN dannys_diner.sales AS s 
 ON s.product_id = m.product_id
 INNER JOIN dannys_diner.members AS mem 
 ON mem.customer_id = s.customer_id
 WHERE order_date BETWEEN '2021-01-01' AND join_date:: DATE - 1
 GROUP BY 1
),
after_member AS (
 SELECT
  s.customer_id, 
  SUM(CASE WHEN order_date BETWEEN join_date AND join_date:: DATE + 6 THEN 2*10*m.price ELSE 10*m.price 
      END) AS total_2
 FROM dannys_diner.menu AS m 
 INNER JOIN dannys_diner.sales AS s 
 ON s.product_id = m.product_id
 INNER JOIN dannys_diner.members AS mem 
 ON mem.customer_id = s.customer_id
 WHERE order_date BETWEEN join_date AND '2021-01-31'
 GROUP BY 1
)
SELECT
 before_member.customer_id,
 SUM(total_1 + total_2) AS total_points
FROM before_member
INNER JOIN after_member
ON before_member.customer_id = after_member.customer_id
GROUP BY 1;

-- 11. Recreate the table provided.
SELECT
 s.customer_id,
 s.order_date,
 m.product_name,
 m.price,
 CASE WHEN s.order_date < mem.join_date OR mem.join_date IS NULL THEN 'N'
      WHEN s.order_date >= mem.join_date THEN 'Y'
  END AS member
FROM dannys_diner.menu AS m
INNER JOIN dannys_diner.sales AS s
ON s.product_id = m.product_id
LEFT JOIN dannys_diner.members AS mem 
ON s.customer_id = mem.customer_id
ORDER BY s.customer_id, s.order_date, m.price DESC;

--12. Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.
WITH cte_1 AS (
SELECT
 s.customer_id,
 s.order_date,
 m.product_name,
 m.price,
 CASE WHEN s.order_date < mem.join_date OR mem.join_date IS NULL THEN 'N'
      WHEN s.order_date >= mem.join_date THEN 'Y'
  END AS member
FROM dannys_diner.menu AS m
INNER JOIN dannys_diner.sales AS s
ON s.product_id = m.product_id
LEFT JOIN dannys_diner.members AS mem 
ON s.customer_id = mem.customer_id
)
SELECT
 customer_id,
 order_date,
 product_name,
 price,
 member,
 CASE WHEN member = 'N' THEN NULL 
      WHEN member = 'Y' THEN
       RANK() OVER(
        PARTITION BY customer_id
        ORDER BY CASE WHEN member = 'N' THEN 1 ELSE 0 END, order_date 
       )
  END AS ranking
FROM cte_1;
