--DATABASE 

CREATE DATABASE VAN_SCHAIK_TURFLOOP;
USE VAN_SCHAIK_TURFLOOP;

--CREATING DATABASE TABLES

--BOOKS TABLE
CREATE TABLE BOOKS(
ISBN INT NOT NULL,
Title varChar(50),
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
Title varChar(50) ,
DateReturned date,
);

--BORROWED BOOKS TABLE 
CREATE TABLE BORROWEDBOOKS(
TransactionId int NOT NULL FOREIGN KEY REFERENCES TRANSACTIONS(TransactionId),
ISBN int NOT NULL FOREIGN KEY REFERENCES BOOKS(ISBN),
MemberId int NOT NULL REFERENCES LIBRARY_MEMBERS(MemberId),
FullName varChar(25),
DateBorrowed date ,
DueDate date);


--PURCHASEDBOOKS TABLE
CREATE TABLE PURCHASEDBOOKS(
TransactionId int NOT NULL FOREIGN KEY REFERENCES TRANSACTIONS(TransactionId),
ISBN int NOT NULL FOREIGN KEY REFERENCES BOOKS(ISBN),
MemberId int NOT NULL REFERENCES LIBRARY_MEMBERS(MemberId),
FullName varChar(25),
DateOfPurchase DATE,
Price DECIMAL(10,2),
Revenue DECIMAL(10,2),
Quantity_Available INT);

--INSERTING DATA INTO DATABASE

--Books
INSERT INTO BOOKS (ISBN, Title, AuthorName, Publisher, PublishedYear, NumberOfPages, BookLocation, Price, Subtitle,Quantity_Availability) 
VALUES 
(980132351, 'Clean Code',		        'Robert C. Martin' ,  'Prentice Hall',          '2008-08-11', 464, 'Shelf A',   630, 'Software Handbook' , 16),
(178020183, 'Design Patterns',          'Oreilly Wesley' ,    'Addison Professional',   '1994-10-31', 416, 'Shelf B',   840, 'Elements Software', 12),
(632977866, 'Becoming',		            'Michelle Obama',     'Crown' ,				    '2018-11-13', 345, 'Shelf C',   900, 'Breaking Through' , 5),
(367894521, 'Artificial Intelligence', 'Kate Crawford' ,     'Yale Press',			    '2011-10-10', 1200, 'Shelf G1', 1500, 'Robotics' , 7),
(236587953, 'Advance Databases',       'Ellen Clifford' ,    'Knopf Doubleday',			'2015-12-10', 600, 'Shelf G2',  1200, 'Data Warehouse' , 3),
(178964420, 'Computer Networks',	   'Charlie Mackesy' ,   'Pearson',				    '2020-06-10', 700, 'Shelf G3',  800, 'Routing Protocols' , 5),
(897561203, 'Computer Security',	   'Carl Hendrick' ,    'Murdoch Books',			'2015-03-16', 100, 'Shelf G4',  200, 'Cyber-Security' , 12),
(103978563, 'Poverty',                 'Paul Kirscher' ,    'Harper',				   '2018-02-12', 600, 'Shelf K',    500, 'The Kid' , 1),
(178963201, 'Normal Rules Dont Apply: Stories', 'Yuval Noah Harari' , 'Zed Books',		'2017-08-11', 450, 'Shelf C',   890, 'The Art of Waiting' , 60),
(189570329, 'Oscar Wars',              'Ngozi Adichie' , 'Harper',				       '2013-08-12', 360, 'Shelf B',   500, 'Love and Loss' , 17),
(229786312, 'Sapiens: Humankind',     'Yuval Noah Harari' , 'Harper',				   '2015-02-10', 600, 'Shelf M',   470 , 'History of Humankind' , 71),
(784310096, 'Atomic Habits',         'James Clear',        'Avery' ,				   '2018-10-16', 311, 'Shelf B',   600, 'Proven Good Habits' , 16);

--Authors
INSERT INTO Authors (authorId, ISBN, Nationality, FirstName, LastName, EmailAddress, PhoneNumber) 
VALUES 
(1, 980132351, 'South Africa',    'Robert',   'Martin',  'rmartin@gmail.com',  '0782369854' ),
(2, 178020183, 'United Kingdom',   'Erich',    'Gamma',   'egamma@gmail.com',   '0987654321' ),
(3, 632977866, 'United States',    'Michelle', 'Obama',   'obama@gmail.com',    '0624788963'),
(4, 229786312, 'Japan',            'Yuval',    'Harari',  'yharari@gmail.com',  '0791348965'),
(5, 784310096, 'Egypt',			   'James',    'Clear',   'clear@gmail.com',    '0835978621'),
(6, 178964420, 'Brazil',            'Charlie',    'Mackesy',  'charli36@gmail.com',  '09348965'),
(7, 189570329, 'China',            'Ngozi',    'Adichie',  'ngozi@gmail.com',  '0951348965'),
(8, 897561203, 'Panama',            'Carl',    'Hendrick',  'hendrick12@gmail.com',  '0691348965'),
(9, 784310096, 'Egypt',			   'James',    'Clear',   'clear@gmail.com',    '0835978621');


-- LIBRARY_MEMBERS table
INSERT INTO LIBRARY_MEMBERS (MemberId, FirstName, LastName, EmailAddress, PhoneNumber, Address) 
VALUES 
(1001, 'John',    'Doe',      'johndoe@gmail.com',     '0782369854', 'Gate 1 Main St'),
(1002, 'Jane',    'Smith',    'janesmith@gmail.com',   '0782368954', '456 Gate 2 St'),
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
(2, 1002, 178020183,   '2023-09-06', '2023-09-30', 12, 750, '2023-10-05'),
(3, 1003, 632977866,   '2024-01-01', '2024-02-01', NULL, 300, NULL),
(4, 1004,  229786312,  '2024-04-07', '2024-04-25', NULL, 930, '2024-04-20'),
(5, 1005, 784310096,   '2024-04-02', '2024-04-16', NULL, 440, NULL),
(6, 1001, 103978563,   NULL,NULL , NULL, 500, NULL),
(7, 1003, 784310096,   NULL,NULL , NULL, 440, NULL);


-- Sample data for BooksReturn table
INSERT INTO BooksReturn (TransactionId, ISBN, Title, DateReturned) 
VALUES 
(1, 980132351,   'Clean Code',           NULL),
(2, 178020183,   'Design Patterns',	   '2023-10-05'),
(3, 632977866,   'Becoming',             NULL),
(4, 229786312,   'Sapiens: Humankind',   '2024-04-20'),
(5, 784310096,   'Atomic Habits',        NULL);

--Purchased Books Data 
INSERT INTO PURCHASEDBOOKS (TransactionId,ISBN,MemberId,FullName,DateOfPurchase,Price,Revenue) VALUES 
(6,103978563,1001,'John Doe','2024-02-12',500,500),
(7,784310096,1003,'Mike Williams','2024-01-30',400,900);






--SELECT TABLES

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
