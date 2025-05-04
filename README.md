# SQL_1_Listings-database-analysis

# Listings Database

Here is a Listings database which models the sample database of Listings.  In this database, we have the columns mentioned below:
1. `listing_id` - The unique id of the listing
2. `category` - Category under which the listing falls
3. `price` - The price of the listing
4. `city` - The city where the user belongs to
5. `user_id` - The id of the user. One user can have multiple listings so this is not a unique key. 

You'll be editing the `queries.sql` file, which consists of a series of
"plain English" sentences.  Don't worry if you can't do it — take your best shot!

The name of the database is `my_db`.
The name of the table is `listings`.

**🔷How to create a database?**
```sql
CREATE DATABASE my_db;
```
**🔷How to create a table**
```sql
CREATE TABLE listings
  (
     city       VARCHAR(50),
     price      INT,
     user_id    INT,
     category   VARCHAR(50),
     listing_id INT PRIMARY KEY
  ); 
```

**🔷How to insert values into a the table `listings`**
```sql
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
```

**🔷How to see the entries in the table?**

```sql
SELECT * FROM listings;
```

<img width="256" alt="image" src="https://github.com/user-attachments/assets/11f49c04-8f20-484d-96d1-2a4e42959f83" />

### Let's dive into the questions for practice. 

Practice on your own first. If you are stuck at any point then see the answers!!😉

**⭐Basic Level Questions**

1) Can you write a query to return the number of listings in each city?
```sql
SELECT city,
       Count(listing_id) AS 'Count of Listings'
FROM   listings
GROUP  BY city;
```
<img width="155" alt="image" src="https://github.com/user-attachments/assets/82255f57-c2e4-484f-a9b7-5f7e13662dcf" />


2) Write a SQL query to find the average price of listings for each category.
```sql
SELECT category,
       Round(Avg(price)) AS 'Average price of listings'
FROM   listings
GROUP  BY category; 
```
<img width="172" alt="image" src="https://github.com/user-attachments/assets/b97bd358-2b7d-4ef2-825c-707023846f3f" />

3) How would you retrieve all listings where the price is above 200?
```sql
SELECT city,
       price,
       user_id,
       category,
       listing_id
FROM   listings
WHERE  price > 200; 
```
<img width="242" alt="image" src="https://github.com/user-attachments/assets/17742c5b-3247-46f8-876a-761944b9eb5c" />

**⭐⭐Intermediate Level Questions**

4) Write a query to return the city with the highest average listing price.
```sql
SELECT city
FROM   listings
GROUP  BY city
ORDER  BY Avg(price) DESC
LIMIT  1; 
```
<img width="120" alt="image" src="https://github.com/user-attachments/assets/4ef489ed-90a4-44f4-908c-48f4a6581a9b" />

5) List the top 3 most expensive listings, showing city, price, and category.
```sql
SELECT city,
       price,
       category
FROM   listings
ORDER  BY price DESC
LIMIT  3; 
```
<img width="169" alt="image" src="https://github.com/user-attachments/assets/3668b843-b77a-486f-83cf-e086f9bc61bc" />

6) How would you count the number of unique users who have posted listings in each category?
```sql
SELECT listing_id,
       Count(DISTINCT user_id) AS 'Count of listings'
FROM   listings
GROUP  BY listing_id; 
```
<img width="160" alt="image" src="https://github.com/user-attachments/assets/89bb8c5c-ab4c-46b5-8774-cd861c8b8a52" />

**⭐⭐⭐Advanced Level Questions**

7. Can you write a query to return the category with the highest total revenue (sum of prices)?
```sql
SELECT category,
       Sum(price) AS 'Revenue'
FROM   listings
GROUP  BY category
ORDER  BY Sum(price) DESC
LIMIT  1;
```
<img width="124" alt="image" src="https://github.com/user-attachments/assets/452f2217-9f04-45f9-b95e-8f1510e57f29" />

8. Suppose we want to find users who posted listings in more than one category. Write a query to return their user_id.
```sql
SELECT user_id
FROM   listings
GROUP  BY user_id
HAVING Count(DISTINCT category) > 1;
```
<img width="85" alt="image" src="https://github.com/user-attachments/assets/4d2dc931-f049-4c9c-b0c6-9646a87a4d3d" />

9. Create a query that finds the average price per category per city.
```sql
SELECT city,
       category,
       Round(Avg(price)) AS 'Average Price'
FROM   listings
GROUP  BY city,
          category
ORDER  BY city; 
```
<img width="221" alt="image" src="https://github.com/user-attachments/assets/d0afa7d5-5a3c-432d-9604-b0906d87363a" />

10. Write a query to assign a rank to each listing within its category, ordered by price descending.
```sql
SELECT city,
SELECT user_id,
       category,
       price,
       Rank()
         OVER (
           partition BY category
           ORDER BY price DESC) AS rank_in_category
FROM   listings; 
```
<img width="246" alt="image" src="https://github.com/user-attachments/assets/85605ad9-726b-4a3b-af5c-6f195540582d" />


11. Using a window function, show the running total (cumulative sum) of listing prices for each city.
```sql
SELECT city,
       price,
       Sum(price)
         OVER (
           partition BY city
           ORDER BY listing_id) AS cumulative_price
FROM   listings;
```
<img width="200" alt="image" src="https://github.com/user-attachments/assets/cc0f96ab-c630-4bb1-afac-ad81681bee61" />

12. Use a CTE to first find the average price per category, and then select only the listings that are above the average price for their category
 ```sql
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
```
<img width="140" alt="image" src="https://github.com/user-attachments/assets/4d1e4fd7-a62f-4904-b9eb-593cc85509b4" />


If you find this repository useful, share it with your friends.🙂









