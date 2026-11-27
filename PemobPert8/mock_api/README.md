# Mock API (json-server)

REST API lokal untuk Praktikum Pertemuan 8. Ada dua resource:

| Resource | Endpoint |
|---|---|
| User  | `/users`, `/users/:id` |
| Admin | `/admins`, `/admins/:id` |

`db.json` adalah data yang dipakai server. Isinya berubah setiap ada POST, PUT, PATCH, atau DELETE.
`db.backup.json` adalah data awal: 10 user dan 5 admin, termasuk admin ID 1084. User ID 1791 sengaja tidak ada, karena dibuat lewat POST dari aplikasi.

## Cara menjalankan

Syarat: Node.js sudah terpasang. Jalankan perintah ini dari folder root proyek (`pertemuan_8`):

```powershell
npx json-server@0.17.4 --watch mock_api/db.json --port 3000
```

Biarkan terminal tetap terbuka selama aplikasi dipakai. Cek di browser: http://localhost:3000/users dan http://localhost:3000/admins

## Reset data ke awal

Hentikan server (Ctrl+C), salin backup ke `db.json`, lalu jalankan lagi:

```powershell
Copy-Item mock_api/db.backup.json mock_api/db.json
```

## Base URL di aplikasi

Base URL diatur di satu tempat, yaitu konstanta `BASE_URL` di `lib/utils/constants.dart`. Ganti sesuai device:

| Device | BASE_URL |
|---|---|
| Chrome / Windows (Flutter Web/Desktop) | `http://localhost:3000` |
| Emulator Android | `http://10.0.2.2:3000` |
| HP fisik (satu Wi-Fi dengan laptop) | `http://<IP-laptop>:3000`, dan server dijalankan dengan tambahan `--host 0.0.0.0` |

Catatan: `10.0.2.2` adalah alamat khusus emulator Android untuk mengakses `localhost` laptop.
