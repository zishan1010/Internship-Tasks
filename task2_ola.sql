CREATE DATABASE ola;
USE ola;
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50),
    VehicleType VARCHAR(20),
    Rating DECIMAL(2,1)
);
INSERT INTO Drivers (DriverID, FirstName, LastName, Phone, City, VehicleType, Rating) VALUES
(1, 'Amit', 'Sharma', '9876543210', 'Delhi', 'Sedan', 4.8),
(2, 'Priya', 'Mehta', '9876512345', 'Mumbai', 'Hatchback', 4.4),
(3, 'Rahul', 'Verma', '9876509876', 'Bangalore', 'SUV', 4.6),
(4, 'Neha', 'Singh', '9876598765', 'Chennai', 'Sedan', 4.2),
(5, 'Arjun', 'Patel', '9876587654', 'Delhi', 'SUV', 4.9);


CREATE TABLE Riders (
    RiderID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50),
    JoinDate DATE
);
INSERT INTO Riders (RiderID, FirstName, LastName, Phone, City, JoinDate) VALUES
(101, 'Rohan', 'Malik', '9123456780', 'Delhi', '2023-01-15'),
(102, 'Anjali', 'Gupta', '9123456781', 'Mumbai', '2023-02-20'),
(103, 'Vikas', 'Yadav', '9123456782', 'Bangalore', '2023-03-10'),
(104, 'Pooja', 'Rao', '9123456783', 'Chennai', '2023-03-18'),
(105, 'Nitin', 'Shah', '9123456784', 'Hyderabad', '2023-04-05');

CREATE TABLE Rides (
    RideID INT PRIMARY KEY,
    RiderID INT,
    DriverID INT,
    RideDate DATE,
    PickupLocation VARCHAR(100),
    DropLocation VARCHAR(100),
    Distance DECIMAL(5,2),
    Fare DECIMAL(8,2),
    RideStatus VARCHAR(20),
    FOREIGN KEY (RiderID) REFERENCES Riders(RiderID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);
INSERT INTO Rides (RideID, RiderID, DriverID, RideDate, PickupLocation, DropLocation, Distance, Fare, RideStatus) VALUES
(201, 101, 1, '2023-05-01', 'Connaught Place', 'Lajpat Nagar', 12.5, 250.00, 'Completed'),
(202, 102, 2, '2023-05-02', 'Bandra', 'Andheri', 8.0, 160.00, 'Completed'),
(203, 103, 3, '2023-05-03', 'Indiranagar', 'MG Road', 5.5, 120.00, 'Completed'),
(204, 104, 4, '2023-05-04', 'T Nagar', 'Velachery', 10.2, 210.00, 'Cancelled'),
(205, 105, 5, '2023-05-05', 'HiTech City', 'Banjara Hills', 15.0, 300.00, 'Completed');

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    RideID INT,
    PaymentMethod VARCHAR(20),
    Amount DECIMAL(8,2),
    PaymentDate DATE,
    FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);

INSERT INTO Payments (PaymentID, RideID, PaymentMethod, Amount, PaymentDate) VALUES
(301, 201, 'UPI', 250.00, '2023-05-01'),
(302, 202, 'Credit Card', 160.00, '2023-05-02'),
(303, 203, 'Cash', 120.00, '2023-05-03'),
(304, 205, 'Debit Card', 300.00, '2023-05-05');

-- 1. Retrieve the names and contact details of all drivers with a rating of 4.5 or higher
SELECT FirstName, LastName, Phone, Rating
FROM Drivers
WHERE Rating >= 4.5;

-- 2. Find the total number of rides completed by each driver
SELECT d.DriverID, d.FirstName, d.LastName, COUNT(r.RideID) AS TotalCompletedRides
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
WHERE r.RideStatus = 'Completed'
GROUP BY d.DriverID, d.FirstName, d.LastName;

-- 3. List all riders who have never booked a ride
SELECT r.RiderID, r.FirstName, r.LastName
FROM Riders r
LEFT JOIN Rides rd ON r.RiderID = rd.RiderID
WHERE rd.RideID IS NULL;

-- 4. Calculate the total earnings of each driver from completed rides.
SELECT d.DriverID, d.FirstName, d.LastName, SUM(r.Fare) AS TotalEarnings
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
WHERE r.RideStatus = 'Completed'
GROUP BY d.DriverID, d.FirstName, d.LastName;

-- 5. Retrieve the most recent ride for each rider.
SELECT r1.*
FROM Rides r1
JOIN (
    SELECT RiderID, MAX(RideDate) AS LatestRideDate
    FROM Rides
    GROUP BY RiderID
) r2 ON r1.RiderID = r2.RiderID AND r1.RideDate = r2.LatestRideDate;

-- 6. Count the number of rides taken in each city.
SELECT PickupLocation AS City, COUNT(*) AS TotalRides
FROM Rides
GROUP BY PickupLocation;

-- 7. List all rides where the distance was greater than 20 km
SELECT *
FROM Rides
WHERE Distance > 20;

-- 8. Identify the most preferred payment method.
SELECT PaymentMethod, COUNT(*) AS UsageCount
FROM Payments
GROUP BY PaymentMethod
ORDER BY UsageCount DESC
LIMIT 1;

-- 9. Find the top 3 highest-earning drivers.
SELECT d.DriverID, d.FirstName, d.LastName, SUM(r.Fare) AS TotalEarnings
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
WHERE r.RideStatus = 'Completed'
GROUP BY d.DriverID, d.FirstName, d.LastName
ORDER BY TotalEarnings DESC
LIMIT 3;

-- 10. Retrieve details of all cancelled rides along with the rider's and driver's names.
SELECT r.RideID, r.RideDate, r.PickupLocation, r.DropLocation, r.RideStatus,
       rd.FirstName AS RiderFirstName, rd.LastName AS RiderLastName,
       d.FirstName AS DriverFirstName, d.LastName AS DriverLastName
FROM Rides r
JOIN Riders rd ON r.RiderID = rd.RiderID
JOIN Drivers d ON r.DriverID = d.DriverID
WHERE r.RideStatus = 'Cancelled';

