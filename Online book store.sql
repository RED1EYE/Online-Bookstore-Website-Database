use onlinebookstore;

//TABLE CREATIONS

CREATE TABLE publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT not null,
    p_name VARCHAR(60) not null,
    p_contact VARCHAR(255) unique,
    p_email VARCHAR(30) unique,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT not null,
    a_name VARCHAR(60) not null,
    a_contact VARCHAR(255) unique,
    a_email VARCHAR(30) unique,
    bio TEXT,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    ISBN VARCHAR(60) not null,
    unit_price DECIMAL(8,2) not null ,
    title VARCHAR(255) not null,
    edition VARCHAR(20),
    quantity_in_stock INT not null,
    publication_year YEAR,
    CHECK (unit_price AND quantity_in_stock >=0 )
); 

CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT not null,
    quantity_in_stock INT not null,
    CHECK (quantity_in_stock >=0 ),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    c_email VARCHAR(255) unique,
    c_contact VARCHAR(30) unique,
    dob DATE not null,
    age INT not null,
    state VARCHAR(30) not null,
    city VARCHAR(30) not null,
    street VARCHAR(150) not null,
    pincode INT not null
);

CREATE TABLE shopping_cart (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT not null,
    book_id INT not null,
    shipping DECIMAL(6,2) not null,
    subtotal DECIMAL(10,2) not null,
    total_fare DECIMAL(10,2) not null,
    order_datetime DATETIME not null DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled')
    NOT NULL DEFAULT 'pending',
    CHECK (subtotal AND shipping AND total_fare>=0 ),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE purchase_history (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    book_id INT not null,
    delivered_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id, delivered_on),
    FOREIGN KEY (order_id) REFERENCES shopping_cart(order_id)
    ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON DELETE CASCADE
);


//INSERTION TIME

INSERT INTO authors (author_id, book_id, a_name, a_contact, a_email, bio)
VALUES ('Lakshya', 9292391933, 'lakshya@example.com', 'cool'),
('Faizan', 9292393423, 'faizan@gmail.com', 'cool'),
('Saksham', 9242491933, 'saksham@gmail.com', 'cool'),
('Harsh', 9292432133, 'harsh@gmail.com', 'cool'),
('Aryan', 9292839933, 'aryan@gmail.com', 'cool'),
('Raj', 9229391933, 'raj123@gmail.com', 'cool'),
('Sneha', 9292392021, 'sneha@gmail.com', 'cool'),
('Ayush', 2398391933, 'ayush@gmail.com', 'cool'),
('Vikram', 9229381933, 'vikram@gmail.com', 'cool'),
('Nikita', 9292393233, 'nikita@gmail.com', 'cool');

INSERT INTO authors (author_id, book_id, a_name, a_contact, a_email, bio)
VALUES
    (1, 40, 'J.K. Rowling', '1234567890', 'jkrowling@example.com', 'British author best known for the Harry Potter series'),
    (2, 31, 'Stephen King', '9876543210', 'sking@example.com', 'Renowned American author of horror and suspense novels'),
    (3, 32, 'Jane Austen', '5555555555', 'jausten@example.com', 'Iconic English novelist known for her witty social commentary'),
    (4, 33, 'Gabriel García Márquez', '1112223333', 'ggmarquez@example.com', 'Colombian novelist and Nobel Prize laureate in Literature'),
    (5, 34, 'Toni Morrison', '4445556666', 'tmorrison@example.com', 'American novelist and recipient of the Nobel Prize in Literature'),
    (6, 35, 'Haruki Murakami', '7778889999', 'hmurakami@example.com', 'Japanese writer known for his surreal and metaphysical novels'),
    (7, 36, 'Khaled Hosseini', '2223334444', 'khosseini@example.com', 'Afghan-American novelist and physician best known for The Kite Runner'),
    (8, 37, 'Paulo Coelho', '6667778888', 'pcoelho@example.com', 'Brazilian lyricist and novelist, author of The Alchemist'),
    (9, 38, 'Chimamanda Ngozi Adichie', '9990001111', 'cnadichie@example.com', 'Nigerian novelist and writer of short stories and nonfiction'),
    (10, 39, 'Kazuo Ishiguro', '2223234444', 'kishiguro@example.com', 'British novelist and Nobel Prize laureate in Literature');

INSERT INTO books (ISBN, unit_price, title, quantity_in_stock, publication_year)
VALUES
    ('978-0743273565', 12.99, 'The Great Gatsby', 25, 1925),
    ('978-0446310789', 8.99, 'To Kill a Mockingbird', 15, 1960),
    ('978-0451524935', 11.99, '1984', 20, 1949),
    ('978-0141439513', 7.99, 'Pride and Prejudice', 30, 1960),
    ('978-0316769488', 9.99, 'The Catcher in the Rye', 18, 1951),
    ('978-0618260300', 14.99, 'The Hobbit', 22, 1937),
    ('978-0747532699', 10.99, 'Harry Potter and the Philosopher\'s Stone', 35, 1997),
    ('978-0061122416', 8.99, 'The Alchemist', 28, 1988),
    ('978-0439023481', 11.99, 'The Hunger Games', 40, 2008),
    ('978-0307277672', 13.99, 'The Da Vinci Code', 32, 2003);

ALTER TABLE books
MODIFY COLUMN edition INT DEFAULT 1;

UPDATE books
SET edition = 1
WHERE edition IS NULL;

use onlinebookstore;

SELECT * FROM inventory;
SELECT * FROM authors;
SELECT * FROM customers;
SELECT * FROM books;
SELECT * FROM inventory;
SELECT * FROM publishers;
SELECT * FROM purchase_history;
SELECT * FROM shopping_cart;

INSERT INTO customers (customer_id, c_email, c_contact, dob, age, state, city, street, pincode)
VALUES
    (1, 'john@example.com', '1234567890', '1990-05-15', 32, 'California', 'Los Angeles', '123 Main St', '90001'),
    (2, 'jane@example.com', '9876543210', '1985-11-22', 38, 'New York', 'New York City', '456 Park Ave', '10001'),
    (3, 'bob@example.com', '5555555555', '1992-03-08', 30, 'Texas', 'Houston', '789 Oak Rd', '77001'),
    (4, 'alice@example.com', '1112223333', '1988-07-01', 35, 'Florida', 'Miami', '321 Pine Blvd', '33101'),
    (5, 'tom@example.com', '4445556666', '1995-12-25', 28, 'Illinois', 'Chicago', '654 Maple St', '60601'),
    (6, 'sara@example.com', '7778889999', '1982-09-18', 41, 'Pennsylvania', 'Philadelphia', '987 Cedar Ave', '19101'),
    (7, 'mike@example.com', '2223334444', '1990-06-10', 33, 'Massachusetts', 'Boston', '159 Elm Rd', '02101'),
    (8, 'emily@example.com', '6667778888', '1993-02-28', 30, 'Washington', 'Seattle', '753 Oak Ln', '98101'),
    (9, 'david@example.com', '9990001111', '1987-11-05', 36, 'Colorado', 'Denver', '246 Pine Dr', '80201'),
    (10, 'sophia@example.com', '2222334444', '1991-08-20', 32, 'Georgia', 'Atlanta', '369 Maple Ave', '30301');

INSERT INTO inventory (inventory_id, book_id, quantity_in_stock)
VALUES
    (1, 40, 25),
    (2, 31, 18),
    (3, 32, 30),
    (4, 33, 22),
    (5, 34, 19),
    (6, 35, 27),
    (7, 36, 33),
    (8, 37, 20),
    (9, 38, 24),
    (10, 39, 28);

INSERT INTO publishers (publisher_id, book_id, p_name, p_contact, p_email)
VALUES
    (1, 40, 'Scholastic Inc.', '1234567890', 'scholastic@example.com'),
    (2, 31, 'Penguin Random House', '9876543210', 'penguinrh@example.com'),
    (3, 32, 'HarperCollins Publishers', '5555555555', 'harpercollins@example.com'),
    (4, 33, 'Simon & Schuster', '1112223333', 'simonandschuster@example.com'),
    (5, 34, 'Hachette Book Group', '4445556666', 'hachette@example.com'),
    (6, 35, 'Macmillan Publishers', '7778889999', 'macmillan@example.com'),
    (7, 36, 'Wiley', '2223334444', 'wiley@example.com'),
    (8, 37, 'Oxford University Press', '6667778888', 'oup@example.com'),
    (9, 38, 'Cambridge University Press', '9990001111', 'cup@example.com'),
    (10, 39, 'Springer Nature', '2222334444', 'springernature@example.com');
    
INSERT INTO purchase_history (order_id, customer_id, book_id, delivered_on)
VALUES
    (1, 1, 40, '2023-04-22'),
    (2, 2, 31, '2023-04-21'),
    (3, 3, 32, '2023-04-20'),
    (4, 4, 33, '2023-04-19'),
    (5, 5, 34, '2023-04-18'),
    (6, 6, 35, '2023-04-17'),
    (7, 7, 36, '2023-04-16'),
    (8, 8, 37, '2023-04-15'),
    (9, 9, 38, '2023-04-14'),
    (10, 10, 39, '2023-04-13');
    
INSERT INTO shopping_cart (order_id, customer_id, book_id, shipping, subtotal, total_fare, order_datetime, order_status)
VALUES
    (1, 1, 40, 4.99, 24.99, 29.98, '2023-04-22 10:30:00', 'Delivered'),
    (2, 2, 31, 3.99, 19.99, 23.98, '2023-04-21 15:45:00', 'Shipped'),
    (3, 3, 32, 5.99, 29.99, 35.98, '2023-04-20 09:15:00', 'Processing'),
    (4, 4, 33, 4.49, 22.99, 27.48, '2023-04-19 13:20:00', 'Delivered'),
    (5, 5, 34, 6.99, 34.99, 41.98, '2023-04-18 18:00:00', 'Shipped'),
    (6, 6, 35, 4.99, 24.99, 29.98, '2023-04-17 11:45:00', 'Processing'),
    (7, 7, 36, 5.49, 27.99, 33.48, '2023-04-16 16:30:00', 'Delivered'),
    (8, 8, 37, 3.99, 19.99, 23.98, '2023-04-15 09:00:00', 'Shipped'),
    (9, 9, 38, 6.49, 32.99, 39.48, '2023-04-14 14:15:00', 'Processing'),
    (10, 10, 39, 4.99, 24.99, 29.98, '2023-04-13 17:30:00', 'Delivered');