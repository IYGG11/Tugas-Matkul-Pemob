# Pemrograman Mobile Pertemuan 9: Flutter Counter App

[![Live Demo di Vercel](https://img.shields.io/badge/Live%20Demo-Vercel-000000?style=for-the-badge&logo=vercel&logoColor=white)](https://pertemuan9masyhuriyudhistira.vercel.app/)

**Live demo:** https://pertemuan9masyhuriyudhistira.vercel.app/

Aplikasi Flutter sederhana berupa penghitung (*counter*): setiap kali tombol **+** ditekan, angka di tengah layar bertambah satu. Aplikasi ini di-build sebagai Flutter Web dan di-deploy ke Vercel.

## Identitas

| | |
|---|---|
| **Nama** | Masyhuri Yudhistira |
| **NIM** | 20240801229 |
| **Mata Kuliah** | Pemrograman Mobile, Pertemuan 9 |
| **Kampus** | Universitas Esa Unggul, Teknik Informatika |

## Fitur

Semua kode aplikasi ada di [`lib/main.dart`](lib/main.dart):

- **Halaman utama** (`MyHomePage`) dengan `AppBar` berjudul *Flutter Demo Home Page*.
- **Penghitung** di tengah layar dengan teks *"You have pushed the button this many times:"* dan angka yang dimulai dari 0.
- **Tombol tambah** (`FloatingActionButton` berikon **+**, tooltip *Increment*) yang menaikkan angka sebanyak 1 setiap kali ditekan.
- **State management** sederhana memakai `StatefulWidget` dan `setState()`.
- **Tema Material** dengan skema warna dari `ColorScheme.fromSeed(seedColor: Colors.deepPurple)`; warna `AppBar` memakai `inversePrimary`.

> Nilai penghitung hanya disimpan di memori, jadi akan kembali ke 0 saat halaman dimuat ulang.

## Teknologi

- **Flutter** (channel stable) dan **Dart** SDK `^3.13.5`
- **cupertino_icons** `^1.0.8`: ikon gaya iOS
- **flutter_lints** `^6.0.0` (*dev dependency*): aturan lint untuk menjaga kualitas kode
- **Vercel**: hosting statis untuk hasil build Flutter Web

## Menjalankan secara lokal

Pastikan Flutter SDK sudah terpasang (cek dengan `flutter doctor`), lalu jalankan:

```bash
flutter pub get
flutter run
```

Untuk menjalankan versi web di browser Chrome:

```bash
flutter run -d chrome
```

## Build dan deploy ke Vercel

Vercel **tidak menjalankan proses build di server**. Vercel hanya menyajikan file statis dari folder `build/web` yang sudah di-commit ke repo, jadi build dilakukan di komputer lokal.

1. Build versi web:

   ```bash
   flutter build web --release
   ```

2. Commit dan push folder `build/web`:

   ```bash
   git add build/web
   git commit -m "update build web"
   git push origin main
   ```

   Hanya `build/web` yang ikut ke git. Isi `build/` lainnya diabaikan lewat `.gitignore`:

   ```gitignore
   /build/*
   !/build/web/
   ```

3. Vercel otomatis men-deploy ulang setelah push. Konfigurasinya ada di [`vercel.json`](vercel.json):

   ```json
   {
     "$schema": "https://openapi.vercel.sh/vercel.json",
     "outputDirectory": "build/web",
     "rewrites": [
       { "source": "/(.*)", "destination": "/" }
     ]
   }
   ```

   - `outputDirectory` menunjuk ke `build/web`, folder yang disajikan Vercel.
   - `rewrites` mengarahkan path yang tidak cocok dengan file mana pun ke `index.html`, sehingga aplikasi tetap terbuka walaupun URL-nya bukan root.

   Pengaturan project di dashboard Vercel: **Framework Preset** = *Other*, **Build Command** = kosong, **Output Directory** = `build/web`.

> Setiap kali kode di `lib/` diubah, ulangi langkah 1 dan 2. Tanpa build ulang, Vercel tetap menyajikan versi lama.

## Struktur folder

```
pemmobpert9/
├── lib/
│   └── main.dart        # Kode aplikasi (MyApp, MyHomePage)
├── web/                 # Template web: index.html, manifest.json, ikon
├── build/
│   └── web/             # Hasil `flutter build web`, disajikan oleh Vercel
├── android/, ios/, linux/, macos/, windows/   # Kode platform bawaan Flutter
├── test/
│   └── widget_test.dart # Widget test bawaan untuk counter
├── pubspec.yaml         # Metadata dan dependency project
├── vercel.json          # Konfigurasi deploy Vercel
└── .gitignore           # Mengabaikan build/ kecuali build/web/
```
