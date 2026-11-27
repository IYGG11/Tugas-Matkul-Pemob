import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

// ==========================================
// HELPER UI: dialog, snackbar, dan tampilan error
// Dipakai bersama oleh halaman User dan Admin
// ==========================================

// Keterangan singkat untuk status code yang sering muncul
String statusText(int code) {
  switch (code) {
    case 200:
      return '200 OK';
    case 201:
      return '201 Created';
    case 404:
      return '404 Not Found';
    case 500:
      return '500 Internal Server Error';
    default:
      return '$code';
  }
}

// Merapikan pesan error supaya enak dibaca di layar
String errorMessage(Object error) {
  // Kalau server tidak bisa dihubungi (json-server belum jalan)
  if (error is http.ClientException) {
    return 'Tidak bisa terhubung ke server.\n'
        'Pastikan json-server sudah berjalan di $BASE_URL';
  }
  // Hapus awalan "Exception: " bawaan Dart
  return error.toString().replaceFirst('Exception: ', '');
}

// Menampilkan SnackBar singkat di bagian bawah layar.
// SnackBar lama ditutup dulu supaya pesan tidak mengantre
void showSnack(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(SnackBar(content: Text(message)));
}

// Dialog konfirmasi sebelum DELETE.
// Mengembalikan true kalau user menekan "Ya, Hapus"
Future<bool> showConfirmDialog(
  BuildContext context,
  String title,
  String message,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.warning_amber_rounded,
          color: Colors.orange, size: 40),
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Batal'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Ya, Hapus'),
        ),
      ],
    ),
  );
  return result ?? false;
}

// Dialog hasil request yang berhasil.
// Menampilkan method + endpoint, status code, dan data hasil response
void showResultDialog(
  BuildContext context, {
  required String request,
  required int statusCode,
  Map<String, dynamic>? data,
  String? message,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.check_circle, color: Colors.green, size: 40),
      title: Text(request),
      content: SizedBox(
        width: 440,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Code: ${statusText(statusCode)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green.shade700,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 12),
              Text(message),
            ],
            if (data != null) ...[
              const SizedBox(height: 12),
              const Text('Response body:'),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                // Tampilkan data dalam format JSON yang rapi
                child: SelectableText(
                  const JsonEncoder.withIndent('  ').convert(data),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Tutup'),
        ),
      ],
    ),
  );
}

// Dialog untuk request yang gagal (misal 404 atau server mati)
void showErrorDialog(BuildContext context, String request, Object error) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.error, color: Colors.red, size: 40),
      title: Text(request),
      content: Text(errorMessage(error)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Tutup'),
        ),
      ],
    ),
  );
}

// Tampilan error di tengah layar + tombol "Coba Lagi"
class ErrorView extends StatelessWidget {
  final String request;
  final Object error;
  final VoidCallback onRetry;

  const ErrorView({
    super.key,
    required this.request,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 56),
            const SizedBox(height: 12),
            Text(
              request,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(errorMessage(error), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
