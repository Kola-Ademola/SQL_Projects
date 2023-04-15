-- QUERY 1 (What is the total amount each customer spent at the restaurant?) SOLUTION

SELECT s.customer_id,
	   CONCAT("$", SUM(m.price)) total_amount_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY total_amount_spent DESC;

-- From the above we can clearly see that Customer A is the highest spending customer

-- QUERY 2 (How many days has each customer visited the restaurant?) SOLUTION

SELECT customer_id,
	   CONCAT(COUNT(DISTINCT order_date), " days") days_visited
FROM dannys_diner.sales
GROUP BY customer_id
ORDER BY days_visited DESC;

-- From the above we can clearly see that Customer B has visited more days

-- QUERY 3 (What was the first item from the menu purchased by each customer?) SOLUTION

SELECT s.customer_id,
		MIN(s.order_date) first_order,
		m.product_name
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;

-- From the result Customer A, B & C first purchased item sushi, curry & ramen respectively

-- QUERY 4 (What is the most purchased item on the menu and how many times was it purchased by all customers?) SOLUTION

SELECT s.customer_id,
		m.product_name,
		COUNT(m.product_name) purchase_count
FROM sales s
JOIN menu m ON s.product_id = m.product_id
WHERE s.product_id = (SELECT product_id
					FROM sales GROUP BY product_id
                    ORDER BY COUNT(*) DESC
                    LIMIT 1)
GROUP BY s.customer_id, m.product_name
ORDER BY purchase_count DESC;

-- From the result its clear that ramen is the most purchased of all items

-- QUERY 5 (Which item was the most popular for each customer?) SOLUTION

WITH prod_count_cte AS (
	SELECT s.customer_id,
		m.product_name,
		COUNT(m.product_name) prod_count
	FROM sales s
    JOIN menu m ON s.product_id = m.product_id
	GROUP BY s.customer_id, m.product_name)
SELECT customer_id,
		product_name,
		MAX(prod_count) popular_product
FROM prod_count_cte
GROUP BY customer_id
ORDER BY popular_product DESC;
 -- Customer A prefers sushi, B prefers curry & C prefers ramen

-- QUERY 6 (Which item was purchased first by the customer after they became a member?) SOLUTION
SELECT s.customer_id,
		s.order_date,
		mu.product_name
FROM sales s
JOIN members m USING(customer_id)
JOIN menu mu USING(product_id)
WHERE s.order_date IN(
	SELECT order_date
	FROM sales 
	WHERE order_date >= join_date
)
GROUP BY customer_id;

-- From the result we can see that customer A & B bought product curry & sushi respectively after becoming members

-- QUERY 7 (Which item was purchased just before the customer became a member?) SOLUTION

SELECT s.customer_id,
		s.order_date,
		mu.product_name
FROM sales s
JOIN members m USING(customer_id)
JOIN menu mu USING(product_id)
WHERE s.order_date IN(
	SELECT order_date
	FROM sales 
	WHERE order_date < join_date
)
GROUP BY customer_id;

-- From the result we can see that customer A & B bought product sushi just before becoming members

-- QUERY 8 (What is the total items and amount spent for each member before they became a member?) SOLUTION

SELECT s.customer_id,
		COUNT(s.product_id) total_items,
		CONCAT("$", SUM(mu.price)) amount_spent
FROM sales s
JOIN members m USING(customer_id)
JOIN menu mu USING(product_id)
WHERE s.order_date IN(
	SELECT order_date
	FROM sales 
	WHERE order_date < join_date
)
GROUP BY s.customer_id;
-- From the result Customer A bought 2 items spending $25 while Customer B bought 3 items spending $45

-- QUERY 9 (If each $1 spent equates to 10 points and 
-- sushi has a 2x points multiplier - how many points would each customer have?) SOLUTION

SELECT s.customer_id,
		SUM(CASE(m.product_name)
				WHEN "sushi" THEN m.price * 20
				ELSE m.price * 10
				END) customer_point
FROM sales s
JOIN menu m USING(product_id)
GROUP BY s.customer_id
ORDER BY customer_point DESC;

-- From the result Customer B is clearly the one with the highest point

-- QUERY 10 (In the first week after a customer joins the program 
-- (including their join date) they earn 2x points on all items, 
-- not just sushi - how many points do customer A and B have at the end of January?) SOLUTION

SELECT s.customer_id,        
       SUM(CASE 
              WHEN order_date BETWEEN mm.join_date AND DATE_ADD(mm.join_date, INTERVAL 1 WEEK) 
              THEN m.price * 2 
              ELSE m.price 
           END) AS customer_point
FROM sales s 
JOIN menu m USING(product_id) 
JOIN members mm USING(customer_id) 
WHERE s.customer_id IN ('A', 'B') AND order_date <= '2021-01-31' 
GROUP BY s.customer_id
ORDER BY customer_point DESC;

-- Customer A has the highest point in this case

-- BONUS QUERY 1 (The following questions are related creating basic data tables that Danny and his team
-- can use to quickly derive insights without needing to join the underlying tables using SQL.
-- Recreate the following table output using the available data:) SOLUTION

SELECT s.customer_id,
		s.order_date,
		m.product_name,
		m.price,
		IF (s.order_date >= mm.join_date, 'Y', 'N') AS member_status
FROM sales s
JOIN menu m USING(product_id)
LEFT JOIN members mm USING(customer_id);

-- BONUS QUERY 2 (Danny also requires further information about the ranking of customer products,
-- but he purposely does not need the ranking for non-member purchases so he expects null ranking values 
-- for the records when customers are not yet part of the loyalty program.) SOLUTION

WITH member_cte AS(
	SELECT s.customer_id,
			s.order_date,
			m.product_name,
			m.price,
			IF(s.order_date >= mm.join_date, 'Y', 'N') AS member_status
FROM sales s
JOIN menu m USING(product_id)
LEFT JOIN members mm USING(customer_id))

SELECT *,
		CASE
			WHEN member_status = 'N' THEN NULL
			ELSE DENSE_RANK() OVER(PARTITION BY customer_id, member_status ORDER BY order_date)
		END AS ranking
FROM member_cte