# PIZZA RUNNER Case Study
## by Kola Ademola
___
![](images/pizza_runner.png)
___
## INTRODUCTION
___

I decided to take up the 8 weeks SQL challenge to improve my SQL skills aand this this project was just right for that;  
___Did you know that over 115 million kilograms of pizza is consumed daily worldwide?(Well according to Wikipedia anyway…). Danny was scrolling through his Instagram feed when something really caught his eye “80s Retro Styling and Pizza Is The Future!”___
___Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire so he had one more genius idea to combine with it he was going to Uberize it and so Pizza Runner was launched!___
___Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.___

### PROBLEM STATEMENT
This case study has LOTS of questions - they are broken up by area of focus including:

* Pizza Metrics
* Runner and Customer Experience
* Ingredient Optimisation
* Pricing and Ratings
* Bonus DML Challenges (DML = Data Manipulation Language)
___
## DATA SOURCING 
___
The dataset for this challenge was gotten from the the [8 WEEKS SQL CHALLENGE](https://8weeksqlchallenge.com/case-study-2/), and it contains the following tables;  
### runers
![](images/runners_db.png)
### customer_orders
![](images/customers_orders_db.png)
### runner_orders
![](images/runner_orders_db.png)
### pizza_names
![](images/pizza_names_db.png)
### pizza_recipes
![](images/pizza_recipes_db.png)
### pizza_toppings
![](images/pizza_toppings_db.png)
___
## QUERIES / SOLUTION
### A. Pizza Metrics
* How many pizzas were ordered?
![](images/qa1.png)
___RESULT___  
![](images/a1.png)
___
* How many unique customer orders were made?

![](images/qa2.png)
___RESULT___  
![](images/a2.png)
___
* How many successful orders were delivered by each runner?

![](images/qa3.png)
___RESULT___  
![](images/a3.png)
___
* How many of each type of pizza was delivered?

![](images/qa4.png)
___RESULT___  
![](images/a4.png)
___
* How many Vegetarian and Meatlovers were ordered by each customer?

![](images/qa5.png)
___RESULT___  
![](images/a5.png)
___
* What was the maximum number of pizzas delivered in a single order?

![](images/qa6.png)
___RESULT___  
![](images/a6.png)
___
For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

![](images/qa7.png)
___RESULT___  
![](images/a7.png)
___
* How many pizzas were delivered that had both exclusions and extras?

![](images/qa8.png)
___RESULT___  
![](images/a8.png)
___
* What was the total volume of pizzas ordered for each hour of the day?

![](images/qa9.png)
___RESULT___  
![](images/a9.png)
___
* What was the volume of orders for each day of the week?

![](images/qa10.png)
___RESULT___  
![](images/a10.png)
___
### B. Runner and Customer Experience
* How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

![](images/qb1.png)
___RESULT___  
![](images/b1.png)
___
* What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

![](images/qb2.png)
___RESULT___  
![](images/b2.png)
___
* Is there any relationship between the number of pizzas and how long the order takes to prepare?

![](images/qb3.png)
___RESULT___  
![](images/b3.png)
___
* What was the average distance travelled for each customer?

![](images/qb4.png)
___RESULT___  
![](images/b4.png)
___
* What was the difference between the longest and shortest delivery times for all orders?

![](images/qb5.png)
___RESULT___  
![](images/b5.png)
___
* What was the average speed for each runner for each delivery and do you notice any trend for these values?

![](images/qb6.png)
___RESULT___  
![](images/b6.png)
___
* What is the successful delivery percentage for each runner?

![](images/qb7.png)
___RESULT___  
![](images/b7.png)
___
### C. Ingredient Optimisation
* What are the standard ingredients for each pizza?

![](images/qc1.png)
___RESULT___  
![](images/c1.png)
___
* What was the most commonly added extra?

![](images/qc2.png)
___RESULT___  
![](images/c2.png)
___
* What was the most common exclusion?

![](images/qc3.png)
___RESULT___  
![](images/c3.png)
___
* Generate an order item for each record in the customers_orders table in the format of one of the following:
Meat Lovers
Meat Lovers - Exclude Beef
Meat Lovers - Extra Bacon
Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

![](images/qc4.png)
___RESULT___  
![](images/c4.png)
___
Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"

![](images/qc5.png)
___RESULT___  
![](images/c5.png)
___
* What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

![](images/qc6.png)
___RESULT___  
![](images/c6.png)
___
### D. Pricing and Ratings
* If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

![](images/qd1.png)
___RESULT___  
![](images/d1.png)
___
* What if there was an additional $1 charge for any pizza extras?
Add cheese is $1 extra

![](images/qd2.png)
___RESULT___  
![](images/d2.png)
___
* The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

![](images/qd3.png)
___RESULT___  
![](images/d3.png)
___
* Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
customer_id
order_id
runner_id
rating
order_time
pickup_time
Time between order and pickup
Delivery duration
Average speed
Total number of pizzas

![](images/qd4.png)
___RESULT___  
![](images/d4.png)
___
* If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

![](images/qd5.png)
___RESULT___  
![](images/d5.png)
___
### E. Bonus Questions
If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?
