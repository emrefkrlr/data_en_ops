# A. SQL


## 1. Soru
```
    SELECT 
    c.customer_id,
    c.name,
    c.city,
    SUM(o.amount) toplam_harcama
    FROM customers as c
    LEFT JOIN orders as o
    ON c.customer_id = o.customer_id
    GROUP BY c.city 
```

## 2. Soru

tahmin ediyorum ama emin değilim. Siparişleri arasındaki gün farkını nasıl göstereceğimden emin değilim

```
    SELECT 
    c.customer_id,
    c.name
    FROM customers as c
    LEFT JOIN orders as o
    ON c.customer_id = o.customer_id
    ORDER BY o.order_date DESC
    GROUP BY c.customer_id 
```

## 3. Soru

Bilmiyorum

## 4. Soru

Tahmin ediyorum ama emin değilim


# B. Python

## 5. Soru

Fonksiyonu her çağırdıında bucket dizisini boşaltıyor. Her seferinde boş bir bucket=[] oluşuyor.

print(add_item("a")) ifadesinde "a" çıktısını verir.
print(add_item("b")) ifadesinde "b" çıktısını verir.

## 6. Soru

Bilmiyorum

## 7. Soru

Tahmin ediyorum ama emin değilim. Yazdığım verileri tanımlayan benzersiz bir key ararım. Aynı keyi yazmasını önleyen bir kontrol koyabilirim.

# C. Docker

## 8. Soru

Container içerisinde image, network, db, app gibi yapıların paketli olduğu ortam.

Image containerın içerisinde çalıştırılması için tasarlanmış uygulamalar.

Container silinince içindeki veri neden kaybolur, bunu nasıl çözersin konusunu bilmiyorum

## 9. Soru

Bilmiyorum

# D. Linux

## 10. Soru

Bilmiyorum

## 11. Soru

grep ERROR 

ama emin değilim

## 12. Soru

Bilmiyorum

# E. Veri kavramları

## 13. Soru

Bilmiyorum

## 14. Soru

ETL = Extract -> Transfer -> Load
ELT = Extract -> Load -> Transfer

Tam olarak farkını ve neden hangisi kullanılır bilmiyorum

## 15. Soru

Bilmiyorum

