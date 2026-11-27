import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_layout_flutter/main.dart';

void main() {
  testWidgets('ProfileCard menampilkan data dan styling dari NIM',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Kartu Praktikan'), findsOneWidget);
    expect(find.text('Masyhuri Yudhistira'), findsOneWidget);
    expect(find.text('NIM : 20240801229'), findsOneWidget);
    expect(find.text('Skor Aktivitas : 79'), findsOneWidget);

    // NIM 20240801229: digit terakhir 9, digit ke-2 dari belakang 2.
    final FlutterLogo logo = tester.widget(find.byType(FlutterLogo));
    expect(logo.size, 78.0);

    final Scaffold scaffold = tester.widget(find.byType(Scaffold));
    final BuildContext context = tester.element(find.byWidget(scaffold));
    expect(Theme.of(context).scaffoldBackgroundColor, Colors.tealAccent[100]);
  });
}
