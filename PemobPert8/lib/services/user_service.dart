import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../utils/constants.dart';

// Service User: semua request HTTP ke endpoint /users ada di sini
class UserService {
  // Status code dari request terakhir, dipakai UI untuk ditampilkan
  static int lastStatusCode = 0;

  // Header untuk request yang mengirim body JSON
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // GET /users -> ambil semua user
  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$BASE_URL/users'));
    lastStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      // Ubah setiap item JSON menjadi objek User
      return data.map((item) => User.fromJson(item)).toList();
    }
    throw Exception(
      'Gagal mengambil daftar user (status code: ${response.statusCode})',
    );
  }

  // GET /users/{id} -> ambil satu user berdasarkan ID
  static Future<User> getUser(int id) async {
    final response = await http.get(Uri.parse('$BASE_URL/users/$id'));
    lastStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 404) {
      throw Exception('User dengan ID $id tidak ditemukan (status code: 404)');
    }
    throw Exception(
      'Gagal mengambil user (status code: ${response.statusCode})',
    );
  }

  // POST /users -> tambah user baru (id ikut dikirim, yaitu USER_ID)
  static Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/users'),
      headers: headers,
      body: jsonEncode(user.toJson()),
    );
    lastStatusCode = response.statusCode;

    // 201 Created = data berhasil dibuat
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }
    // json-server membalas 500 kalau ID sudah dipakai
    throw Exception(
      'Gagal menambah user ID ${user.id}, kemungkinan ID sudah ada '
      '(status code: ${response.statusCode})',
    );
  }

  // PUT /users/{id} -> ganti seluruh data user (name, email, city)
  static Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$BASE_URL/users/${user.id}'),
      headers: headers,
      body: jsonEncode(user.toJson()),
    );
    lastStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 404) {
      throw Exception(
        'User dengan ID ${user.id} tidak ditemukan (status code: 404)',
      );
    }
    throw Exception(
      'Gagal update user (status code: ${response.statusCode})',
    );
  }

  // PATCH /users/{id} -> ubah sebagian data, di sini hanya name
  static Future<User> patchUser(int id, String name) async {
    final response = await http.patch(
      Uri.parse('$BASE_URL/users/$id'),
      headers: headers,
      body: jsonEncode({'name': name}),
    );
    lastStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 404) {
      throw Exception('User dengan ID $id tidak ditemukan (status code: 404)');
    }
    throw Exception(
      'Gagal patch user (status code: ${response.statusCode})',
    );
  }

  // DELETE /users/{id} -> hapus user berdasarkan ID
  static Future<bool> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$BASE_URL/users/$id'));
    lastStatusCode = response.statusCode;

    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 404) {
      throw Exception('User dengan ID $id tidak ditemukan (status code: 404)');
    }
    throw Exception(
      'Gagal menghapus user (status code: ${response.statusCode})',
    );
  }
}
