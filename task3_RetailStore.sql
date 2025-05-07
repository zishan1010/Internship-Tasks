CREATE DATABASE RetailStore;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT
);
INSERT INTO Customers (first_name, last_name, email, phone, address)
VALUES 
('Zishan', 'Khan', 'zishan@example.com', '9174974745', 'Indore, MP'),
('Amit', 'Verma', 'amitv@example.com', '9112233445', 'Delhi'),
('Sneha', 'Pawar', 'sneha@example.com', '9001122334', 'Pune');


CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);
INSERT INTO Products (product_name, category, price, stock_quantity)
VALUES 
('iPhone 14', 'Electronics', 75000, 10),
('Nike Shoes', 'Footwear', 4500, 25),
('Samsung LED TV', 'Electronics', 40000, 5),
('Dell Laptop', 'Computers', 60000, 8),
('T-shirt', 'Apparel', 800, 50);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Orders (customer_id, order_date, total_amount, order_status)
VALUES 
(1, CURDATE(), 79500, 'Completed'),
(2, CURDATE() - INTERVAL 5 DAY, 4500, 'Completed'),
(3, CURDATE() - INTERVAL 10 DAY, 40000, 'Pending');


CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price)
VALUES 
(1, 1, 1, 75000), 
(1, 2, 1, 4500), 
(2, 2, 1, 4500), 
(3, 3, 1, 40000);


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
INSERT INTO Payments (order_id, payment_date, payment_amount, payment_method)
VALUES 
(1, CURDATE(), 79500, 'UPI'),
(2, CURDATE() - INTERVAL 4 DAY, 4500, 'Credit Card');

-- Task 1: Total Number of Orders for Each Customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id;

-- Task 2: Total Sales Amount for Each Product (Revenue per Product)
SELECT product_id, SUM(quantity * unit_price) AS total_sales
FROM OrderDetails
GROUP BY product_id;

-- Task 3: Most Expensive Product Sold
SELECT product_id, product_name, price
FROM Products
ORDER BY price DESC
LIMIT 1;

-- Task 4: Customers with Orders in the Last 30 Days
SELECT DISTINCT customer_id
FROM Orders
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

-- Task 5: Total Amount Paid by Each Customer
SELECT o.customer_id, SUM(p.payment_amount) AS total_paid
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
GROUP BY o.customer_id;

-- Task 6: Number of Products Sold by Category
SELECT p.category, SUM(od.quantity) AS total_sold
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.category;

-- Task 7: List All Orders That Are Pending (i.e., Orders that haven't been shipped yet)
SELECT * FROM Orders
WHERE order_status = 'Pending';

-- Task 8: Find the Average Order Value (Total Order Amount / Number of Orders)
SELECT AVG(total_amount) AS avg_order_value
FROM Orders;

-- Task 9: List the Top 5 Customers Who Have Spent the Most Money
SELECT o.customer_id, SUM(p.payment_amount) AS total_spent
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- Task 10: Find the Products That Have Never Been Sold
SELECT p.product_id, p.product_name
FROM Products p
LEFT JOIN OrderDetails od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;
