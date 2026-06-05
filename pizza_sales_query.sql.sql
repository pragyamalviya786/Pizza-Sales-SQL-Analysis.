-- ====================================================
-- PIZZA SALES DATA ANALYSIS PROJECT
-- ====================================================
-- Database Schema Assumption:
-- 1. orders (order_id, date, time)
-- 2. order_details (order_details_id, order_id, pizza_id, quantity)
-- 3. pizzas (pizza_id, pizza_type_id, size, price)
-- 4. pizza_types (pizza_type_id, name, category, ingredients)

-- ----------------------------------------------------
-- 1. BASIC QUERIES
-- ----------------------------------------------------

-- Q1: Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders 
FROM orders;


-- Q2: Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;


-- Q3: Identify the highest-priced pizza.
SELECT 
    pt.name, 
    p.price
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;


-- Q4: Identify the most common pizza size ordered.
SELECT 
    p.size, 
    COUNT(od.order_details_id) AS total_orders_count
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_orders_count DESC
LIMIT 1;


-- Q5: List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.name, 
    SUM(od.quantity) AS total_quantity_ordered
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY total_quantity_ordered DESC
LIMIT 5;


-- ----------------------------------------------------
-- 2. INTERMEDIATE QUERIES
-- ----------------------------------------------------

-- Q1: Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category, 
    SUM(od.quantity) AS total_quantity_ordered
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY total_quantity_ordered DESC;


-- Q2: Determine the distribution of orders by hour of the day.
-- Note: 'time' represents the order time column in the orders table
SELECT 
    HOUR(time) AS hour_of_day, 
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY HOUR(time)
ORDER BY hour_of_day;


-- Q3: Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, 
    COUNT(name) AS unique_pizza_types
FROM pizza_types
GROUP BY category;


-- Q4: Group the orders by date and calculate the average number of pizzas ordered per day.
-- Note: 'date' represents the order date column in the orders table
SELECT 
    ROUND(AVG(pizzas_per_day), 0) AS avg_pizzas_ordered_per_day
FROM (
    SELECT 
        o.date, 
        SUM(od.quantity) AS pizzas_per_day
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.date
) AS daily_order_summary;


-- Q5: Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pt.name,
    ROUND(SUM(od.quantity * p.price), 2) AS revenue_generated
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY revenue_generated DESC
LIMIT 3;


-- ----------------------------------------------------
-- 3. ADVANCED QUERIES
-- ----------------------------------------------------

-- Q1: Calculate the percentage contribution of each pizza type to total revenue.
-- Note: This divides each type's revenue by the total restaurant revenue and multiplies by 100
SELECT 
    pt.name,
    ROUND((SUM(od.quantity * p.price) / 
          (SELECT SUM(od.quantity * p.price) 
           FROM order_details od 
           JOIN pizzas p ON od.pizza_id = p.pizza_id)) * 100, 2) AS revenue_percentage_contribution
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY revenue_percentage_contribution DESC;


-- Q2: Analyze the cumulative revenue generated over time.
-- Note: Uses the Window function SUM() OVER to calculate running total/cumulative revenue
SELECT 
    date,
    ROUND(SUM(daily_revenue) OVER (ORDER BY date), 2) AS cumulative_revenue
FROM (
    SELECT 
        o.date,
        SUM(od.quantity * p.price) AS daily_revenue
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN orders o ON o.order_id = od.order_id
    GROUP BY o.date
) AS daily_sales_table;


-- Q3: Determine the top 3 most ordered pizza types based on revenue for each pizza category.
-- Note: Uses CTE and DENSE_RANK() window function to rank pizzas inside their own categories
WITH ranked_pizzas_cte AS (
    SELECT 
        pt.category,
        pt.name,
        ROUND(SUM(od.quantity * p.price), 2) AS revenue,
        DENSE_RANK() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS category_rank
    FROM pizza_types pt
    JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON p.pizza_id = od.pizza_id
    GROUP BY pt.category, pt.name
)
SELECT 
    category, 
    name, 
    revenue
FROM ranked_pizzas_cte
WHERE category_rank <= 3;