# 🍽️ FoodFleet - SQL-Based Online Food Delivery System

**FoodFleet** is a full-fledged SQL project simulating a real-world online food delivery platform similar to Zomato or UberEats. It demonstrates advanced SQL concepts through realistic schema design, data relationships, and analytics queries — all within a MySQL environment.

---

## 📌 Project Overview

This project covers:
- A normalized relational database schema with 7+ interlinked tables
- Realistic seed data including users, restaurants, orders, items, and payments
- Analytical SQL queries for reporting, business intelligence, and performance metrics
- ER Diagram for visualizing relationships

---

## 🧱 Database Structure

Includes the following tables:

- **users** – Stores customer data
- **restaurants** – Restaurant profiles and cuisines
- **menu_items** – Food items offered by restaurants
- **orders** – Tracks customer orders
- **order_items** – Maps menu items to orders
- **payments** – Payment methods and transactions
- **reviews** – Customer ratings and feedback

Each table uses appropriate constraints like `FOREIGN KEY`, `AUTO_INCREMENT`, `CHECK`, and `ENUM` to ensure data consistency.

---

## 🚀 How to Use

1. Open MySQL Workbench or your preferred MySQL client.
2. Run the script in `foodfleet.sql` to:
   - Create the schema
   - Insert sample data
   - Execute queries
3. Explore relationships and test queries on your own!

---

## 📈 Key SQL Concepts Demonstrated

| Feature               | Included |
|-----------------------|----------|
| Database Creation     | ✅        |
| Table Relationships   | ✅ (PK & FK) |
| Data Seeding          | ✅        |
| JOINs (INNER, LEFT)   | ✅        |
| GROUP BY & Aggregates | ✅        |
| Subqueries            | ✅        |
| Date Functions        | ✅        |
| Views / Triggers      | 🚧 (planned) |

---

## 🔗 SQL JOINs and Query Techniques Used

The FoodFleet project demonstrates rich query techniques across multiple related tables:

### ✅ INNER JOIN
Get data where both tables have a matching record.
```sql
SELECT u.name, o.total_amount
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id;


### ✅ LEFT JOIN
Return all users even if they haven't placed orders.
SELECT u.name, o.order_id
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id;

### ✅ JOIN + Aggregation
Calculate revenue per restaurant:
SELECT r.name, SUM(o.total_amount) AS revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.name;


### ✅ Subqueries
Filter top spenders:
SELECT name FROM users
WHERE user_id IN (SELECT user_id FROM orders WHERE total_amount > 50);

###✅ Date Functions
 Monthly orders:
SELECT COUNT(*) FROM orders

WHERE MONTH(order_datetime) = MONTH(CURRENT_DATE());

## 💡 Example Analytics Queries
Top 5 most ordered menu items:
Revenue by restaurant or cuisine
Monthly order summary
Active users this month
Average rating per cuisine

## 🖼 ER Diagram
A high-level overview of table relationships (attached above)
