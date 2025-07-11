-- CREATE DATABASE

CREATE DATABASE foodfleet;
USE foodfleet;

-- Users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(100),
    state CHAR(2),
    zipcode VARCHAR(10),
    signup_date DATE
);

-- Restaurants
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(200),
    city VARCHAR(100),
    state CHAR(2),
    zipcode VARCHAR(10),
    cuisine VARCHAR(50),
    rating DECIMAL(2,1)
);

-- Menu Items
CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100),
    price DECIMAL(6,2),
    is_veg BOOLEAN,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- Orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    restaurant_id INT,
    order_datetime DATETIME,
    total_amount DECIMAL(10,2),
    delivery_fee DECIMAL(5,2),
    delivery_address VARCHAR(200),
    status ENUM('placed', 'cancelled', 'delivered'),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- Order Items
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

-- Payments
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method ENUM('Credit Card', 'PayPal', 'Apple Pay', 'Google Pay'),
    amount_paid DECIMAL(10,2),
    payment_datetime DATETIME,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Reviews
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    restaurant_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);


-- INSERTING DATA

-- Users
INSERT INTO users (name, email, city, state, zipcode, signup_date) VALUES
('Alice', 'ice.j@example.com', 'New York', 'NY', '10001', '2025-01-15'),
('Johnson', 'jon.son@example.com', 'San Francisco', 'CA', '94104', '2025-02-10'),
('Bob', 'bob.smi@example.com', 'Dallas', 'TX', '94103', '2025-02-10'),
('Smith', 'b.smith@example.com', 'San Francisco', 'CA', '94103', '2025-02-11'),
('Lee', 'y.lee@example.com', 'Houston', 'TX', '75252', '2025-03-12'),
('Charlie Lee', 'charlie@example.com', 'Austin', 'TX', '73301', '2025-03-05');


-- Restaurants
INSERT INTO restaurants (name, address, city, state, zipcode, cuisine, rating) VALUES
('Burger Town', '123 Main St', 'New York', 'NY', '10001', 'American', 4.5),
('Sushi Place', '456 Ocean Ave', 'San Francisco', 'CA', '94103', 'Japanese', 4.7),
('Gordas', '4400 basepro', 'Texas', 'TX', '75253', 'Mexican', 4.5),
('yummy thai', '456 flowermond', 'Houston', 'TX', '94107', 'Japanese', 4.7),
('Taco House', '789 Spice Rd', 'Austin', 'TX', '73301', 'Mexican', 4.2);

-- Menu Items
INSERT INTO menu_items (restaurant_id, item_name, price, is_veg) VALUES
(1, 'Cheeseburger', 8.99, FALSE),
(1, 'Veggie Burger', 7.99, TRUE),
(2, 'California Roll', 12.50, TRUE),
(2, 'Salmon Nigiri', 14.00, FALSE),
(3, 'Beef Taco', 3.50, FALSE),
(3, 'Veggie Burrito', 6.00, TRUE),
(4, 'Fish Platter', 9.00, FALSE),
(4, 'NACHOS', 8.00, TRUE),
(5, 'GORDITA', 4.00, FALSE),
(5, 'FRIES', 2.00, TRUE);

-- Orders
INSERT INTO orders (user_id, restaurant_id, order_datetime, total_amount, delivery_fee, delivery_address, status) VALUES
(1, 1, '2025-04-01 12:30:00', 16.98, 2.00, '123 Main St, NY', 'delivered'),
(2, 2, '2025-04-02 18:45:00', 26.50, 3.00, '456 Ocean Ave, CA', 'delivered'),
(3, 3, '2025-04-03 14:15:00', 9.50, 2.50, '789 Spice Rd, TX', 'placed'),
(4, 4, '2025-04-04 15:15:00', 7.50, 4.50, '889 rock Rd, TX', 'delivered'),
(5, 5, '2025-04-05 16:15:00', 8.50, 3.50, '999 hill Rd, NY', 'placed');

-- Order Items
INSERT INTO order_items (order_id, item_id, quantity) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(2, 4, 1),
(2, 3, 1),
(4, 4, 1),
(3, 5, 2);

-- Payments
INSERT INTO payments (order_id, payment_method, amount_paid, payment_datetime) VALUES
(1, 'Credit Card', 18.98, '2025-04-01 12:35:00'),
(2, 'PayPal', 29.50, '2025-02-02 19:50:00'),
(3, 'PayPal', 19.50, '2025-04-02 17:50:00'),
(4, 'Credit Card', 25.50, '2025-03-02 16:50:00');

-- Reviews
INSERT INTO reviews (user_id, restaurant_id, rating, review_text, review_date) VALUES
(1, 1, 5, 'Best burger I ve ever had!', '2025-04-02'),
(2, 2, 4, 'Great sushi, quick delivery.', '2025-04-03'),
(2, 3, 3, 'Sushi, quick delivery.', '2025-03-03'),
(3, 3, 3, 'Tacos were decent but delivery was late.', '2025-02-04');


SELECT * FROM users;
SELECT * FROM orders;
SELECT * FROM restaurants;
SELECT * FROM order_items;

-- ANALYTICS QUERIES

-- Top 5 Most Ordered Items
SELECT mi.item_name, COUNT(*) AS order_count
FROM order_items oi
JOIN menu_items mi ON oi.item_id = mi.item_id
GROUP BY mi.item_name
ORDER BY order_count DESC
LIMIT 5;

-- Revenue by Restaurant
SELECT r.name AS restaurant, SUM(o.total_amount) AS revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'delivered'
GROUP BY r.name
ORDER BY revenue DESC;

-- Active Users This Month
SELECT u.name, COUNT(o.order_id) AS orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE MONTH(order_datetime) = MONTH(CURRENT_DATE())
GROUP BY u.name
ORDER BY orders DESC;

-- Average Rating by Cuisine
SELECT r.cuisine, AVG(rv.rating) AS avg_rating
FROM reviews rv
JOIN restaurants r ON rv.restaurant_id = r.restaurant_id
GROUP BY r.cuisine
ORDER BY avg_rating DESC;

-- Most Active Customers (by orders placed)
SELECT u.name, COUNT(o.order_id) AS total_orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.name
ORDER BY total_orders DESC;


-- Restaurants with the Most Orders
SELECT r.name AS restaurant, COUNT(o.order_id) AS total_orders
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.name
ORDER BY total_orders DESC;

-- Restaurants with Highest Average Rating
SELECT r.name, ROUND(AVG(rv.rating), 2) AS avg_rating, COUNT(rv.review_id) AS review_count
FROM reviews rv
JOIN restaurants r ON rv.restaurant_id = r.restaurant_id
GROUP BY r.name
HAVING review_count >= 1
ORDER BY avg_rating DESC;

-- Total Revenue by Cuisine
SELECT r.cuisine, SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'delivered'
GROUP BY r.cuisine
ORDER BY total_revenue DESC;


-- Payment Method Usage
SELECT payment_method, COUNT(*) AS total_transactions, SUM(amount_paid) AS total_collected
FROM payments
GROUP BY payment_method
ORDER BY total_collected DESC;

-- All Orders with User and Menu Item Info
SELECT 
    o.order_id,
    u.name AS customer,
    r.name AS restaurant,
    mi.item_name,
    oi.quantity,
    mi.price,
    (oi.quantity * mi.price) AS total_price
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN menu_items mi ON oi.item_id = mi.item_id
ORDER BY o.order_id;

-- Top Rated Restaurants by State
SELECT r.state, r.name, AVG(rv.rating) AS avg_rating
FROM reviews rv
JOIN restaurants r ON rv.restaurant_id = r.restaurant_id
GROUP BY r.state, r.name
HAVING COUNT(rv.review_id) >= 2
ORDER BY r.state, avg_rating DESC;





