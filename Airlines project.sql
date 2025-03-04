create database Transport;
use Transport;

CREATE TABLE Airlines (
    AirlineID INT PRIMARY KEY AUTO_INCREMENT,
    AirlineName VARCHAR(100) NOT NULL,
    Country VARCHAR(50),
    FoundedYear INT
);

CREATE TABLE Airports (
    AirportID INT PRIMARY KEY AUTO_INCREMENT,
    AirportName VARCHAR(100) NOT NULL,
    City VARCHAR(50),
    Country VARCHAR(50),
    IATA_Code CHAR(3) UNIQUE
);

CREATE TABLE Flights (
    FlightID INT PRIMARY KEY AUTO_INCREMENT,
    AirlineID INT,
    FlightNumber VARCHAR(10) UNIQUE NOT NULL,
    DepartureAirportID INT,
    ArrivalAirportID INT,
    DepartureTime DATETIME,
    ArrivalTime DATETIME,
    Status ENUM('Scheduled', 'Delayed', 'Cancelled', 'Completed'),
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID),
    FOREIGN KEY (DepartureAirportID) REFERENCES Airports(AirportID),
    FOREIGN KEY (ArrivalAirportID) REFERENCES Airports(AirportID)
);

CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE,
    PassportNumber VARCHAR(20) UNIQUE,
    Nationality VARCHAR(50)
);

CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    FlightID INT,
    PassengerID INT,
    SeatNumber VARCHAR(5),
    Class ENUM('Economy', 'Business', 'First Class'),
    Price DECIMAL(10,2),
    BookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Role ENUM('Pilot', 'Flight Attendant', 'Ground Staff'),
    AirlineID INT,
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
);

CREATE TABLE Crew (
    CrewID INT PRIMARY KEY AUTO_INCREMENT,
    FlightID INT,
    EmployeeID INT,
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Baggage (
    BaggageID INT PRIMARY KEY AUTO_INCREMENT,
    PassengerID INT,
    FlightID INT,
    Weight DECIMAL(5,2),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

INSERT INTO Airlines (AirlineName, Country, FoundedYear) 
VALUES ('Air India', 'India', 1932);

INSERT INTO Airports (AirportName, City, Country, IATA_Code) 
VALUES ('Indira Gandhi International Airport', 'Delhi', 'India', 'DEL');

INSERT INTO Flights (AirlineID, FlightNumber, DepartureAirportID, ArrivalAirportID, DepartureTime, ArrivalTime, Status) 
VALUES (1, 'AI101', 1, 1, '2025-06-10 10:00:00', '2025-06-10 14:00:00', 'Scheduled');

INSERT INTO Passengers (FirstName, LastName, DOB, PassportNumber, Nationality) 
VALUES ('John', 'Doe', '1990-05-15', 'A12345678', 'USA');

SELECT F.FlightNumber, A.AirlineName, 
       DA.AirportName AS Departure_Airport, 
       AA.AirportName AS Arrival_Airport, 
       F.DepartureTime, F.ArrivalTime, F.Status
FROM Flights F
JOIN Airlines A ON F.AirlineID = A.AirlineID
JOIN Airports DA ON F.DepartureAirportID = DA.AirportID
JOIN Airports AA ON F.ArrivalAirportID = AA.AirportID;

SELECT P.PassengerID, P.FirstName, P.LastName, T.SeatNumber, T.Class
FROM Tickets T
JOIN Passengers P ON T.PassengerID = P.PassengerID
WHERE T.FlightID = 1;

SELECT A.AirlineName, COUNT(F.FlightID) AS TotalFlights
FROM Airlines A
LEFT JOIN Flights F ON A.AirlineID = F.AirlineID
GROUP BY A.AirlineName;

SELECT FlightNumber, DepartureTime, ArrivalTime, Status 
FROM Flights 
WHERE DATE(DepartureTime) = CURDATE();