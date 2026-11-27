# Tugas Mata Kuliah Pemrograman Mobile

| | |
|---|---|
| **Nama** | Masyhuri Yudhistira |
| **NIM** | 20240801229 |
| **Program Studi** | Teknik Informatika |
| **Universitas** | Universitas Esa Unggul |

Repositori ini menggabungkan tugas-tugas Flutter mata kuliah Pemrograman Mobile.
Setiap tugas berasal dari repo terpisah dan digabung dengan `git subtree`, sehingga
riwayat commit dari repo asal tetap tersimpan.

## Daftar Isi

| Folder | Tugas | Repo asal |
|---|---|---|
| [`TugasPemobPert4/`](TugasPemobPert4/) | Pencatatan Stok Barang (Firebase) | [IYGG11/TugasPemobPert4](https://github.com/IYGG11/TugasPemobPert4) |
| [`Tugas_Layout_Flutter/`](Tugas_Layout_Flutter/) | Kartu Praktikan (layout dasar) | [IYGG11/Tugas_Layout_Flutter](https://github.com/IYGG11/Tugas_Layout_Flutter) |
| [`PemobPert5/`](PemobPert5/) | Pencatatan Stok Barang (Firebase) | [IYGG11/PemobPert5](https://github.com/IYGG11/PemobPert5) |

### TugasPemobPert4

Aplikasi **Pencatatan Stok Barang** (package `pertemuan4pemob`). Berisi form input data
barang: nama barang, tanggal masuk, tanggal keluar, kode barang, dan jumlah stok.
Validasinya mengikuti aturan berbasis NIM:

- Nama barang wajib diawali inisial nama depan (`M`).
- Kode barang minimal 6 angka dan diawali 3 angka terakhir NIM (`229`), karena NIM ganjil.
- Tanggal dipilih lewat date picker, dan tanggal keluar tidak boleh sebelum tanggal masuk.
- Padding card, sudut card, dan tinggi tombol dihitung dari digit terakhir NIM.

Data disimpan ke Cloud Firestore (collection `stok_barang`).
Dependensi utama: `firebase_core`, `cloud_firestore`, `url_launcher`.

### Tugas_Layout_Flutter

Aplikasi **Kartu Praktikan** (package `tugas_layout_flutter`). Latihan layout dasar Flutter
(`Container`, `Row`, `Column`, `Expanded`, `Divider`, `BoxDecoration`) yang menampilkan
kartu profil berisi nama, NIM, hobi, dan skor aktivitas. Lebar kartu, sudut lengkung,
ukuran logo, jarak, dan warna latar dihitung dari digit NIM.

### PemobPert5

Package `pertemuan4pemob`. Saat ini isi folder ini sama persis dengan `TugasPemobPert4/`
(repo asalnya menunjuk ke commit yang sama), yaitu aplikasi Pencatatan Stok Barang.

## Cara Membuka

Setiap folder adalah **project Flutter terpisah**. Buka satu per satu di Android Studio
(**File > Open**, lalu pilih folder project-nya, misalnya `TugasPemobPert4/`), bukan
folder root repo ini. Setelah dibuka, jalankan `flutter pub get` sebelum menjalankan aplikasi.
