CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name        TEXT NOT NULL,
  city        TEXT NOT NULL,
  signup_date DATE NOT NULL
);

CREATE TABLE orders (
  order_id    INT PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES customers(customer_id),
  order_date  DATE NOT NULL,
  amount      INT NOT NULL
);

INSERT INTO customers VALUES
  (1,'Ali','Kayseri',DATE '2024-01-05'),
  (2,'Ayşe','Kayseri',DATE '2024-01-10'),
  (3,'Mehmet','Ankara',DATE '2024-02-01'),
  (4,'Zeynep','Ankara',DATE '2024-02-03'),
  (5,'suat','Kayseri',DATE '2026-11-18'),
  (6,'cemil','Kayseri',DATE '2026-11-18'),
  (7,'veli','Kayseri',DATE '2026-11-19'),
  (8,'emre','Kayseri',DATE '2026-11-20');

INSERT INTO orders VALUES
  (1,1,DATE '2024-01-06',100),(2,1,DATE '2024-01-20',250),(3,1,DATE '2024-03-01',80),
  (4,2,DATE '2024-01-12',500),
  (5,3,DATE '2024-02-02',60),(6,3,DATE '2024-02-25',90),
  (7,4,DATE '2024-02-04',300),
  (8,8,DATE '2026-11-20',150),(9,8,DATE '2026-11-21',150),(10,8,DATE '2026-11-21',300),
  (11,7,DATE '2026-11-20',150),(12,7,DATE '2026-11-20',150),(13,7,DATE '2026-11-21',300);
