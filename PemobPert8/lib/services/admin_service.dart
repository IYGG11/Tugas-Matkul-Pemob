import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/admin.dart';
import '../utils/constants.dart';

// Service Admin: semua request HTTP ke endpoint /admins ada di sini
class AdminService {
  // Status code dari request terakhir, dipakai UI untuk ditampilkan
  static int lastStatusCode = 0;

  // GET /admins -> ambil semua admin
  static Future<List<Admin>> getAdmins() async {
    final response = await http.get(Uri.parse('$BASE_URL/admins'));
    lastStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      // Ubah setiap item JSON menjadi objek Admin
      return data.map((item) => Admin.fromJson(item)).toList();
    }
    throw Exception(
      'Gagal mengambil daftar admin (status code: ${response.statusCode})',
    );
  }

  // GET /admins/{id} -> ambil satu admin berdasarkan ID
  static Future<Admin> getAdmin(int id) async {
    final response = await http.get(Uri.parse('$BASE_URL/admins/$id'));
    lastStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      return Admin.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 404) {
      throw Exception('Admin dengan ID $id tidak ditemukan (status code: 404)');
    }
    throw Exception(
      'Gagal mengambil admin (status code: ${response.statusCode})',
    );
  }

  // DELETE /admins/{id} -> hapus admin berdasarkan ID
  static Future<bool> deleteAdmin(int id) async {
    final response = await http.delete(Uri.parse('$BASE_URL/admins/$id'));
    lastStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 404) {
      throw Exception('Admin dengan ID $id tidak ditemukan (status code: 404)');
    }
    throw Exception(
      'Gagal menghapus admin (status code: ${response.statusCode})',
    );
  }
}
