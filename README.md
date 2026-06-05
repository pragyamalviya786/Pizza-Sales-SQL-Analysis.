# Pizza Sales Data Analysis Project (SQL)

## 📌 Project Overview
This project focuses on analyzing a pizza restaurant's sales data to extract actionable business insights. Using SQL, I have structured the analysis into three proficiency levels: Basic, Intermediate, and Advanced. The goal is to understand sales performance, customer preferences, and revenue drivers.

## 📊 Dataset Description
The dataset includes information across 4 relational tables:
- **Orders:** Contains Order ID, date, and time for every transaction.
- **Order Details:** Tracks specific pizzas ordered, quantities, and hooks back to orders.
- **Pizzas:** Contains Pizza ID, size, price, and links to the pizza type.
- **Pizza Types:** Contains the name, category (Classic, Veggie, Supreme, Chicken), and ingredients.

## 🛠️ Tech Stack & Tools
- **Database/Engine:** MySQL
- **Language:** SQL (Structured Query Language)
- **Concepts Used:** Joins, Subqueries, Aggregate Functions, Window Functions (`DENSE_RANK()`, `SUM() OVER`), and Common Table Expressions (CTEs).

## 🔑 Key Questions Answered

### 🔹 Basic Analysis
1. Retrieve the total number of orders placed.
2. Calculate the total revenue generated from pizza sales.
3. Identify the highest-priced pizza.
4. Identify the most common pizza size ordered.
5. List the top 5 most ordered pizza types along with their quantities.

### 🔸 Intermediate Analysis
1. Join the necessary tables to find the total quantity of each pizza category ordered.
2. Determine the distribution of orders by hour of the day.
3. Join relevant tables to find the category-wise distribution of pizzas.
4. Group the orders by date and calculate the average number of pizzas ordered per day.
5. Determine the top 3 most ordered pizza types based on revenue.

### 🚀 Advanced Analysis
1. Calculate the percentage contribution of each pizza type to total revenue.
2. Analyze the cumulative revenue generated over time.
3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

## 💡 Key Insights & Business Observations
- **Peak Operational Hours:** The restaurant experiences maximum order volumes during lunch (12:00 PM - 2:00 PM) and dinner hours (5:00 PM - 8:00 PM). Staffing and kitchen prep can be optimized around these times.
- **Size Preferences:** Large and Medium sizes dominate the sales volume, suggesting that promotions targeted at these sizes could drive higher average order value.
- **Revenue Drivers:** While Classic pizzas hit the highest quantity ordered, premium categories like Chicken and Supreme pizzas contribute significantly to total revenue due to higher margins.
- **Data Patterns:** Analyzing cumulative revenue over time shows steady business growth with predictable weekend spikes.

## 📂 How to Use This Repository
1. **Clone the Repository:** 
```bash
   git clone [https://github.com/pragyamalviya786/Pizza-Sales-SQL-Analysis..git](https://github.com/pragyamalviya786/Pizza-Sales-SQL-Analysis..git)
