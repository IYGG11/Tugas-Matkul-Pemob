import 'package:flutter_test/flutter_test.dart';

import 'package:pertemuan_8/main.dart';
import 'package:pertemuan_8/models/admin.dart';
import 'package:pertemuan_8/models/user.dart';
import 'package:pertemuan_8/utils/constants.dart';

void main() {
  // Cek perhitungan ID dari NIM
  test('USER_ID dan ADMIN_ID dihitung dari N = 292', () {
    expect(USER_ID, 1791);
    expect(ADMIN_ID, 1084);
  });

  // Cek fromJson dan toJson Model User
  test('User.fromJson dan toJson', () {
    final user = User.fromJson({
      'id': 1791,
      'name': 'Masyhuri',
      'email': 'masyhuri@example.com',
      'city': 'Indonesia',
    });
    expect(user.id, 1791);
    expect(user.name, 'Masyhuri');
    expect(user.toJson()['city'], 'Indonesia');
  });

  // Cek fromJson dan toJson Model Admin
  test('Admin.fromJson dan toJson', () {
    final admin = Admin.fromJson({
      'id': 1084,
      'name': 'Admin Test',
      'email': 'admin@example.com',
      'department': 'IT',
    });
    expect(admin.id, 1084);
    expect(admin.department, 'IT');
    expect(admin.toJson()['name'], 'Admin Test');
  });

  // Cek halaman utama tampil dengan nama + NIM dan dua tab
  testWidgets('Home menampilkan nama, NIM, tab User dan Admin',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text(APP_TITLE), findsOneWidget);
    expect(find.text('User'), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);
  });
}
