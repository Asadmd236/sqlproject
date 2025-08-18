create database library;
use library;
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(50),
    total_copies INT,
    available_copies INT
);
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    join_date DATE
);

CREATE TABLE Borrowed_Books (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO Books (title, author, category, total_copies, available_copies) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 5, 5),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 4, 4),
('1984', 'George Orwell', 'Fiction', 6, 6),
('Python Programming', 'Guido van Rossum', 'Technology', 3, 3),
('Data Science 101', 'Joel Grus', 'Education', 4, 4),
('Database System Concepts', 'Abraham Silberschatz', 'Education', 5, 5),
('Clean Code', 'Robert C. Martin', 'Technology', 2, 2),
('The Alchemist', 'Paulo Coelho', 'Fiction', 7, 7),
('Machine Learning Basics', 'Andrew Ng', 'Education', 3, 3),
('Rich Dad Poor Dad', 'Robert Kiyosaki', 'Self-Help', 6, 6);


INSERT INTO Members (name, email, phone, join_date) VALUES
('Alice Johnson', 'alice@mail.com', '9876543210', '2025-08-01'),
('Bob Smith', 'bob@mail.com', '8765432109', '2025-08-05'),
('Charlie Brown', 'charlie@mail.com', '7654321098', '2025-08-07'),
('Diana Prince', 'diana@mail.com', '6543210987', '2025-08-09'),
('Ethan Hunt', 'ethan@mail.com', '5432109876', '2025-08-10'),
('Fiona Clark', 'fiona@mail.com', '4321098765', '2025-08-12'),
('George Miller', 'george@mail.com', '3210987654', '2025-08-13'),
('Hannah Lee', 'hannah@mail.com', '2109876543', '2025-08-14'),
('Ian Wright', 'ian@mail.com', '1098765432', '2025-08-15'),
('Julia Roberts', 'julia@mail.com', '9988776655', '2025-08-16');


INSERT INTO Borrowed_Books (book_id, member_id, borrow_date, return_date) VALUES
(1, 1, '2025-08-10', NULL),     -- Alice borrowed The Great Gatsby
(2, 2, '2025-08-11', '2025-08-17'), -- Bob borrowed To Kill a Mockingbird
(3, 3, '2025-08-12', NULL),     -- Charlie borrowed 1984
(4, 4, '2025-08-13', '2025-08-15'), -- Diana borrowed Python Programming
(5, 5, '2025-08-13', NULL),     -- Ethan borrowed Data Science 101
(6, 6, '2025-08-14', NULL),     -- Fiona borrowed Database Concepts
(7, 7, '2025-08-14', '2025-08-18'), -- George borrowed Clean Code
(8, 8, '2025-08-15', NULL),     -- Hannah borrowed The Alchemist
(9, 9, '2025-08-16', NULL),     -- Ian borrowed Machine Learning Basics
(10, 10, '2025-08-16', '2025-08-20'); -- Julia borrowed Rich Dad Poor Dad

/*examplequeries
Show all borrowed books*/
SELECT m.name, b.title, bb.borrow_date, bb.return_date
FROM Borrowed_Books bb
JOIN Members m ON bb.member_id = m.member_id
JOIN Books b ON bb.book_id = b.book_id;

/*Find overdue books (borrowed more than 7 days ago and not returned)*/
SELECT m.name, b.title, bb.borrow_date
FROM Borrowed_Books bb
JOIN Members m ON bb.member_id = m.member_id
JOIN Books b ON bb.book_id = b.book_id
WHERE bb.return_date IS NULL
AND DATEDIFF(CURDATE(), bb.borrow_date) > 7;

/*Count how many books each member borrowed*/
SELECT m.name, COUNT(bb.book_id) AS total_borrowed
FROM Borrowed_Books bb
JOIN Members m ON bb.member_id = m.member_id
GROUP BY m.name
ORDER BY total_borrowed DESC;

/*List all books in each category*/
SELECT category, COUNT(*) AS total_books
FROM Books
GROUP BY category;
/*Find members who borrowed a Fiction category book*/
SELECT DISTINCT m.name, b.title, b.category
FROM Borrowed_Books bb
JOIN Members m ON bb.member_id = m.member_id
JOIN Books b ON bb.book_id = b.book_id
WHERE b.category = 'Fiction';
