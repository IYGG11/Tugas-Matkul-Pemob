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
| [`PemobPert8/`](PemobPert8/) | Model User & Admin dengan REST API | Disalin langsung (bukan dari repo Git) |
| [`PemobPert9/`](PemobPert9/) | Counter App, deploy Flutter Web ke Vercel | [IYGG11/pertemuan_9_Masyhuri_yudhistira](https://github.com/IYGG11/pertemuan_9_Masyhuri_yudhistira) |

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

### PemobPert8

Aplikasi **Model User & Admin dengan REST API** (package `pertemuan_8`). Berisi model
`User` dan `Admin` dengan `fromJson()`/`toJson()`, service yang memakai package `http`,
dan halaman dengan dua tab (User dan Admin):

- User: GET daftar dan detail, lalu POST, PUT, PATCH, dan DELETE untuk user ID `1791`.
- Admin: GET daftar dan detail, lalu DELETE admin ID `1084` dengan dialog konfirmasi.
- ID dihitung dari NIM: N = `292` (229 dengan angka tengah digeser ke belakang),
  ID User = 1499 + N, ID Admin = 792 + N.
- Setiap request menampilkan endpoint, status code, dan response body, termasuk saat gagal (mis. 404).

Backend-nya json-server lokal dengan data di `mock_api/db.json`. Jalankan dari folder
`PemobPert8/` dengan `npx json-server@0.17.4 --watch mock_api/db.json --port 3000`.
Laporan lengkap ada di [`LAPORAN_PERTEMUAN_8.md`](PemobPert8/LAPORAN_PERTEMUAN_8.md) dan folder `laporan/`.

### PemobPert9

Aplikasi **Counter** (package `pemmobpert9`) yang di-build sebagai Flutter Web dan di-deploy ke Vercel.
Halaman utamanya menampilkan angka penghitung yang bertambah 1 setiap kali tombol **+**
ditekan (`StatefulWidget` + `setState()`).

- Live demo: https://pertemuan9masyhuriyudhistira.vercel.app/
- Hasil `flutter build web --release` ikut di-commit di `build/web/`, dan Vercel menyajikan
  folder itu langsung sesuai `vercel.json` (tanpa proses build di server).

Laporan ada di folder [`laporan/`](PemobPert9/laporan/). Detail cara build dan deploy ada di
[`PemobPert9/README.md`](PemobPert9/README.md).

## Cara Membuka

Setiap folder adalah **project Flutter terpisah**. Buka satu per satu di Android Studio
(**File > Open**, lalu pilih folder project-nya, misalnya `TugasPemobPert4/`), bukan
folder root repo ini. Setelah dibuka, jalankan `flutter pub get` sebelum menjalankan aplikasi.
