import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('Portfolio homepage displays owner info and triggers SnackBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify InfoCard contents
    expect(find.text('2506534964'), findsOneWidget);
    expect(find.text('Adam Wahyu Syaputra'), findsOneWidget);
    expect(find.text('PBP D'), findsOneWidget);

    // Verify ItemCard buttons
    expect(find.text('Lihat Portofolio'), findsOneWidget);
    expect(find.text('Tambah Item'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);

    // Tap 'Lihat Portofolio' and verify SnackBar message
    await tester.tap(find.text('Lihat Portofolio'));
    await tester.pump();
    expect(
      find.text('Kamu telah menekan tombol Lihat Portofolio!'),
      findsOneWidget,
    );
  });
}
