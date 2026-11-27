import 'package:flutter/material.dart';

import '../models/admin.dart';
import '../services/admin_service.dart';
import '../utils/constants.dart';
import '../utils/ui_helper.dart';

// Halaman detail Admin: memanggil GET /admins/{id}
class AdminDetailPage extends StatefulWidget {
  final int adminId;

  const AdminDetailPage({super.key, required this.adminId});

  @override
  State<AdminDetailPage> createState() => _AdminDetailPageState();
}

class _AdminDetailPageState extends State<AdminDetailPage> {
  late Future<Admin> futureAdmin;

  @override
  void initState() {
    super.initState();
    futureAdmin = AdminService.getAdmin(widget.adminId);
  }

  void refreshData() {
    setState(() {
      futureAdmin = AdminService.getAdmin(widget.adminId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(APP_TITLE)),
      body: FutureBuilder<Admin>(
        future: futureAdmin,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Contoh: setelah admin 1084 dihapus, request ini akan 404
          if (snapshot.hasError) {
            return ErrorView(
              request: 'GET /admins/${widget.adminId}',
              error: snapshot.error!,
              onRetry: refreshData,
            );
          }

          final admin = snapshot.data!;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'Detail Admin',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'GET /admins/${widget.adminId}  •  '
                    'Status Code: ${statusText(AdminService.lastStatusCode)}',
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.badge),
                          title: const Text('ID'),
                          subtitle: Text('${admin.id}'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Nama'),
                          subtitle: Text(admin.name),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(admin.email),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.apartment),
                          title: const Text('Department'),
                          subtitle: Text(admin.department),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
