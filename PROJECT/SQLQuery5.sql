CREATE DATABASE MAKWENG_RESIDENTS_LIBRARY_MANAGEMENT_SYSTEM;
USE MAKWENG_RESIDENTS_LIBRARY_MANAGEMENT_SYSTEM;

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
Price Decimal(10,5),
Subtitle varChar(50),
Quantity_Availability INT

PRIMARY KEY(ISBN)
);

--AUTHORS TABLE
CREATE TABLE Authors(
authorId INT NOT NULL PRIMARY KEY,
ISBN INT NOT NULL FOREIGN KEY REFERENCES BOOKS(ISBN),
PublishedDate date,
FirstName varChar(10),
LastName varChar(10),
EmailAddress varChar(20),
PhoneNumber varChar(10));

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
UserId int NOT NULL ,
ISBN int NOT NULL,
DateBorrowed date ,
DueDate date,
Fine_Amount  Decimal(10,5),
Book_Price  Decimal(10,5),
DateReturned date,

PRIMARY KEY (TransactionId),
FOREIGN KEY (UserId) REFERENCES LIBRARY_MEMBERS(MemberId),
FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

--BOOKS RETURN TABLE

CREATE TABLE BooksReturn(
TransactionId int NOT NULL FOREIGN KEY REFERENCES TRANSACTIONS(TransactionId),
ISBN int NOT NULL FOREIGN KEY REFERENCES BOOKS(ISBN),
Title varChar(20) ,
DateReturned date,
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
INSERT INTO Authors (authorId, ISBN, PublishedYear, FirstName, LastName, EmailAddress, PhoneNumber) 
VALUES 
(1, 980132351, '2008-08-11', 'Robert',   'Martin',  'rmartin@gmail.com',  '0782369854' ),
(2, 178020183, '1994-10-31', 'Erich',    'Gamma',   'egamma@gmail.com',   '0987654321' ),
(3, 632977866, '2018-11-13', 'Michelle', 'Obama',   'obama@gmail.com',    '0624788963'),
(4, 229786312, '2015-02-10', 'Yuval',    'Harari',  'yharari@gmail.com',  '0791348965'),
(5, 784310096, '2018-10-16', 'James',    'Clear',   'clear@gmail.com',    '0835978621');


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
INSERT INTO TRANSACTIONS (TransactionId, UserId, ISBN, DateBorrowed, DueDate, Fine_Amount, Book_Price, DateReturned) 
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