# Panduan Upload ke GitHub

Folder ini sudah disusun sebagai repository yang siap dipublikasikan. Anda tidak perlu mengubah nama file atau struktur foldernya.

## Metadata Repository

Gunakan informasi berikut saat membuat repository:

| Field GitHub | Isi yang disarankan |
|---|---|
| Repository name | `thelook-ecommerce-sql-analysis` |
| Description | `BigQuery analysis of TheLook Ecommerce data covering growth, category performance, pricing, repeat purchases, returns, and customer health.` |
| Visibility | Public |
| Topics | `sql`, `bigquery`, `data-analysis`, `ecommerce`, `looker-studio`, `business-intelligence`, `portfolio-project` |

## Langkah Upload Melalui Browser

1. Ekstrak file ZIP portfolio di komputer Anda.
2. Masuk ke GitHub, lalu klik tanda **+** di kanan atas dan pilih **New repository**.
3. Masukkan nama `thelook-ecommerce-sql-analysis`.
4. Salin description dari tabel di atas.
5. Pilih **Public**.
6. Jangan centang pembuatan README, `.gitignore`, atau license karena semuanya yang diperlukan sudah ada di paket ini.
7. Klik **Create repository**.
8. Pada halaman repository kosong, pilih **uploading an existing file**.
9. Buka folder hasil ekstraksi. Pilih seluruh isi di dalam folder tersebut—`README.md`, folder `sql`, `assets`, `data`, dan `docs`—kemudian seret ke area upload GitHub. Jangan mengunggah folder induknya sebagai satu tingkat tambahan.
10. Gunakan commit message: `Add TheLook ecommerce SQL portfolio project`.
11. Klik **Commit changes**.
12. Setelah upload selesai, klik ikon pengaturan di bagian **About**, masukkan description dan topics dari tabel di atas, lalu simpan.

## Quality Check Setelah Upload

Buka repository menggunakan Incognito/Private Window dan periksa:

- `README.md` otomatis tampil di halaman utama;
- keenam gambar terlihat;
- setiap tautan **View SQL query** dapat dibuka;
- tidak ada tulisan placeholder yang belum diganti di halaman utama;
- repository berstatus Public;
- nama Anda konsisten dengan CV dan LinkedIn.

## File yang Sebaiknya Tidak Diunggah

- PDF soal assignment;
- data mentah hasil ekspor BigQuery;
- credential, API key, billing information, atau project ID pribadi;
- versi draft dengan nama seperti `final-fix`, `new`, atau `revision-2`;
- slide asli jika bahasa dan rekomendasinya belum dipoles.

Visual yang relevan dari presentasi sudah dimasukkan sebagai file PNG di folder `assets/`, sehingga recruiter tetap dapat melihat output analisis tanpa perlu membuka slide asli.

## Setelah Repository Terbit

1. Buka profil GitHub Anda.
2. Pilih **Customize your pins** dan pin repository ini.
3. Tambahkan tautan langsung repository ke bagian **Projects** di CV.
4. Tambahkan project ke bagian **Projects** LinkedIn.
5. Gunakan wording siap pakai di [cv-linkedin-copy.md](cv-linkedin-copy.md).

## Commit Berikutnya

Jika nanti Anda memperbaiki isi repository, gunakan pesan commit yang spesifik, misalnya:

- `Improve business recommendations`
- `Add fixed-date analysis snapshot`
- `Update customer health visualization`
- `Clarify return-rate definition`

