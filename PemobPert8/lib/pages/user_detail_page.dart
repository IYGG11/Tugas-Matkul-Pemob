import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/user_service.dart';
import '../utils/constants.dart';
import '../utils/ui_helper.dart';

// Halaman detail User: memanggil GET /users/{id}
class UserDetailPage extends StatefulWidget {
  final int userId;

  const UserDetailPage({super.key, required this.userId});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = UserService.getUser(widget.userId);
  }

  void refreshData() {
    setState(() {
      futureUser = UserService.getUser(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(APP_TITLE)),
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return ErrorView(
              request: 'GET /users/${widget.userId}',
              error: snapshot.error!,
              onRetry: refreshData,
            );
          }

          final user = snapshot.data!;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'Detail User',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'GET /users/${widget.userId}  •  '
                    'Status Code: ${statusText(UserService.lastStatusCode)}',
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.badge),
                          title: const Text('ID'),
                          subtitle: Text('${user.id}'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Nama'),
                          subtitle: Text(user.name),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(user.email),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.location_city),
                          title: const Text('Kota'),
                          subtitle: Text(user.city),
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
