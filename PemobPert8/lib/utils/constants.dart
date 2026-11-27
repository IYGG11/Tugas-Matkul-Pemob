// ignore_for_file: constant_identifier_names
// (nama konstanta sengaja ditulis HURUF BESAR sesuai ketentuan tugas)

// ==========================================
// KONSTANTA IDENTITAS & KONFIGURASI API
// Semua nilai penting disimpan di satu file ini,
// supaya tidak di-hardcode di banyak tempat.
// ==========================================

const String NAMA = 'Masyhuri Yudhistira';
const String NIM = '20240801229';

// N: 3 digit terakhir NIM = 229,
// angka tengah (2) digeser ke belakang -> 292
const int N = 292;

// ID yang dipakai untuk pengujian
const int USER_ID = 1499 + N; // 1791
const int ADMIN_ID = 792 + N; // 1084

// Teks yang tampil di AppBar setiap halaman
const String APP_TITLE = '$NAMA - $NIM';

// Base URL json-server. Ganti sesuai device yang dipakai:
// - Chrome / Windows   : http://localhost:3000
// - Emulator Android   : http://10.0.2.2:3000
const String BASE_URL = 'http://localhost:3000';
