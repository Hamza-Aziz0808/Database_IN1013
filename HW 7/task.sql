-- Create the Waiters table
CREATE TABLE Waiters (
    waiter_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL
);

-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL
);

-- Create the Rooms table
CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(100) NOT NULL
);

-- Create the Bills table
CREATE TABLE Bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_date DATE NOT NULL,
    customer_id INT NOT NULL,
    waiter_id INT NOT NULL,
    room_id INT NOT NULL,
    bill_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (waiter_id) REFERENCES Waiters(waiter_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Insert data into the Waiters table
INSERT INTO Waiters (first_name, surname) VALUES
('Sam', 'Pitt'),
('Alice', 'Johnson'),
('Bob', 'Smith');

-- Insert data into the Customers table
INSERT INTO Customers (cust_name) VALUES
('John Doe'),
('Jane Smith'),
('Emily Davis');

-- Insert data into the Rooms table
INSERT INTO Rooms (room_name) VALUES
('Dining Room'),
('Lounge'),
('Terrace');

-- Insert data into the Bills table
INSERT INTO Bills (bill_date, customer_id, waiter_id, room_id, bill_total) VALUES
('2024-12-01', 1, 1, 1, 350.00),
('2024-12-02', 2, 1, 2, 500.00),
('2024-12-03', 3, 2, 3, 450.00);

-- Create the samsBills view
CREATE OR REPLACE VIEW samsBills AS
SELECT 
    w.first_name, 
    w.surname, 
    b.bill_date, 
    c.cust_name, 
    b.bill_total
FROM 
    Waiters w
JOIN 
    Bills b ON w.waiter_id = b.waiter_id
JOIN 
    Customers c ON b.customer_id = c.customer_id
WHERE 
    w.first_name = 'Sam' AND w.surname = 'Pitt';

-- Create the roomTotals view
CREATE OR REPLACE VIEW roomTotals AS
SELECT 
    r.room_name, 
    SUM(b.bill_total) AS total_sum
FROM 
    Rooms r
JOIN 
    Bills b ON r.room_id = b.room_id
GROUP BY 
    r.room_name;

-- Create the teamTotals view
CREATE OR REPLACE VIEW teamTotals AS
SELECT 
    CONCAT(w.first_name, ' ', w.surname) AS headwaiter_name, 
    SUM(b.bill_total) AS total_sum
FROM 
    Waiters w
JOIN 
    Bills b ON w.waiter_id = b.waiter_id
GROUP BY 
    w.waiter_id, w.first_name, w.surname;
