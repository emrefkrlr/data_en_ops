# Yol haritası (yaklaşık 9-12 ay)

Tek uzun soluklu proje üzerinde faz faz büyüyen bir sistem kurulur (aday: e-ticaret fiyat istihbaratı, gayrimenkul ilan trendi, kamu açık verisi, ileride iş ilanı beceri analizi).

| Faz | Konu | Süre |
|---|---|---|
| 0 | Tanı, Git/GitHub, ortam (Colima, Postgres), shell, Python çalışma modeli | 2-3 hafta |
| 1 | Veri modelleme ve SQL derinliği (Kimball, SCD, window, EXPLAIN, indeks) | 4-6 hafta |
| 2 | Ingestion: scraping'i mühendisliğe çevirmek (idempotency, retry, schema drift, incremental load, Parquet) | 4-6 hafta |
| 3 | Transformation ve dbt (ELT, staging/intermediate/marts, testler) | 4-6 hafta |
| 4 | Orkestrasyon (Airflow veya Dagster) | 4-6 hafta |
| 5 | DataOps (CI/CD, data quality, lineage, gözlemlenebilirlik, secret yönetimi) | 4-6 hafta |
| 6 | Streaming ve lakehouse temelleri (Redpanda/Kafka, Iceberg/Delta) | 4 hafta |
| 7 | Bulut ve capstone (GCP veya AWS, Terraform'a giriş) | süregelen |

Not: LinkedIn scraping kullanım şartlarına aykırıdır. Faz 2'de alternatif kaynaklar ve hukuki sınırlar ayrıca değerlendirilecek.
