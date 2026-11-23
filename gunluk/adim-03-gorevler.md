# Görev 1: Kendi kodunu savun

## Sorgu içindeki işlem sırası nedir? (JOIN, GROUP BY, ROW_NUMBER, dış WHERE: hangisi önce çalışır?)

- ROW_NUMBER()
- JOIN
- GROUP BY
- WHERE

## ROW_NUMBER()’ın içinde SUM(o.amount) kullanılabiliyor. Bu, bir window fonksiyonunun GROUP BY’dan sonra çalıştığını nasıl gösteriyor?

- Bilmiyorum ben GROUP BY’dan önce çalıştığını düşünüyordum

## WHERE sira <= 3 neden CTE’nin içinde değil de dışında? Aynı SELECT’in içine yazsaydın ne olurdu? (Dene ve hata mesajını oku.)

Denedim aldığım hata:
_duckdb.BinderException: Binder Error: WHERE clause cannot contain aggregates!

Bunun sebebi aggregate de kullandığım veriyi where de kullanamam. Yani sira değişkeni daha oluşmadan where de kısıt veremem

## LEFT JOIN yerine JOIN kullanılmış. Bu, siparişi olmayan bir müşteriye ne yapar? Bu sorunun ihtiyacına uyar mı?

Siparişi olmayan müşteriyi göstermez. Ama emin olmamakla birlikte tek başına JOIN inner join demekti diye hatırlıyorum. Yani her iki tabloda da olmalı değer diyor.

# Görev 2: Veriyi zorla, tahmin et, sonra çalıştır

## Kayseri’ye en az 2 müşteri daha ekle (toplam 4+ olsun, top 3 filtresi gerçekten eleme yapsın).

```
>>> con.sql("""INSERT INTO customers values (5, 'suat', 'Kayseri', date('2026-11-18'))""")
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql("""INSERT INTO customers values (6,'cemil', 'Kayseri', date('2026-11-18'))"""
... )
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql("""INSERT INTO customers values (7,'veli', 'Kayseri', date('2026-11-19'))""")
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql("""INSERT INTO customers values (8,'emre', 'Kayseri', date('2026-11-20'))""")
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql("""select * from customers""")
┌─────────────┬─────────┬─────────┬─────────────┐
│ customer_id │  name   │  city   │ signup_date │
│    int32    │ varchar │ varchar │    date     │
├─────────────┼─────────┼─────────┼─────────────┤
│           1 │ Ali     │ Kayseri │ 2024-01-05  │
│           2 │ Ayşe    │ Kayseri │ 2024-01-10  │
│           3 │ Mehmet  │ Ankara  │ 2024-02-01  │
│           4 │ Zeynep  │ Ankara  │ 2024-02-03  │
│           5 │ suat    │ Kayseri │ 2026-11-18  │
│           6 │ cemil   │ Kayseri │ 2026-11-18  │
│           7 │ veli    │ Kayseri │ 2026-11-19  │
│           8 │ emre    │ Kayseri │ 2026-11-20  │
└─────────────┴─────────┴─────────┴─────────────┘

>>> 
```

## İki müşterinin toplam harcaması birebir aynı olsun (beraberlik).

```
>>> con.sql("""INSERT INTO orders values (8,8, date('2026-11-20'), 150)""")
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql("""INSERT INTO orders values (9,8, date('2026-11-21'), 150)""")
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql("""INSERT INTO orders values (10,8, date('2026-11-21'), 300)""")
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql("""INSERT INTO orders values (11,7, date('2026-11-20'), 150)""")
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql("""INSERT INTO orders values (12,7, date('2026-11-20'), 150)""")
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql("""INSERT INTO orders values (13,7, date('2026-11-21'), 300)""")
┌───────┐
│ Count │
│ int64 │
├───────┤
│     1 │
└───────┘

>>> con.sql(""" select * from orders""")
┌──────────┬─────────────┬────────────┬────────┐
│ order_id │ customer_id │ order_date │ amount │
│  int32   │    int32    │    date    │ int32  │
├──────────┼─────────────┼────────────┼────────┤
│        1 │           1 │ 2024-01-06 │    100 │
│        2 │           1 │ 2024-01-20 │    250 │
│        3 │           1 │ 2024-03-01 │     80 │
│        4 │           2 │ 2024-01-12 │    500 │
│        5 │           3 │ 2024-02-02 │     60 │
│        6 │           3 │ 2024-02-25 │     90 │
│        7 │           4 │ 2024-02-04 │    300 │
│        8 │           8 │ 2026-11-20 │    150 │
│        9 │           8 │ 2026-11-21 │    150 │
│       10 │           8 │ 2026-11-21 │    300 │
│       11 │           7 │ 2026-11-20 │    150 │
│       12 │           7 │ 2026-11-20 │    150 │
│       13 │           7 │ 2026-11-21 │    300 │
└──────────┴─────────────┴────────────┴────────┘
  13 rows                            4 columns

>>> 
```

## Hiç siparişi olmayan bir müşteri ekle.

cemil ve suat müşterilerinin orders tablosunda hiç kaydı yok.


## ROW_NUMBER yerine RANK, sonra DENSE_RANK kullan. Üçünün beraberlik durumunda neden farklı sonuç verdiğini anlat.

```
>>> con.sql("""WITH MusteriHarcamalari AS (
...     SELECT 
...         c.city,
...         c.customer_id,
...         c.name,
...         SUM(o.amount) AS toplam_harcama,
...         -- Eşitlik durumunda iki kişiyi de almak isterseniz DENSE_RANK() kullanabilirsiniz
...         ROW_NUMBER() OVER (
...             PARTITION BY c.city 
...             ORDER BY SUM(o.amount) DESC
...         ) AS sira
...     FROM customers c
...     JOIN orders o ON c.customer_id = o.customer_id
...     GROUP BY c.city, c.customer_id, c.name
... )
... SELECT city, customer_id, name, toplam_harcama
... FROM MusteriHarcamalari
... WHERE sira <= 3;
... """)
┌─────────┬─────────────┬─────────┬────────────────┐
│  city   │ customer_id │  name   │ toplam_harcama │
│ varchar │    int32    │ varchar │     int128     │
├─────────┼─────────────┼─────────┼────────────────┤
│ Ankara  │           4 │ Zeynep  │            300 │
│ Ankara  │           3 │ Mehmet  │            150 │
│ Kayseri │           8 │ emre    │            600 │
│ Kayseri │           7 │ veli    │            600 │
│ Kayseri │           2 │ Ayşe    │            500 │
└─────────┴─────────────┴─────────┴────────────────┘

>>> 
```

```
>>> con.sql("""WITH MusteriHarcamalari AS (
...     SELECT 
...         c.city,
...         c.customer_id,
...         c.name,
...         SUM(o.amount) AS toplam_harcama,
...         RANK() OVER (
...             PARTITION BY c.city 
...             ORDER BY SUM(o.amount) DESC
...         ) AS sira
...     FROM customers c
...     JOIN orders o ON c.customer_id = o.customer_id
...     GROUP BY c.city, c.customer_id, c.name
... )
... SELECT city, customer_id, name, toplam_harcama
... FROM MusteriHarcamalari
... WHERE sira <= 3;
... """)
┌─────────┬─────────────┬─────────┬────────────────┐
│  city   │ customer_id │  name   │ toplam_harcama │
│ varchar │    int32    │ varchar │     int128     │
├─────────┼─────────────┼─────────┼────────────────┤
│ Kayseri │           8 │ emre    │            600 │
│ Kayseri │           7 │ veli    │            600 │
│ Kayseri │           2 │ Ayşe    │            500 │
│ Ankara  │           4 │ Zeynep  │            300 │
│ Ankara  │           3 │ Mehmet  │            150 │
└─────────┴─────────────┴─────────┴────────────────┘

>>> 
```

```
>>> con.sql("""WITH MusteriHarcamalari AS (
...     SELECT 
...         c.city,
...         c.customer_id,
...         c.name,
...         SUM(o.amount) AS toplam_harcama,
...         DENSE_RANK() OVER (
...             PARTITION BY c.city 
...             ORDER BY SUM(o.amount) DESC
...         ) AS sira
...     FROM customers c
...     JOIN orders o ON c.customer_id = o.customer_id
...     GROUP BY c.city, c.customer_id, c.name
... )
... SELECT city, customer_id, name, toplam_harcama
... FROM MusteriHarcamalari
... WHERE sira <= 3;
... """)
┌─────────┬─────────────┬─────────┬────────────────┐
│  city   │ customer_id │  name   │ toplam_harcama │
│ varchar │    int32    │ varchar │     int128     │
├─────────┼─────────────┼─────────┼────────────────┤
│ Ankara  │           4 │ Zeynep  │            300 │
│ Ankara  │           3 │ Mehmet  │            150 │
│ Kayseri │           8 │ emre    │            600 │
│ Kayseri │           7 │ veli    │            600 │
│ Kayseri │           2 │ Ayşe    │            500 │
│ Kayseri │           1 │ Ali     │            430 │
└─────────┴─────────────┴─────────┴────────────────┘

>>> 
```
Fark tam olarak nedir anlayamadım

# Görev 3: Soru 3'ü kendin yaz

## Her müşterinin 1. ve 2. siparişini nasıl yan yana getirirsin?


con.sql("""
SELECT 
o.customer_id,
o.order_date,
LAG(o.order_date) OVER (
    PARTITION BY o.customer_id 
    ORDER BY o.order_date
) AS onceki_tarih
FROM orders as o
""")

Görev 3 beni zorladı nasıl yapabilirim bilemedim.