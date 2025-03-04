# airlines_sql_project
Creating an Airlines Management System in SQL involves designing a relational database that stores and manages airline operations, including flights, passengers, tickets, employees, and airports. Below is a structured SQL project outline with table structures, relationships, and sample queries.
1. Database Schema Design
Tables and Relationships
1 . Airlines (stores airline details)
2.	Airports (stores airport details)
3.	Flights (stores flight schedules and details)
4.	Passengers (stores passenger information)
5.	Tickets (stores ticket bookings)
6.	Employees (stores staff details)
7.	Crew (links employees with flights)
8.	Baggage (tracks passenger baggage)
2. SQL Table Creation
Airlines Table
CREATE TABLE Airlines (
AirlinelD INT PRIMARY KEY AUTO INCREMENT,
AirlineName VARCHAR(100) NOT NULL, Country VARCHAR(50), FoundedYear INT
Airports Table
CREATE TABLE Airports (
AirportlD INT PRIMARY KEY AUTO_INCREMENT,
AirportName VARCHAR(100) NOT NULL,
City VARCHAR(50),
Country VARCHAR(50),
IATA_C0de CHAR(3) UNIQUE
Flights Table
CREATE TABLE Flights (
FlightlD INT PRIMARY KEY AUTO_INCREMENT,
AirlinelD INT,
FlightNumber VARCHAR(I O) UNIQUE NOT NULL,
DepartureAirportlD INT,
ArrivalAirportlD INT,
DepartureTime DATETIME,
ArrivalTime DATETIME,
Status ENUM('Scheduled', 'Delayed', 'Cancelled', 'Completed'),
FOREIGN KEY (AirlinelD) REFERENCES Airlines(AirlinelD),
FOREIGN KEY (DepartureAirportlD) REFERENCES Airports(AirportlD),
FOREIGN KEY (ArrivalAirportlD) REFERENCES Airports(AirportlD)
Passengers Table
CREATE TABLE Passengers (
PassengerlD INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
DOB DATE,
PassportNumber VARCHAR(20) UNIQUE,
Nationality VARCHAR(50)
Tickets Table
CREATE TABLE Tickets (
TicketlD INT PRIMARY KEY AUTO INCREMENT,
FlightlD INT,
PassengerlD INT,
SeatNumber VARCHAR(5),
Class ENUM('Economy', 'Business', 'First Class'), Price 
BookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (FlightlD) REFERENCES Flights(FlightlD),
FOREIGN KEY (PassengerlD) REFERENCES Passengers(PassengerlD)
Employees Table
CREATE TABLE Employees (
EmployeelD INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Role ENUM('Pilot', 'Flight Attendant', 'Ground Staff'), AirlinelD INT,
FOREIGN KEY (AirlinelD) REFERENCES Airlines(AirlinelD)
Crew Table
CREATE TABLE Crew (
CrewlD INT PRIMARY KEY AUTO INCREMENT,
FlightlD INT,
EmployeelD INT,
FOREIGN KEY (FlightlD) REFERENCES Flights(FlightlD),
FOREIGN KEY (EmployeelD) REFERENCES Employees(EmployeelD)
Baggage Table
CREATE TABLE Baggage (
BaggagelD INT PRIMARY KEY AUTO_INCREMENT,
PassengerlD INT,
FlightlD INT,
Weight 
FOREIGN KEY (PassengerlD) REFERENCES Passengers(PassengerlD),
FOREIGN KEY (FlightlD) REFERENCES Flights(FlightlD)
3. Sample Queries
a) Insert Data
INSERT INTO Airlines (AirlineName, Country, FoundedYear) VALUES ('Air India', 'India', 1 932);
INSERT INTO Airports (AirportName, City, Country, IATA_Code)
VALUES ('Indira Gandhi International Airport', 'Delhi', 'India', 'DEL');
INSERT INTO Flights (AirlinelD, FlightNumber, DepartureAirportlD,
ArrivalAirportlD, DepartureTime, ArrivalTime, Status) VALUES (1, 'All 01 ', 1, 1, '2025-06-1 0 	'2025-06-1 0  'Scheduled');
INSERT INTO Passengers (FirstName, LastName, DOB, PassportNumber, Nationality)
VALUES ('John', 'Doe', '1990-05-1 5, 'Al 2345678', USA);
b)	Retrieve all flights with their airline and airport details
SELECT F.FlightNumber, A.AirlineName, DA.AirportName AS Departure_Airport,
AA.AirportName AS Arrival_Airport,
F.DepartureTime, F.ArrivalTime, F.Status
FROM Flights F
JOIN Airlines A ON F.AirlinelD = A.AirlinelD
JOIN Airports DA ON F.DepartureAirportlD = DA.AirportlD JOIN Airports AA ON F.ArrivalAirportlD = AA.AirportlD;
c)	Find all passengers booked on a particular flight
SELECT P.PassengerlD, P.FirstName, P.LastName, T.SeatNumber, T.Class FROM Tickets T
JOIN Passengers P ON T.PassengerlD = P.PassengerlD WHERE T.FlightlD = 1;
d)	Count total flights operated by each airline
SELECT A.AirlineName, COUNT(F.FlightlD) AS TotalFlights FROM Airlines A
LEFT JOIN Flights F ON A.AirlinelD = F.AirlinelD
GROUP BY A.AirlineName;
e)	Find flights scheduled to depart today
SELECT FlightNumber, DepartureTime, Arrival Time, Status FROM Flights
WHERE DATE(DepartureTime) = CURDATE();
4. Additional Enhancements
Triggers: Automatically update flight status based on departure time.
Stored Procedures: Book tickets, cancel flights, and manage baggage.
Indexes: Optimize queries on FlightNumber, PassportNumber, and SeatNumber.
Views: Create summarized views for reporting.
This SQL-based Airlines Management System provides a structured way to manage flights, passengers, tickets, and employees efficiently. Let me know if you need additional features or modifications!
