CREATE DATABASE MAKWENG_RESIDENTS_LIBRARY_SYSTEM;
USE MAKWENG_RESIDENTS_LIBRARY_SYSTEM;

--CREATING DATABASE TABLES

--BOOKS TABLE
CREATE TABLE BOOKS(
ISBN int NOT NULL,
Title varChar(20),
Publisher varChar(20),
PublishedYear date,
NumberOfPages int,
BookLocation varChar(20),
Price int,
Subtitle varChar(20),
Quantity_Availability INT

PRIMARY KEY(ISBN)
);

--AUTHORS TABLE
CREATE TABLE Authors(
authorId int NOT NULL PRIMARY KEY,
ISBN int NOT NULL FOREIGN KEY REFERENCES BOOKS(ISBN),
PublishedYear date,
FirstName varChar(20),
LastName varChar(20),
EmailAddress varChar(20),
PhoneNumber varChar(10),
BooksWritten varChar(50));

--LIBRARY MEMBER TABLE
CREATE TABLE LIBRARY_MEMBERS(

MemberId int NOT NULL,
FirstName varChar(20),
LastName varChar(20),
EmailAddress varChar(20),
PhoneNumber varChar(10),
Address varChar(20),

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
Fine_Amount money,
Book_Price money,
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

INSERT INTO BOOKS (ISBN, Title, Publisher, PublishedYear, NumberOfPages, BookLocation, Price, Subtitle,Quantity_Availability) 
VALUES 
(9780132350884, 'Clean Code', 'Prentice Hall', '2008-08-11', 464, 'Shelf A', 30, 'A Handbook of Agile Software Craftsmanship' , 16),
(1780201835953, 'Design Patterns', 'Addison-Wesley Professional', '1994-10-31', 416, 'Shelf B', 40, 'Elements of Reusable Object-Oriented Software', 12),
(6329778663521, 'Clean Code', 'Prentice Hall', '2008-08-11', 464, 'Shelf A', 30, 'A Handbook of Agile Software Craftsmanship' , 16),
(229786312487, 'Clean Code', 'Prentice Hall', '2008-08-11', 464, 'Shelf A', 30, 'A Handbook of Agile Software Craftsmanship' , 16),
(784310096874, 'Clean Code', 'Prentice Hall', '2008-08-11', 464, 'Shelf A', 30, 'A Handbook of Agile Software Craftsmanship' , 16);