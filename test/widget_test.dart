import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fildisi_web/app.dart';

void main() {
  testWidgets('App boots smoke test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const FildisiApp());
    await tester.pumpAndSettle();

    // Should show navigation items (TR default).
    expect(find.text('Hakkında'), findsWidgets);
    expect(find.text('Galeri'), findsWidgets);
    expect(find.text('İletişim'), findsWidgets);
  });
}
