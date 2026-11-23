# Verdiğin görevler

## 1. Görev

evet python içerisinde tabloları gördüm

## 2. Görev

Soru 1 den yazdığım sorgu hata verdi. Bunun nedeni group_by da kullanmadığım alanların select de olması. Verdiği hatada bunu anladım.

"_duckdb.BinderException: Binder Error: column "customer_id" must appear in the GROUP BY clause or must be part of an aggregate function."

Düzeltip bu şekilde yazınca çalıştı:

```
>>> con.sql("""    SELECT 
...     c.customer_id,
...     c.name,
...     c.city,
...     SUM(o.amount) toplam_harcama
...     FROM customers as c
...     LEFT JOIN orders as o
...     ON c.customer_id = o.customer_id
...     GROUP BY c.customer_id, c.city, c.name, c.city""")
┌─────────────┬─────────┬─────────┬────────────────┐
│ customer_id │  name   │  city   │ toplam_harcama │
│    int32    │ varchar │ varchar │     int128     │
├─────────────┼─────────┼─────────┼────────────────┤
│           3 │ Mehmet  │ Ankara  │            150 │
│           4 │ Zeynep  │ Ankara  │            300 │
│           2 │ Ayşe    │ Kayseri │            500 │
│           1 │ Ali     │ Kayseri │            430 │
└─────────────┴─────────┴─────────┴────────────────┘

>>> 
```

## 3. Görev

### 3.1 Group BY

Bunu anladım. Benim hatalı sorgumda customer' ın city sine göre grupladım, ama select de customerın id ve name alanlarınıda getirmek istedim. Burada veri tabanında bu alanlarda farklı birden fazla kayıt olacağı için hangisini göstermesi gerektiğini bilemiyor. Çünkü Ankarada Mehmet ve Zeynep var idleride 3 ve 4 hangisini göstereyim diyor.

### 3.2 ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)

Evet bunu hatırladım ama en son iş zekası iş deneyimim üzerinden tam 3 yıl geçti bunu unutmuşum. Group by tüm satırları ezer ve tek bir grubu temsil eden satıra dönüştürür.

Partition by tüm satırları koruyarak kendi içerisinde gruplamayı sağlar. grup içerisinde sıralama toplama vs yapabiliyor oluruz.


### 3.3 LAG() ne yapar?

Kendinden önceki satırı görmek için kullanılır. Yan yana karşılaştırmak için kullanırız. Varsayılanı 1 öncekini gösterir ancak LAG(sutun_adi, 2) gibi 2 adım geriye ve daha fazlasına gidebiliriz.

## 4. Görev
Öğrendiklerinle Soru 1 ve 2'yi yeniden yaz. 

**Dürüst not:** Yapay zekadan destek aldım.

### Soru 1
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
│ Kayseri │           2 │ Ayşe    │            500 │
│ Kayseri │           1 │ Ali     │            430 │
└─────────┴─────────────┴─────────┴────────────────┘

```
### Soru 2

```
>>> con.sql("""SELECT 
...     customer_id,
...     order_id,
...     order_date AS mevcut_siparis_tarihi,
...     LAG(order_date) OVER (
...         PARTITION BY customer_id 
...         ORDER BY order_date ASC
...     ) AS onceki_siparis_tarihi,
...     order_date - LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS gun_farki
... FROM orders;""")
┌─────────────┬──────────┬───────────────────────┬───────────────────────┬───────────┐
│ customer_id │ order_id │ mevcut_siparis_tarihi │ onceki_siparis_tarihi │ gun_farki │
│    int32    │  int32   │         date          │         date          │   int64   │
├─────────────┼──────────┼───────────────────────┼───────────────────────┼───────────┤
│           2 │        4 │ 2024-01-12            │ NULL                  │      NULL │
│           4 │        7 │ 2024-02-04            │ NULL                  │      NULL │
│           3 │        5 │ 2024-02-02            │ NULL                  │      NULL │
│           3 │        6 │ 2024-02-25            │ 2024-02-02            │        23 │
│           1 │        1 │ 2024-01-06            │ NULL                  │      NULL │
│           1 │        2 │ 2024-01-20            │ 2024-01-06            │        14 │
│           1 │        3 │ 2024-03-01            │ 2024-01-20            │        41 │
└─────────────┴──────────┴───────────────────────┴───────────────────────┴───────────┘

>>> 
```
