CREATE DATABASE books_db;

CREATE TABLE authors
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255) NOT NULL
);

CREATE TABLE books
(
    id               SERIAL PRIMARY KEY,
    title            VARCHAR(255) NOT NULL,
    publication_year INTEGER      NOT NULL,
    isbn             VARCHAR(255) NOT NULL,
    author_id        INTEGER      NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors (id)
);

CREATE TABLE reviews
(
    id          SERIAL PRIMARY KEY,
    book_id     INTEGER NOT NULL,
    rating      INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 10),
    review_text TEXT    NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books (id)
);

SELECT authors.first_name,
       authors.last_name,
       COUNT(books.id) AS book_count
FROM authors
         JOIN books ON authors.id = books.author_id
GROUP BY authors.id
ORDER BY book_count DESC;


CREATE VIEW top_5_authors AS
SELECT authors.id,
       authors.first_name,
       authors.last_name,
       AVG(reviews.rating) AS average_rating
FROM authors
         JOIN books ON authors.id = books.author_id
         JOIN reviews ON books.id = reviews.book_id
GROUP BY authors.id
ORDER BY average_rating DESC LIMIT 5;
