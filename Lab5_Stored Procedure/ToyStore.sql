CREATE DATABASE ToyStore
use ToyStore
DROP TABLE if EXISTS Toys
CREATE TABLE Toys(
    ProductCode VARCHAR(5) PRIMARY KEY,
    Name VARCHAR(30),
    Category VARCHAR(30),
    Manufacturer VARCHAR(40),
    AgeRange VARCHAR(15),
    UnitPrice money,
    Netweight INT,
    QtyOnHand INT NOT NULL
);
INSERT  INTO Toys(ProductCode, Name, Category, Manufacturer, AgeRange, UnitPrice, Netweight, QtyOnHand)
VALUES ('101', 'Kentuy', 'car', 'The Nsbyu', '2', '600', '20', '55'),
       ('102', 'menty', 'doll', 'Mbsyu', '1', '200', '15', '78'),
       ('103', 'GHgy', 'moto', 'Menta', '1', '110', '16', '42'),
       ('104', 'sjgdu', 'rap', 'CCust', '4', '300', '26', '76'),
       ('105', 'nsjkn', 'rap', 'Xentu', '2', '200', '24', '54'),
       ('106', 'fkj', 'doll', 'Xentu', '3', '200', '25', '28'),
       ('107', 'bdwdbiu', 'doll', 'CCust', '2', '205', '15', '30'),
       ('108', 'bsuid', 'moto', 'Menta', '3', '105', '20', '33'),
       ('109', 'dwbui', 'moto', 'Menta', '5', '100', '18', '46'),
       ('200', 'ihvyu', 'car', 'jdkb', '1', '120', '27', '56');

DROP PROCEDURE if EXISTS HeavyToys
CREATE PROCEDURE HeavyToys
AS
SELECT ProductCode, Name, Category, Netweight FROM Toys WHERE Netweight > 15

EXECUTE HeavyToys

CREATE PROCEDURE  PriceIncrease
AS
    UPDATE Toys
    SET UnitPrice +=10
    SELECT * FROM PriceIncrease
EXECUTE PriceIncrease

CREATE PROCEDURE QtyOnHand 
AS
    UPDATE Toys
    SET QtyOnHand -=5
    SELECT * FROM QtyOnHand
EXECUTE QtyOnHand