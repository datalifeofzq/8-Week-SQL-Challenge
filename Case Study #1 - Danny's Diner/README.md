# [8-Week SQL Challenge](https://github.com/datalifeofzq/8-Week-SQL-Challenge)

# 🍣 Case Study #1 - Danny's Diner
<p align="center">
<img src="https://github.com/datalifeofzq/8-Week-SQL-Challenge/blob/main/Dannys%20Diner.png?raw=true" width=40% height=40%>

## 📕 Table Of Contents
* 🛠️ [Problem Statement](#problem-statement)
* 📂 [Dataset](#dataset)
* 🧙‍♂️ [Case Study Questions](#case-study-questions)
* 🚀 [Solutions](#solutions)
* 🐋 [Limitations](#limitations)
  
  ---
 
## Problem Statement
  
  > Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.


---
  
## Dataset
Danny has shared with you 3 key datasets for this case study:

  ### **```sales```**

<details>
<summary>
View table
</summary>

The sales table captures all ```customer_id``` level purchases with an corresponding ```order_date``` and ```product_id``` information for when and what menu items were ordered.

|customer_id|order_date|product_id|
|-----------|----------|----------|
|A          |2021-01-01|1         |
|A          |2021-01-01|2         |
|A          |2021-01-07|2         |
|A          |2021-01-10|3         |
|A          |2021-01-11|3         |
|A          |2021-01-11|3         |
|B          |2021-01-01|2         |
|B          |2021-01-02|2         |
|B          |2021-01-04|1         |
|B          |2021-01-11|1         |
|B          |2021-01-16|3         |
|B          |2021-02-01|3         |
|C          |2021-01-01|3         |
|C          |2021-01-01|3         |
|C          |2021-01-07|3         |

 </details>
  
  ### **```menu```**

<details>
<summary>
View table
</summary>

The menu table maps the ```product_id``` to the actual ```product_name``` and price of each menu item.
|product_id|product_name|price|
|----------|------------|-----|
|1         |sushi       |10   |
|2	       |curry       |15   |
|3	       |ramen	      |12   |
  
   </details>
  
  ### **```members```**
  
 <details>
 <summary>
 View table
 </summary>
   
 The members table captures the ```join_date``` when a ```customer_id``` joined the beta version of the Danny’s Diner loyalty program.
|customer_id|join_date |
|-----------|----------|
|A	        |2021-01-07|
|B	        |2021-01-09|
   
  </details>
   
<br>
   
## Case Study Questions
   Danny needs solutions to these ```12 questions``` to further improve his diner.
  
1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
<br>
  These next two questions ask us to recreate the table Danny provides
  
  
 11. Recreate the following table output using the available data:
      
|customer_id |order_date |product_name |price |member |
|------------|-----------|-------------|------|-------|
|A	         |2021-01-01 |curry	       |15	  |N      |
|A	         |2021-01-01 |sushi        |10  	|N      |
|A	         |2021-01-07 |curry	       |15    |Y      |
|A	         |2021-01-10 |ramen	       |12    |Y      |
|A	         |2021-01-11 |ramen	       |12    |Y      |
|A	         |2021-01-11 |ramen	       |12    |Y      |
|B	         |2021-01-01 |curry	       |15	  |N      |
|B        	 |2021-01-02 |curry	       |15    |N      | 
|B	         |2021-01-04 |sushi	       |10	  |N      |
|B	         |2021-01-11 |sushi	       |10	  |Y      |
|B	         |2021-01-16 |ramen	       |12	  |Y      |
|B	         |2021-02-01 |ramen	       |12 	  |Y      |
|C	         |2021-01-01 |ramen	       |12	  |N      |
|C	         |2021-01-01 |ramen	       |12	  |N      |
|C	         |2021-01-07 |ramen	       |12	  |N      |
      
      
12. Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program. Recreate the following table output using the available data:

|customer_id |order_date |product_name |price |member |ranking |
|------------|-----------|-------------|------|-------|--------|
|A	         |2021-01-01 |curry	       |15	  |N      |null    |
|A	         |2021-01-01 |sushi        |10  	|N      |null    |
|A	         |2021-01-07 |curry	       |15    |Y      |1       |
|A	         |2021-01-10 |ramen	       |12    |Y      |2       |
|A	         |2021-01-11 |ramen	       |12    |Y      |3       |
|A	         |2021-01-11 |ramen	       |12    |Y      |3       |
|B	         |2021-01-01 |curry	       |15	  |N      |null    |
|B        	 |2021-01-02 |curry	       |15    |N      |null    |
|B	         |2021-01-04 |sushi	       |10	  |N      |null    |
|B	         |2021-01-11 |sushi	       |10	  |Y      |1       |
|B	         |2021-01-16 |ramen	       |12	  |Y      |2       |
|B	         |2021-02-01 |ramen	       |12 	  |Y      |3       |
|C	         |2021-01-01 |ramen	       |12	  |N      |null    |
|C	         |2021-01-01 |ramen	       |12	  |N      |null    |
|C	         |2021-01-07 |ramen	       |12	  |N      |null    |

  
 ---
  
## Solutions
  
 ### **1. What is the total amount each customer spent at the restaurant?**

  ```sql
SELECT 
 s.customer_id,
 SUM(price) AS total_spent
FROM dannys_diner.sales AS s 
INNER JOIN dannys_diner.menu AS m 
ON s.product_id = m.product_id
GROUP BY 1
ORDER BY 1;
```
  
  Output:
  
  |customer_id|total_spent|
  |-----------|-----------|
  |A          |76         |
  |B          |74         |
  |C          |36         |
  
  
### **2. How many days has each customer visited the restaurant?**
```sql
SELECT
 customer_id,
 COUNT(DISTINCT order_date) AS num_of_days
FROM dannys_diner.sales
GROUP BY 1
ORDER BY 1;
```
  
   Output:
  
  |customer_id|num_of_days|
  |-----------|-----------|
  |A          |4          |
  |B          |6          |
  |C          |2          |
  
  
### **3. What was the first item(s) from the menu purchased by each customer?**
```sql
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
```
  
   Output:
  
  |customer_id|product_name|
  |-----------|------------|
  |A          |curry       |
  |A          |sushi       |
  |B          |curry       |
  |C          |ramen       |
  
Customer A purchased two items on the same day, so it is impossible to tell which item was purchased first with only the order date provided.
  
  
  ### **4. What is the most purchased item on the menu and how many times was it purchased by all customers?**
  ```sql
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
```
  
   Output:
  
  |product_name|times_ordered|
  |------------|-------------|
  |ramen       |8            |
  
An alternative, simpler solution to this is below: 
```sql
SELECT
 m.product_name,
 COUNT(s.*) AS times_ordered
FROM dannys_diner.sales AS s 
INNER JOIN dannys_diner.menu AS m 
ON s.product_id = m.product_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
```
  
### **5. Which item(s) was the most popular for each customer?**
```sql
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
```

   Output:
  
  |customer_id|product_name|times_ordered|
  |-----------|------------|-------------|
  |A          |ramen       |3            |
  |B          |sushi       |2            |
  |B          |curry       |2            |
  |B          |ramen       |2            |
  |C          |ramen       |3            |
  
  
 
### **6. Which item was purchased first by the customer after they became a member and what date was it? (including the date they joined)**
```sql
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
```
  
   Output:
  
  |customer_id|order_date|product_name|
  |-----------|----------|------------|
  |A          |2021-01-07|curry       |
  |B          |2021-01-11|sushi       |

  
### **7. Which item was purchased just before the customer became a member?**
```sql
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
```

                                  
   Output:
  
  |customer_id|order_date|product_name|
  |-----------|----------|------------|
  |A          |2021-01-01|curry       |
  |A          |2021-01-01|sushi       |
  |B          |2021-01-04|sushi       |
                                  

### **8. What is the total items and amount spent for each member before they became a member?** 
```sql
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
```
  
   Output:
  
  |customer_id|unique_items|amount_spent|
  |-----------|------------|------------|
  |A          |2           |25          |
  |B          |2           |40          |
  
                                  
 ### **9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?** 
 ```sql
SELECT
 customer_id,
 SUM(CASE WHEN m.product_name = 'sushi' THEN 2 * 10 * m.price ELSE 10 * m.price
     END) AS total_points
FROM dannys_diner.sales AS s
INNER JOIN dannys_diner.menu AS m
ON s.product_id = m.product_id
GROUP BY 1
ORDER BY 1;
```
  
   Output:
  
  |customer_id|total_points
  |-----------|------------|
  |A          |860         |
  |B          |940         |
  |C          |360         |
  
  
### **10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?** 
```sql
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
```
  
   Output:
  
  |customer_id|total_points
  |-----------|------------|
  |A          |1370        |
  |B          |820         |
  
Another alternative solution is below, which was way more fun 😀:
```sql
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
```
  

### **11. Recreate the following table output using the available data:** 
 <details>
 <summary>
 View table
 </summary>
   
|customer_id |order_date |product_name |price |member |
|------------|-----------|-------------|------|-------|
|A	         |2021-01-01 |curry	       |15	  |N      |
|A	         |2021-01-01 |sushi        |10  	|N      |
|A	         |2021-01-07 |curry	       |15    |Y      |
|A	         |2021-01-10 |ramen	       |12    |Y      |
|A	         |2021-01-11 |ramen	       |12    |Y      |
|A	         |2021-01-11 |ramen	       |12    |Y      |
|B	         |2021-01-01 |curry	       |15	  |N      |
|B        	 |2021-01-02 |curry	       |15    |N      | 
|B	         |2021-01-04 |sushi	       |10	  |N      |
|B	         |2021-01-11 |sushi	       |10	  |Y      |
|B	         |2021-01-16 |ramen	       |12	  |Y      |
|B	         |2021-02-01 |ramen	       |12 	  |Y      |
|C	         |2021-01-01 |ramen	       |12	  |N      |
|C	         |2021-01-01 |ramen	       |12	  |N      |
|C	         |2021-01-07 |ramen	       |12	  |N      |
   
  </details>
  
```sql
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
```
  
  
### **12.Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program. Recreate the following table output using the available data:** 
 <details>
 <summary>
 View table
 </summary>  
  
|customer_id |order_date |product_name |price |member |ranking |
|------------|-----------|-------------|------|-------|--------|
|A	         |2021-01-01 |curry	       |15	  |N      |null    |
|A	         |2021-01-01 |sushi        |10  	|N      |null    |
|A	         |2021-01-07 |curry	       |15    |Y      |1       |
|A	         |2021-01-10 |ramen	       |12    |Y      |2       |
|A	         |2021-01-11 |ramen	       |12    |Y      |3       |
|A	         |2021-01-11 |ramen	       |12    |Y      |3       |
|B	         |2021-01-01 |curry	       |15	  |N      |null    |
|B        	 |2021-01-02 |curry	       |15    |N      |null    |
|B	         |2021-01-04 |sushi	       |10	  |N      |null    |
|B	         |2021-01-11 |sushi	       |10	  |Y      |1       |
|B	         |2021-01-16 |ramen	       |12	  |Y      |2       |
|B	         |2021-02-01 |ramen	       |12 	  |Y      |3       |
|C	         |2021-01-01 |ramen	       |12	  |N      |null    |
|C	         |2021-01-01 |ramen	       |12	  |N      |null    |
|C	         |2021-01-07 |ramen	       |12	  |N      |null    |
   
   </details>
  
```sql
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
```
  
 Output:
  
|customer_id |order_date |product_name |price |member |ranking |
|------------|-----------|-------------|------|-------|--------|
|A	         |2021-01-07 |curry	       |15	  |N      |1       |
|A	         |2021-01-10 |ramen        |10  	|N      |2       |
|A	         |2021-01-11 |ramen	       |15    |Y      |3       |
|A	         |2021-01-11 |ramen	       |12    |Y      |3       |
|A	         |2021-01-01 |sushi	       |12    |Y      |null    |
|A	         |2021-01-01 |curry	       |12    |Y      |null    |
|B	         |2021-01-11 |sushi	       |15	  |N      |1       |
|B        	 |2021-01-16 |ramen	       |15    |N      |2       |
|B	         |2021-01-01 |ramen	       |10	  |N      |3       |
|B	         |2021-01-01 |curry	       |10	  |Y      |null    |
|B	         |2021-01-02 |curry	       |12	  |Y      |null    |
|B	         |2021-02-04 |sushi	       |12 	  |Y      |null    |
|C	         |2021-01-01 |ramen	       |12	  |N      |null    |
|C	         |2021-01-01 |ramen	       |12	  |N      |null    |
|C	         |2021-01-07 |ramen	       |12	  |N      |null    |
  
As you can see, my output is slightly different. I pushed the nulls to the bottom for each ```customer_id``` rather than keeping it at the top of the ```customer_id``` partition. This makes more sense to do as the ranking should come first.
  
  
---
<p align="center">
<img src="https://media2.giphy.com/media/xUPOqo6E1XvWXwlCyQ/giphy.gif" width=80% height=80%>
  
---
<p>&copy; 2022 Zuhayr Qureshi</p>
