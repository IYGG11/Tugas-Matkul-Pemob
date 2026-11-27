import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/user_service.dart';
import '../utils/constants.dart';
import '../utils/ui_helper.dart';
import 'user_detail_page.dart';

// Tab User: daftar user + tombol aksi POST, PUT, PATCH, DELETE + cari by ID
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> futureUsers;

  // Input untuk "Cari by ID", isi awalnya USER_ID (1791)
  final idController = TextEditingController(text: USER_ID.toString());

  @override
  void initState() {
    super.initState();
    futureUsers = UserService.getUsers(); // GET /users saat halaman dibuka
  }

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  // Ambil ulang daftar user dari API
  void refreshData() {
    setState(() {
      futureUsers = UserService.getUsers();
    });
  }

  // Buka halaman detail user (GET /users/{id})
  void openDetail(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDetailPage(userId: id)),
    );
  }

  // Tombol "Cari by ID"
  void searchUser() {
    final id = int.tryParse(idController.text.trim());
    if (id == null) {
      showSnack(context, 'Masukkan ID berupa angka');
      return;
    }
    openDetail(id);
  }

  // POST: tambah user baru dengan id = USER_ID (1791)
  Future<void> postUser() async {
    final newUser = User(
      id: USER_ID,
      name: 'Masyhuri',
      email: 'masyhuri@example.com',
      city: 'Indonesia',
    );
    try {
      final result = await UserService.createUser(newUser);
      if (!mounted) return;
      showSnack(context, 'POST berhasil: user ID ${result.id} ditambahkan');
      showResultDialog(
        context,
        request: 'POST /users',
        statusCode: UserService.lastStatusCode,
        data: result.toJson(),
      );
      refreshData();
    } catch (e) {
      if (!mounted) return;
      showSnack(context, 'POST gagal');
      showErrorDialog(context, 'POST /users', e);
    }
  }

  // PUT: ganti name dan email user 1791
  Future<void> putUser() async {
    final updatedUser = User(
      id: USER_ID,
      name: NAMA,
      email: 'masyhuri.yudhistira@example.com',
      city: 'Indonesia',
    );
    try {
      final result = await UserService.updateUser(updatedUser);
      if (!mounted) return;
      showSnack(context, 'PUT berhasil: name & email user $USER_ID diganti');
      showResultDialog(
        context,
        request: 'PUT /users/$USER_ID',
        statusCode: UserService.lastStatusCode,
        data: result.toJson(),
      );
      refreshData();
    } catch (e) {
      if (!mounted) return;
      showSnack(context, 'PUT gagal');
      showErrorDialog(context, 'PUT /users/$USER_ID', e);
    }
  }

  // PATCH: tambahkan teks " - Flutter Developer" di belakang name
  Future<void> patchUser() async {
    try {
      // Ambil name yang sekarang dulu, lalu ditambah teks
      final current = await UserService.getUser(USER_ID);
      final newName = '${current.name} - Flutter Developer';

      final result = await UserService.patchUser(USER_ID, newName);
      if (!mounted) return;
      showSnack(context, 'PATCH berhasil: name user $USER_ID diperbarui');
      showResultDialog(
        context,
        request: 'PATCH /users/$USER_ID',
        statusCode: UserService.lastStatusCode,
        data: result.toJson(),
      );
      refreshData();
    } catch (e) {
      if (!mounted) return;
      showSnack(context, 'PATCH gagal');
      showErrorDialog(context, 'PATCH /users/$USER_ID', e);
    }
  }

  // DELETE: hapus user 1791 (pakai konfirmasi dulu)
  Future<void> deleteUser() async {
    final yes = await showConfirmDialog(
      context,
      'Hapus User?',
      'User dengan ID $USER_ID akan dihapus (DELETE /users/$USER_ID). Lanjutkan?',
    );
    if (!yes || !mounted) return;

    try {
      await UserService.deleteUser(USER_ID);
      if (!mounted) return;
      showSnack(context, 'DELETE berhasil: user ID $USER_ID dihapus');
      showResultDialog(
        context,
        request: 'DELETE /users/$USER_ID',
        statusCode: UserService.lastStatusCode,
        message: 'User ID $USER_ID berhasil dihapus dari server.',
      );
      refreshData();
    } catch (e) {
      if (!mounted) return;
      showSnack(context, 'DELETE gagal');
      showErrorDialog(context, 'DELETE /users/$USER_ID', e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Kartu tombol aksi =====
        Card(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aksi User (ID $USER_ID)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: postUser,
                      icon: const Icon(Icons.add),
                      label: const Text('POST User $USER_ID'),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: putUser,
                      icon: const Icon(Icons.edit),
                      label: const Text('PUT User $USER_ID'),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: patchUser,
                      icon: const Icon(Icons.edit_note),
                      label: const Text('PATCH User $USER_ID'),
                    ),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: deleteUser,
                      icon: const Icon(Icons.delete),
                      label: const Text('DELETE User $USER_ID'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Cari user berdasarkan ID
                Row(
                  children: [
                    SizedBox(
                      width: 160,
                      child: TextField(
                        controller: idController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'User ID',
                          border: OutlineInputBorder(),
                          isDense: true,
                          prefixIcon: Icon(Icons.numbers),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: searchUser,
                      icon: const Icon(Icons.search),
                      label: const Text('Cari by ID'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // ===== Judul daftar + tombol muat ulang =====
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text(
                'Daftar User (GET /users)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: refreshData,
                icon: const Icon(Icons.refresh),
                label: const Text('Muat Ulang User'),
              ),
            ],
          ),
        ),

        // ===== Daftar user dari API =====
        Expanded(
          child: FutureBuilder<List<User>>(
            future: futureUsers,
            builder: (context, snapshot) {
              // Loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              // Error
              if (snapshot.hasError) {
                return ErrorView(
                  request: 'GET /users',
                  error: snapshot.error!,
                  onRetry: refreshData,
                );
              }
              // Data kosong
              final users = snapshot.data ?? [];
              if (users.isEmpty) {
                return const Center(child: Text('Belum ada data user'));
              }
              // Data berhasil diambil
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          user.name.isNotEmpty ? user.name[0] : '?',
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${user.email} • ${user.city}'),
                      trailing: Text('ID ${user.id}'),
                      onTap: () => openDetail(user.id),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
