import 'package:flutter/material.dart';

import '../models/admin.dart';
import '../services/admin_service.dart';
import '../utils/constants.dart';
import '../utils/ui_helper.dart';
import 'admin_detail_page.dart';

// Tab Admin: daftar admin + tombol lihat dan hapus admin ID 1084
class AdminListPage extends StatefulWidget {
  const AdminListPage({super.key});

  @override
  State<AdminListPage> createState() => _AdminListPageState();
}

class _AdminListPageState extends State<AdminListPage> {
  late Future<List<Admin>> futureAdmins;

  @override
  void initState() {
    super.initState();
    futureAdmins = AdminService.getAdmins(); // GET /admins saat halaman dibuka
  }

  // Ambil ulang daftar admin dari API
  void refreshData() {
    setState(() {
      futureAdmins = AdminService.getAdmins();
    });
  }

  // Buka halaman detail admin (GET /admins/{id})
  void openDetail(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminDetailPage(adminId: id)),
    ).then((_) => refreshData());
  }

  // DELETE: hapus admin 1084 (pakai konfirmasi dulu)
  Future<void> deleteAdmin() async {
    final yes = await showConfirmDialog(
      context,
      'Hapus Admin?',
      'Admin dengan ID $ADMIN_ID akan dihapus (DELETE /admins/$ADMIN_ID). '
          'Lanjutkan?',
    );
    if (!yes || !mounted) return;

    try {
      await AdminService.deleteAdmin(ADMIN_ID);
      if (!mounted) return;
      showSnack(
        context,
        'Admin ID $ADMIN_ID berhasil dihapus '
        '(status code: ${AdminService.lastStatusCode})',
      );
      showResultDialog(
        context,
        request: 'DELETE /admins/$ADMIN_ID',
        statusCode: AdminService.lastStatusCode,
        message: 'Admin ID $ADMIN_ID berhasil dihapus dari server.',
      );
      refreshData(); // daftar admin di-refresh setelah dihapus
    } catch (e) {
      if (!mounted) return;
      showSnack(context, 'Gagal menghapus admin ID $ADMIN_ID');
      showErrorDialog(context, 'DELETE /admins/$ADMIN_ID', e);
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
                  'Aksi Admin (ID $ADMIN_ID)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: () => openDetail(ADMIN_ID),
                      icon: const Icon(Icons.visibility),
                      label: const Text('Lihat Admin ID $ADMIN_ID'),
                    ),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: deleteAdmin,
                      icon: const Icon(Icons.delete),
                      label: const Text('Hapus Admin ID $ADMIN_ID'),
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
                'Daftar Admin (GET /admins)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: refreshData,
                icon: const Icon(Icons.refresh),
                label: const Text('Muat Ulang Admin'),
              ),
            ],
          ),
        ),

        // ===== Daftar admin dari API =====
        Expanded(
          child: FutureBuilder<List<Admin>>(
            future: futureAdmins,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return ErrorView(
                  request: 'GET /admins',
                  error: snapshot.error!,
                  onRetry: refreshData,
                );
              }
              final admins = snapshot.data ?? [];
              if (admins.isEmpty) {
                return const Center(child: Text('Belum ada data admin'));
              }
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: admins.length,
                itemBuilder: (context, index) {
                  final admin = admins[index];
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.admin_panel_settings),
                      ),
                      title: Text(
                        admin.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${admin.email} • ${admin.department}'),
                      trailing: Text('ID ${admin.id}'),
                      onTap: () => openDetail(admin.id),
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
