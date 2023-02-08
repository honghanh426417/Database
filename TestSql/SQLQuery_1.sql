-- 1
CREATE DATABASE AZBank
CREATE TABLE Customer(
    CustomerId INT PRIMARY KEY,
    Name NVARCHAR(50),
    City NVARCHAR(50),
    Country NVARCHAR(50),
    Phone NVARCHAR(15),
    Email NVARCHAR(50)
)
-- 2
CREATE TABLE CustomerAccount(
    AccountNumber CHAR(9) PRIMARY KEY ,
    CustomerId INT NOT NULL,
    Balance money NOT NULL ,
    MinAccount money
)
CREATE TABLE CustomerTransaction(
    TransactionId INT PRIMARY KEY,
    AccountNumber CHAR(9),
    TransactionDate smalldatetime,
    Amount money ,
    DepositorWithdraw bit
)
-- 3
Insert into Customer(CustomerId, Name, City, Country, Phone, Email )
VALUES(412, 'Ama', 'HCM', 'VN', '436844', 'ama@gmail.com'),
     (413, 'Gat', 'US', 'MS', '764829', 'gat@gmail.com'),
     (414, 'Hana', 'HCM', 'VN', '437853', 'hna@gmail.com');
update Customer set City ='Hanoi' where name = 'Gat'

INSERT into CustomerAccount(AccountNumber, CustomerId, Balance, MinAccount)
VALUES(100, 412, 200, 150 ),
       (101, 413, 500, 20 ),
       (102, 414, 630, 350 );

INSERT into CustomerTransaction(TransactionId, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES(120, 100, 17, 5, 30),
      (121, 101, 17, 10, 20),
       (122, 102, 18, 6, 62);
-- 4
select * from Customer where City = 'Hanoi'
-- 5
select Name, Phone, Email, AccountNumber, Balance from Customer c inner join CustomerAccount a 
on c.CustomerId= a.CustomerId
-- 6
ALTER TABLE CustomerTransaction ADD CONSTrAINT 
CK_amount CHECK (Amount > 0 and Amount <=1000000);
-- 7
CREATE NONCLUSTERED INDEX Name_search
ON Customer(Name);
-- 8
CREATE VIEW vCustomerTransactions AS
SELECT Name, a.AccountNumber, TransactionDate, Amount, DepositorWithdraw
FROM  CustomerAccount a join Customer c on c.CustomerId = a.CustomerId
                        join CustomerTransaction t on a.AccountNumber = t.AccountNumber
-- 9
CREATE PROCEDURE spAddCustomer (@CustomerId int, @Name nvarchar(50), @Country nvarchar(50), @Phone nvarchar(15), @Email nvarchar(50))
AS
BEGIN
		INSERT INTO Customer (CustomerId, Name, Country, Phone, Email)
		VALUES (@CustomerId, @Name, @Country, @Phone, @Email)
END
GO

EXEC spAddCustomer 6, 'Thanh Duc', 'VN', '555-555-1212', 'duc@email.com';
EXEC spAddCustomer 7, 'Mango', 'Canada', '555-555-1213', 'Mango@email.com';
EXEC spAddCustomer 8, 'Cat', 'USA', '555-555-1214', 'cat@email.com';
GO
-- 10
CREATE PROCEDURE spGetTransactions (@AccountNumber int, @FromDate smalldatetime, @ToDate smalldatetime)
AS
BEGIN
    SELECT TransactionDate, Amount,
           CASE WHEN DepositorWithdraw = 1 
			   THEN 'Deposit' ELSE 'Withdraw' END AS TransactionType
    FROM CustomerTransaction
    WHERE AccountNumber = @AccountNumber
      AND TransactionDate BETWEEN @FromDate AND @ToDate
END
GO

EXEC spGetTransactions 1000, '2022-11-01', '2023-02-06'
GO