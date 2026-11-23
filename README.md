# Veri Mühendisliği Yolculuğu

Sıfırdan sağlam bir temel kurarak data engineer / data ops öğrenme günlüğüm ve laboratuvarım.
Amaç: araç ezberlemek değil, problemi anlamak, analiz etmek ve çözüm üretmek.

## Yapı
- `docs/` : yol haritası, çalışma kuralları, güncel ilerleme
- `gunluk/` : her adımın cevapları ve görevleri (yanlışlar silinmez)
- `sql/seed/` : veritabanının ilk kurulum betikleri
- `sql/calismalar/` : kendi yazdığım sorgular
- `docker-compose.yml` : yerel PostgreSQL laboratuvarı

## Laboratuvarı çalıştırma
```bash
colima start --cpu 2 --memory 3 --disk 20
docker compose up -d
docker compose ps        # STATUS "healthy" olana kadar bekle
docker compose exec db psql -U lab -d lab
```
Bağlantı: host `localhost`, port `5432`, db `lab`, kullanıcı `lab`, parola `lab` (yalnızca yerel laboratuvar için).

Sıfırdan başlamak için: `docker compose down -v && docker compose up -d`

Not: `sql/seed/` içindeki betikler yalnızca veritabanı ilk oluşturulurken çalışır.
