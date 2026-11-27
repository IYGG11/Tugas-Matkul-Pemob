import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'pages/home_page.dart';
import 'utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Aktifkan semantics: tombol & teks jadi bisa dibaca screen reader
  // dan bisa diklik oleh tool otomasi (Playwright) di Flutter Web
  SemanticsBinding.instance.ensureSemantics();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_TITLE,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}
