import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skorAktivitas;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skorAktivitas,
  });

  // Mengambil digit NIM berdasarkan posisi dari belakang (1 = digit terakhir).
  int _digitDariBelakang(int posisi) {
    return int.parse(nim[nim.length - posisi]);
  }

  @override
  Widget build(BuildContext context) {
    final int digitTerakhir = _digitDariBelakang(1);
    final int digitKedua = _digitDariBelakang(2);

    // Atribut styling dihitung dari digit NIM sesuai formula tugas.
    final double lebarKartu = 320.0 + (digitKedua * 5);
    final double sudutLengkung = 12.0 + (digitTerakhir * 1.5);
    final double ukuranLogo = 60.0 + (digitTerakhir * 2);
    final double jarakPemisah = 15.0 + digitTerakhir;

    const TextStyle gayaDetail = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return Container(
      width: lebarKartu,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sudutLengkung),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header kartu
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sudutLengkung),
                  border: Border.all(color: Colors.blue.shade200, width: 2),
                ),
                child: FlutterLogo(size: ukuranLogo),
              ),
              SizedBox(width: jarakPemisah),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kartu Praktikan',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(thickness: 1.5),
          const SizedBox(height: 12),
          // Detail identitas
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('NIM : $nim', style: gayaDetail),
              const SizedBox(height: 8),
              Text('Hobi : $hobi', style: gayaDetail),
              const SizedBox(height: 8),
              Text('Skor Aktivitas : $skorAktivitas', style: gayaDetail),
            ],
          ),
        ],
      ),
    );
  }
}
