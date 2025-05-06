
--FULL DATABASE

CREATE DATABASE TURFLOOP_LIBRARY_SHOP_SYSTEM;
USE TURFLOOP_LIBRARY_SHOP_SYSTEM;

--CREATING DATABASE TABLES

--BOOKS TABLE
CREATE TABLE BOOKS(
ISBN INT NOT NULL,
Title varChar(30),
AuthorName varChar(20) ,
Publisher varChar(20),
PublishedYear date,
NumberOfPages int,
BookLocation varChar(20),
Price Decimal(10,2),
Subtitle varChar(50),
Quantity_Availability INT

PRIMARY KEY(ISBN)
);

--AUTHORS TABLE
CREATE TABLE Authors(
AuthorId INT NOT NULL PRIMARY KEY,
ISBN INT NOT NULL FOREIGN KEY REFERENCES BOOKS(ISBN),
FirstName varChar(10),
LastName varChar(10),
EmailAddress varChar(20),
PhoneNumber varChar(10),
Nationality varChar(20),
);

--LIBRARY MEMBER TABLE
CREATE TABLE LIBRARY_MEMBERS(

MemberId int NOT NULL,
FirstName varChar(10),
LastName varChar(10),
EmailAddress varChar(30),
PhoneNumber varChar(10),
Address varChar(30),

PRIMARY KEY(MemberId));

--BOOK COPY TABLE
CREATE TABLE BOOK_COPY(

BookNumber int NOT NULL,
ISBN int,
AuthorID int NOT NULL FOREIGN KEY REFERENCES Authors(authorId),
Title varChar(20),
BookLocation varChar(20),

PRIMARY KEY (BookNumber),
FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN));

--BOOKS TRANSACTIONS TABLE
CREATE TABLE TRANSACTIONS(

TransactionId int NOT NULL,
MemberId int NOT NULL ,
ISBN int NOT NULL,
DateBorrowed date ,
DueDate date,
Fine_Amount  Decimal(10,2),
Book_Price  Decimal(10,2),
DateReturned date,

PRIMARY KEY (TransactionId),
FOREIGN KEY (MemberId) REFERENCES LIBRARY_MEMBERS(MemberId),
FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

--BOOKS RETURN TABLE

CREATE TABLE BooksReturn(
TransactionId int NOT NULL FOREIGN KEY REFERENCES TRANSACTIONS(TransactionId),
ISBN int NOT NULL FOREIGN KEY REFERENCES BOOKS(ISBN),
Title varChar(20) ,
DateReturned date,
);

--BORROWED BOOKS TABLE 
CREATE TABLE BORROWEDBOOKS(
TransactionId int NOT NULL FOREIGN KEY REFERENCES TRANSACTIONS(TransactionId),
ISBN int NOT NULL FOREIGN KEY REFERENCES BOOKS(ISBN),
MemberId int NOT NULL REFERENCES LIBRARY_MEMBERS(MemberId),
DateBorrowed date ,
DueDate date);


--PURCHASEDBOOKS TABLE
CREATE TABLE PURCHASEDBOOKS(
TransactionId int NOT NULL FOREIGN KEY REFERENCES TRANSACTIONS(TransactionId),
ISBN int NOT NULL FOREIGN KEY REFERENCES BOOKS(ISBN),
MemberId int NOT NULL REFERENCES LIBRARY_MEMBERS(MemberId),
DateOfPurchase DATE,
Price DECIMAL(10,2),
Quantity_Available INT
);

--INSERTING DATA INTO DATABASE

--Books
INSERT INTO BOOKS (ISBN, Title, AuthorName, Publisher, PublishedYear, NumberOfPages, BookLocation, Price, Subtitle,Quantity_Availability) 
VALUES 
(980132351, 'Clean Code',		  'Robert C. Martin' ,  'Prentice Hall',        '2008-08-11', 464, 'Shelf A', 630, 'Software Handbook' , 16),
(178020183, 'Design Patterns',    'Oreilly Wesley' ,    'Addison Professional', '1994-10-31', 416, 'Shelf B', 840, 'Elements Software', 12),
(632977866, 'Becoming',		      'Michelle Obama',     'Crown' ,				'2018-11-13', 345, 'Shelf C', 900, 'Breaking Through' , 5),
(229786312, 'Sapiens: Humankind', 'Yuval Noah Harari' , 'Harper',				'2015-02-10', 600, 'Shelf C', 500, 'History Of Humankind' , 7),
(784310096, 'Atomic Habits',      'James Clear',        'Avery' ,				'2018-10-16', 311, 'Shelf B', 600, 'Proven Good Habits' , 16);

--Authors
INSERT INTO Authors (authorId, ISBN, Nationality, FirstName, LastName, EmailAddress, PhoneNumber) 
VALUES 
(1, 980132351, 'South Africa', 'Robert',   'Martin',  'rmartin@gmail.com',  '0782369854' ),
(2, 178020183, 'United Kingdom', 'Erich',    'Gamma',   'egamma@gmail.com',   '0987654321' ),
(3, 632977866, 'United States', 'Michelle', 'Obama',   'obama@gmail.com',    '0624788963'),
(4, 229786312, 'Japan', 'Yuval',    'Harari',  'yharari@gmail.com',  '0791348965'),
(5, 784310096, 'Egypt', 'James',    'Clear',   'clear@gmail.com',    '0835978621');


-- LIBRARY_MEMBERS table
INSERT INTO LIBRARY_MEMBERS (MemberId, FirstName, LastName, EmailAddress, PhoneNumber, Address) 
VALUES 
(1001, 'John',    'Doe',      'johndoe@gmail.com',     '0782369854', '123 Main St'),
(1002, 'Jane',    'Smith',    'janesmith@gmail.com',   '0782368954', '456 Elm St'),
(1003, 'Mike',    'Williams', 'williams02@gmail.com',  '0835978621', 'Zone 3'),
(1004, 'Blessing','Gamma',    'Bless1236@gmail.com',   '0791348965', 'MBH'),
(1005, 'Life',    'Clear',    'clear@gmail.com',       '0624788963', 'Unit F');

-- BOOK_COPY table
INSERT INTO BOOK_COPY (BookNumber, ISBN, AuthorID, Title, BookLocation) 
VALUES 
(1, 980132351, 1, 'Clean Code',         'Block A'),
(2, 178020183, 2, 'Design Patterns',    'Block B'),
(3, 632977866, 3, 'Becoming',           'Block C'),
(4, 229786312, 4, 'Sapiens: Humankind', 'Block C'),
(5, 784310096, 5, 'Atomic Habits',      'Block B');

-- TRANSACTIONS table
INSERT INTO TRANSACTIONS (TransactionId, MemberId, ISBN, DateBorrowed, DueDate, Fine_Amount, Book_Price, DateReturned) 
VALUES 
(1, 1001, 980132351,   '2024-04-01', '2024-04-15', NULL, 500, NULL),
(2, 1002, 178020183,   '2024-09-06', '2024-09-30', NULL, 750, NULL),
(3, 1003, 632977866,   '2024-01-01', '2024-02-01', NULL, 300, NULL),
(4, 1004,  229786312,  '2024-04-07', '2024-04-25', NULL, 930, NULL),
(5, 1005, 784310096,   '2024-04-02', '2024-04-16', NULL, 440, NULL);

-- Sample data for BooksReturn table
INSERT INTO BooksReturn (TransactionId, ISBN, Title, DateReturned) 
VALUES 
(1, 980132351,   'Clean Code',           NULL),
(2, 178020183,   'Design Patterns',	   NULL),
(3, 632977866,   'Becoming',             NULL),
(4, 229786312,   'Sapiens: Humankind',   NULL),
(5, 784310096,   'Atomic Habits',        NULL);


--Select TABLES

SELECT *
FROM BOOKS;

SELECT *
FROM Authors;

SELECT *
FROM BOOK_COPY;

SELECT *
FROM LIBRARY_MEMBERS;

SELECT *
FROM TRANSACTIONS;

SELECT *
FROM BooksReturn;

SELECT *
FROM BORROWEDBOOKS;

SELECT *
FROM PURCHASEDBOOKS;

--DATABASE IMPLEMENTATION

--QUERIES AND TRANSACTIONS

--Listing All the Books Available In The Library
SELECT Title AS TITLE,AuthorName AS AUTHOR_NAME,ISBN AS BOOK_NUMBER,Quantity_Availability AS BOOKS_AVAILABLE
FROM BOOKS;

--BORROWING BOOKS

--INSERT THE RECORD INTO THE TRANSACTIONS TABLE
INSERT INTO TRANSACTIONS (TransactionId, UserId, ISBN, DateBorrowed, DueDate) 
VALUES 
(6,1005,980132351, '2024-04-08','2024-04-25' );

SELECT TransactionId, UserId, ISBN, DateBorrowed, DueDate
FROM TRANSACTIONS;

--INSERT THE RECORD INTO THE BORROWEDBOOKS TABLE
INSERT INTO BORROWEDBOOKS(MemberId,ISBN,TransactionId,DateBorrowed,DueDate) VALUES

(1006,632977866,5,'2024-04-08','2024-04-25'),
(1004,229786312,2,'2024-02-01','2024-02-25');

SELECT *
FROM BORROWEDBOOKS;

--GET TITLE OF BORROWED BOOK
SELECT B.Title AS BOOK_TITLE
FROM TRANSACTIONS T
JOIN BOOKS B ON T.ISBN = B.ISBN   
WHERE T.TransactionId = 6;

SELECT B.Title AS BOOK_TITLE
FROM TRANSACTIONS T
JOIN BOOKS B ON T.ISBN = B.ISBN   
WHERE T.TransactionId = 5;

--UPDATE BOOK QUANTITY AVAILABITY

SELECT ISBN,Title,Quantity_Availability
FROM BOOKS;

UPDATE BOOKS
SET Quantity_Availability = Quantity_Availability - 1
WHERE ISBN = (
      SELECT ISBN
	  FROM TRANSACTIONS
	  WHERE TransactionId = 6
);

SELECT* FROM BOOKS

SELECT * FROM TRANSACTIONS

--QUERY FOR RETURNING A BOOK

--UPDATE THE RETURN DATE IN TRANSACTIONS AND BORROWED BOOKS

--INSERT DATA INTO RETURN BOOKS TABLE
INSERT INTO BooksReturn(TransactionId,ISBN,Title,DateReturned) VALUES
(6,980132351,'Clean Code', '2024-04-29');

SELECT TransactionId,ISBN,Title,DateReturned FROM BooksReturn;

--UPDATE TRANSACTIONS RETURN DATE
UPDATE TRANSACTIONS
SET DateReturned = '2024-04-29'
WHERE TransactionId = 6;

--OVERDUE BOOKS

--CALCULATE FINE AMOUNT

SELECT 
    ISBN, 
   UserID,--CHANGE TO MEMBER ID 

   CASE 
        WHEN DATEDIFF(day, DueDate, DateReturned) > 0 THEN (DATEDIFF(day, DueDate, DateReturned) * 2)
        ELSE 0
    END AS fine_amount
FROM 
    TRANSACTIONS
WHERE 
    DateReturned > DueDate;

SELECT * FROM TRANSACTIONS