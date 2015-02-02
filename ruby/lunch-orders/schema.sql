-- # Create a new database
-- # lunch_orders

-- # Create a table called orders
-- # id
-- # name
-- # order_title

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  order_title TEXT NOT NULL
);