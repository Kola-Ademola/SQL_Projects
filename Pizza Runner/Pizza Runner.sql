-- QUERY A1(How many pizzas were ordered?) SOLUTION
-- I had to clean the table first and change the "null" string values in the [extras] & [exclusion] column to actual NULL values

-- setting the 'null' string values for the exclusions column to actual NULL
UPDATE customer_orders
SET exclusions = NULL
WHERE exclusions IN('null', '');

-- setting the 'null' string values for the extras column to actual NULL
UPDATE customer_orders
SET extras = NULL
WHERE extras IN('null', '');

SELECT COUNT(order_id) AS no_of_pizza_order
FROM customer_orders;

-- From the result we can see that 14 pizzas were ordered in total.


-- QUERY A2 (How many unique customer orders were made?) SOLUTION

SELECT COUNT(DISTINCT order_id) AS no_of_unique_orders
FROM customer_orders;

-- We have 10 unique customer orders

-- QUERY A3 (How many successful orders were delivered by each runner?) SOLUTION

-- Cleaned the first to get all the NULL values in the correct form/format instead of as string

UPDATE runner_orders
SET cancellation = NULL
WHERE cancellation IN('null', '');

-- Pulling out all the successful order count for each runner

SELECT runner_id,
                COUNT(runner_id) AS sucessful_orders
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id;

-- We can see that runner 1 has the most successful orders

-- QUERY A4 (How many of each type of pizza was delivered?) SOLUTION

SELECT p.pizza_name,
                COUNT(pizza_id) AS sucessful_orders
FROM runner_orders o
JOIN customer_orders c USING(order_id)
JOIN pizza_names p USING(pizza_id)
WHERE cancellation IS NULL
GROUP BY pizza_id;

-- We can see from the result that the Meatlover pizza has more successful deliveries

-- QUERY A5 (How many Vegetarian and Meatlovers were ordered by each customer?) SOLUTION

SELECT c.customer_id, 
		p.pizza_name,
		COUNT(p.pizza_name) AS pizza_type_count
FROM customer_orders c
JOIN pizza_names p USING(pizza_id)
GROUP BY c.customer_id, p.pizza_id
ORDER BY customer_id;

-- Just from the result we can see thatthe Meatlover pizza is quite popular among the customers

-- QUERY A6 (What was the maximum number of pizzas delivered in a single order?) SOLUTION

SELECT c.order_id,
		COUNT(c.order_id) AS no_of_orders
FROM customer_orders c
JOIN runner_orders r USING(order_id)
WHERE r.cancellation IS NULL
GROUP BY order_id
ORDER BY no_of_orders DESC
LIMIT 1;

-- We can see that order_id 4 has the most pizza delivered in  one order

-- QUERY A7 (For each customer, how many delivered pizzas had at least 1 change and how many had no changes?) SOLUTION

-- When there is no change in the delivered pizza
SELECT c.customer_id,
		c.order_id,
		COUNT(c.order_id) AS pizzas_without_change
FROM customer_orders c
JOIN runner_orders r USING(order_id)
WHERE r.cancellation IS NULL 
AND exclusions IS NULL 
AND extras IS NULL
GROUP BY c.customer_id;

-- When there's at least 1 change in the pizza
SELECT c.customer_id,
		c.order_id,
		COUNT(c.order_id) AS pizzas_with_change
FROM customer_orders c
JOIN runner_orders r USING(order_id)
WHERE r.cancellation IS NULL 
AND exclusions IS NOT NULL 
OR extras IS NOT NULL
GROUP BY c.customer_id;

-- After going through both tables we can see that there is more pizza with at least 1 change than pizza's without change

-- QUERY A8 (How many pizzas were delivered that had both exclusions and extras?) SOLUTION

SELECT c.customer_id,
		c.order_id,
		COUNT(c.order_id) AS pizzas_with_both_change
FROM customer_orders c
JOIN runner_orders r USING(order_id)
WHERE r.cancellation IS NULL 
AND exclusions IS NOT NULL 
AND extras IS NOT NULL
GROUP BY c.customer_id;

-- We can see that order_id 10 is the only succesful order with both kind  of change(exclusion & extras)

-- QUERY A9 (What was the total volume of pizzas ordered for each hour of the day?) SOLUTION

SELECT CONCAT(HOUR(order_time), ':00') AS order_time,
		COUNT(order_id) AS no_of_orders
FROM customer_orders
GROUP BY HOUR(order_time)
ORDER BY no_of_orders DESC;

-- From the result we can safely say there's more orders at night

-- QUERY A10 (What was the volume of orders for each day of the week?) SOLUTION

SELECT DAYNAME(order_time) AS order_day, 
		COUNT(order_id) AS no_of_orders
FROM customer_orders
GROUP BY DAYNAME(order_time)
ORDER BY no_of_orders DESC;

-- Wednesdays and Saturdays seems to be the highest selling days

-- QUERY B1 (How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)) SOLUTION

SELECT *
FROM runners
WHERE registration_date BETWEEN '2021-01-01' AND '2021-01-07';

-- We have just 2 runners that signed up on the first week

-- QUERY B2 (What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?)
-- SOLUTION
-- First we clean the runner_order table to fix the NULL values
UPDATE runner_orders
SET pickup_time = NULL
WHERE pickup_time = 'null';

-- Finding the average pickup_time
SELECT r.runner_id,
		c.order_id,
		CONCAT(ROUND(AVG(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)), 0), ' mins') AS average_pickup_time
FROM customer_orders c
JOIN runner_orders r USING(order_id)
WHERE pickup_time IS NOT NULL
GROUP BY r.runner_id
ORDER BY average_pickup_time DESC;

-- From the result runner_id 3 is the fastest at pickup

-- QUERY B3 (Is there any relationship between the number of pizzas and how long the order takes to prepare?) SOLUTION

SELECT r.runner_id,
                COUNT(c.order_id) AS no_of_orders,
		CONCAT(ROUND(AVG(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)), 0), ' mins') AS average_pickup_time
FROM customer_orders c
JOIN runner_orders r USING(order_id)
WHERE pickup_time IS NOT NULL
GROUP BY r.runner_id
ORDER BY average_pickup_time DESC;

-- Yes there is a relationship between the no of pizza ordered and the time it ts=akes to pickup

-- QUERY B4 (What was the average distance travelled for each customer?) SOLUTION

-- Cleaning the data to correct the 'null' values for the distance column
UPDATE runner_orders
SET distance = NULL
WHERE distance = 'null';

-- Finding the average delivery time for each customer

SELECT c.customer_id,
                CONCAT(ROUND(AVG(distance), 1), ' KM') AS avg_distance
FROM runner_orders r
JOIN customer_orders c USING(order_id)
GROUP BY customer_id
ORDER BY avg_distance DESC;

-- Customer_id 105 has the longest delivery time

-- QUERY B5 (What was the difference between the longest and shortest delivery times for all orders?) SOLUTION

-- Cleaning the data to correct the 'null' values for the durations column
UPDATE runner_orders
SET duration = NULL
WHERE duration = 'null';

-- Finding the difference between the longest and shortest delivery
SELECT r.order_id,
                c.exclusions,
                c.extras,
                r.distance,
                CONCAT(SUBSTR(r.duration, 1, 2), 'mins') AS duration
FROM runner_orders r
JOIN customer_orders c USING(order_id)
WHERE r.duration IS NOT NULL
AND r.cancellation IS NULL
GROUP BY r.order_id
ORDER BY r.duration DESC;

-- From the result we can at least say the distance travelled was the major factor

-- QUERY B6 (What was the average speed for each runner for each delivery and,
-- do you notice any trend for these values?) SOLUTION

SELECT r.runner_id,
		c.order_id,
                CONCAT(ROUND(AVG(r.distance / r.duration), 1), ' km/hr') AS avg_speed
FROM runner_orders r
JOIN customer_orders c USING(order_id)
WHERE r.cancellation IS NULL
GROUP BY r.runner_id, r.order_id
ORDER BY avg_speed DESC;

-- Runner 2 has the fastest delivery speed

-- QUERY B7 (What is the successful delivery percentage for each runner?) SOLUTION

-- I start by creating a view that shows the total amount of delivery made by each runner

CREATE VIEW delivery AS (
	SELECT runner_id,
			COUNT(order_id) AS all_delivery
	FROM runner_orders
	GROUP BY runner_id);

-- then we use the delivery view to create another view that shows the successful delivery vs all delivery

CREATE VIEW s_delivery AS (
	SELECT ro.runner_id,
			d.all_delivery,
			COUNT(order_id) AS successful_delivery
	FROM runner_orders ro
	JOIN delivery d USING(runner_id)
	WHERE ro.cancellation IS NULL
	GROUP BY ro.runner_id);

-- then I finally query that table and calculated the percentage of succesful  delivery of each runner
SELECT *,
		CONCAT(ROUND((successful_delivery / all_delivery) * 100, 0), "%") AS delivery_percentage
FROM s_delivery;

-- we can now see that runner 1 is the most successful delivery

-- QUERY C1 (What are the standard ingredients for each pizza?) SOLUTION

SELECT *
FROM pizza_recipes;

-- QUERY C2 (What was the most commonly added extra?) SOLUTION

SELECT order_id,
		pizza_id,
                COUNT(DISTINCT extras)
FROM customer_orders;








-- QUERY C3 (What was the most common exclusion?) SOLUTION