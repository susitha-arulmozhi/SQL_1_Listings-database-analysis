USE my_db;

CREATE TABLE listings
  (
     city       VARCHAR(50),
     price      INT,
     user_id    INT,
     category   VARCHAR(50),
     listing_id INT PRIMARY KEY
  ); 

INSERT INTO Listings (city, price, user_id, category, listing_id) VALUES
('New York', 150, 101, 'Electronics', 1),
('San Francisco', 120, 102, 'Electronics', 2),
('New York', 300, 103, 'Furniture', 3),
('Los Angeles', 250, 104, 'Furniture', 4),
('Los Angeles', 50, 105, 'Clothing', 5),
('San Francisco', 70, 106, 'Clothing', 6),
('Los Angeles', 180, 107, 'Electronics', 7),
('San Francisco', 350, 108, 'Furniture', 8),
('New York', 60, 109, 'Clothing', 9),
('New York', 150, 101, 'Furniture', 10);

SELECT * FROM Listings; 

-- 1
SELECT city,
       Count(listing_id) AS 'Count of Listings'
FROM   listings
GROUP  BY city; 

-- 2
SELECT category,
       Round(Avg(price)) AS 'Average price of listings'
FROM   listings
GROUP  BY category; 

-- 3
SELECT city,
       price,
       user_id,
       category,
       listing_id
FROM   listings
WHERE  price > 200; 

-- 4
SELECT city
FROM   listings
GROUP  BY city
ORDER  BY Avg(price) DESC
LIMIT  1; 

-- 5
SELECT city,
       price,
       category
FROM   listings
ORDER  BY price DESC
LIMIT  3; 

-- 6
SELECT listing_id,
       Count(DISTINCT user_id) AS 'Count of listings'
FROM   listings
GROUP  BY listing_id; 

-- 7
SELECT category,
       Sum(price) AS 'Revenue'
FROM   listings
GROUP  BY category
ORDER  BY Sum(price) DESC
LIMIT  1; 

-- 8 
SELECT user_id
FROM   listings
GROUP  BY user_id
HAVING Count(DISTINCT category) > 1; 

-- 9
SELECT city,
       category,
       Round(Avg(price)) AS 'Average Price'
FROM   listings
GROUP  BY city,
          category
ORDER  BY city; 

-- 10
SELECT user_id,
       category,
       price,
       Rank()
         OVER (
           partition BY category
           ORDER BY price DESC) AS rank_in_category
FROM   listings; 

-- 11
SELECT city,
       price,
       Sum(price)
         OVER (
           partition BY city
           ORDER BY listing_id) AS cumulative_price
FROM   listings; 

-- 12
WITH cte
     AS (SELECT category,
                Avg(price) AS avg_price
         FROM   listings
         GROUP  BY category)
SELECT L.listing_id,
       L.category
FROM   listings L
       JOIN cte C
         ON L.category = C.category
WHERE  L.price > C.avg_price; 

