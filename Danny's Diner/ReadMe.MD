# Danny's Diner Case Study
## by Kola Ademola
___
![](images/dannys_diner.png)
___
## INTRODUCTION
___

I decided to take up the 8 weeks SQL challenge to improve my SQL skills aand this this project was just right for that;  
___Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.___

___Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.___
___
## PROBLEM STATEMENT
___
Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!
### QUESTIONS
* What is the total amount each customer spent at the restaurant?
* How many days has each customer visited the restaurant?
* What was the first item from the menu purchased by each customer?
* What is the most purchased item on the menu and how many times was it purchased by all customers?
* Which item was the most popular for each customer?
* Which item was purchased first by the customer after they became a member?
* Which item was purchased just before the customer became a member?
* What is the total items and amount spent for each member before they became a member?
* If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
* In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
___
## DATA SOURCING
The dataset for this project was gotten from **Danny MA's** [**8 WEEKS SQL CHALLENGE**](https://8weeksqlchallenge.com/case-study-1/)  
I used 3 key datasets for this case study:

### sales
![](images/sales_db.png)
### menu
![](images/menu_db.png)
### members
![](images/members_db.png)
___
## DATA MODEL / ERD
___
![](images/erd.png)
This is a simple Star Schema.
___
## QUERIES / SOLUTIONS
* What is the total amount each customer spent at the restaurant?
![](images/q1.png)
___RESULT___  
![](images/s1.png)
___
* How many days has each customer visited the restaurant?
![](images/q2.png)
___RESULT___  
![](images/s2.png)
___
* What was the first item from the menu purchased by each customer?
![](images/q3.png)
___RESULT___  
![](images/s3.png)
___
* What is the most purchased item on the menu and how many times was it purchased by all customers?
![](images/q4.png)
___RESULT___  
![](images/s4.png)
___
* Which item was the most popular for each customer?
![](images/q5.png)
___RESULT___  
![](images/s5.png)
___
* Which item was purchased first by the customer after they became a member?
![](images/q6.png)
___RESULT___  
![](images/s6.png)
___
* Which item was purchased just before the customer became a member?
![](images/q7.png)
___RESULT___  
![](images/s7.png)
___
* What is the total items and amount spent for each member before they became a member?
![](images/q8.png)
___RESULT___  
![](images/s8.png)
___
* If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
![](images/q9.png)
___RESULT___  
![](images/s9.png)
___
* In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
![](images/q10.png)
___RESULT___  
![](images/s10.png)
### Bonus Questions
### Join All The Things
The following questions are related creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.

Recreate the following table output using the available data:  
![](images/bonus_table1.png)
___
![](images/bq1.png)
___RESULT___  
![](images/b1.png)
___
### Rank All The Things
Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.  
![](images/bonus_table2.png)
___
![](images/bq2.png)
___RESULT___  
![](images/b2.png)
___
