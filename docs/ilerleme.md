# İlerleme

Son güncelleme: 2026-11-23

## Şu an
Faz 0. Adım 3b görevleri (rank fonksiyonları, Soru 3'ün ilk adımı) ve Adım 4 (Postgres + Docker deneyleri) sırada.

## Tanı testi sonucu (Adım 1)
| Alan | Durum |
|---|---|
| SQL window function | Boşluk, Adım 2-3'te kapanmaya başladı (PARTITION BY, LAG sağlam) |
| SQL mantıksal işlem sırası | Boşluk (FROM, WHERE, GROUP BY, HAVING, window, SELECT, ORDER BY) |
| RANK / DENSE_RANK / ROW_NUMBER | Boşluk, Adım 3b'de çalışılacak |
| Python mutable default argument | Boşluk (yanlış model) |
| Python generator / bellek | Boşluk |
| Docker image/container/volume | Boşluk |
| Docker depends_on / healthcheck | Boşluk |
| Linux cron, chmod, process | Boşluk (grep yön doğru) |
| OLTP/OLAP, ETL/ELT, idempotent | Boşluk / yüzeysel (idempotency sezgisi var) |

## Güçlü yanlar
- Hata mesajını okuyup nedenini çıkarma
- GROUP BY, PARTITION BY, LAG kavramsal olarak doğru anlaşılmış
- Test verisini zorlayıcı tasarlama
- Dürüst raporlama

## Açık görevler
- [ ] Adım 3b / Görev 1-3
- [ ] Soru 3'ü (30 gün içinde ikinci sipariş oranı) tamamla
- [ ] Adım 4: Docker deneyleri
- [ ] Colima çıktıları: `colima status`, `docker version`, `docker compose version`
- [ ] Sıradaki: Linux/shell, Python çalışma modeli, sonra Git ve proje iskeleti
