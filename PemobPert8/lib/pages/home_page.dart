import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'admin_list_page.dart';
import 'user_list_page.dart';

// Halaman utama: AppBar berisi nama & NIM, lalu dua tab (User dan Admin)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(APP_TITLE),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'User'),
              Tab(icon: Icon(Icons.admin_panel_settings), text: 'Admin'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserListPage(),
            AdminListPage(),
          ],
        ),
      ),
    );
  }
}
