import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

void main() {
  testWidgets(
    'Homepage displays owner info, 4 distinct cards, and triggers SnackBar',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('2506534964'), findsOneWidget);
      expect(find.text('Adam Wahyu Syaputra'), findsOneWidget);
      expect(find.text('PBP D'), findsOneWidget);

      expect(find.text('Lihat Portofolio'), findsOneWidget);
      expect(find.text('Tambah Proyek'), findsOneWidget);
      expect(find.text('Tambah Pengalaman'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);

      await tester.ensureVisible(find.text('Lihat Portofolio'));
      await tester.tap(find.text('Lihat Portofolio'));
      await tester.pump();
      expect(
        find.text('Kamu telah menekan tombol Lihat Portofolio!'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Action cards navigate via push and drawer navigates via pushReplacement',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Navigate to ProjectFormPage via action card
      await tester.ensureVisible(find.text('Tambah Proyek'));
      await tester.tap(find.text('Tambah Proyek'));
      await tester.pumpAndSettle();
      expect(find.byType(ProjectFormPage), findsOneWidget);

      // Simulate system Back pop to return to MyHomePage
      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pumpAndSettle();
      expect(find.byType(MyHomePage), findsOneWidget);

      // Navigate to ExperienceFormPage via action card
      await tester.ensureVisible(find.text('Tambah Pengalaman'));
      await tester.tap(find.text('Tambah Pengalaman'));
      await tester.pumpAndSettle();
      expect(find.byType(ExperienceFormPage), findsOneWidget);

      // Simulate system Back pop to return to MyHomePage
      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pumpAndSettle();
      expect(find.byType(MyHomePage), findsOneWidget);

      // Open drawer from homepage and navigate to Add Experience
      tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add Experience'));
      await tester.pumpAndSettle();
      expect(find.byType(ExperienceFormPage), findsOneWidget);

      // Open drawer from ExperienceFormPage and return Home
      tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(MyHomePage), findsOneWidget);
    },
  );

  testWidgets(
    'ExperienceFormPage validates empty/invalid inputs and shows summary dialog when valid',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.ensureVisible(find.text('Tambah Pengalaman'));
      await tester.tap(find.text('Tambah Pengalaman'));
      await tester.pumpAndSettle();

      // Enter whitespace-only required fields and invalid URL
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Judul Pengalaman'),
        '   ',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Deskripsi Peran'),
        '   ',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'URL Thumbnail (Opsional)'),
        'bukan-url',
      );

      // Turn off ongoing toggle to verify end date requirement as well
      final switchFinder = find.byType(SwitchListTile);
      await tester.ensureVisible(switchFinder);
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      final saveButton = find.widgetWithText(ElevatedButton, 'Simpan');
      await tester.ensureVisible(saveButton);
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(find.text('Judul pengalaman tidak boleh kosong.'), findsOneWidget);
      expect(find.text('Deskripsi peran tidak boleh kosong.'), findsOneWidget);
      expect(
        find.text('URL thumbnail harus diawali http:// atau https:// yang valid.'),
        findsOneWidget,
      );
      expect(find.text('Tanggal mulai wajib dipilih.'), findsOneWidget);
      expect(
        find.text('Tanggal selesai wajib dipilih jika pengalaman sudah selesai.'),
        findsOneWidget,
      );
      expect(find.byType(AlertDialog), findsNothing);

      // Toggle back to ongoing
      await tester.ensureVisible(switchFinder);
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      // Fill valid details
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Judul Pengalaman'),
        'Software Engineer Intern',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Deskripsi Peran'),
        'Membangun API portofolio dengan Django.',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'URL Thumbnail (Opsional)'),
        'https://example.com/intern.png',
      );

      // Pick start date
      final startDateFinder = find.text('Pilih tanggal mulai');
      await tester.ensureVisible(startDateFinder);
      await tester.tap(startDateFinder);
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // Submit valid form
      await tester.ensureVisible(saveButton);
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Pengalaman berhasil disimpan!'), findsOneWidget);
      expect(find.text('Judul: Software Engineer Intern'), findsOneWidget);
      expect(find.text('Kategori: Full-Time'), findsOneWidget);
      expect(
        find.text('Deskripsi: Membangun API portofolio dengan Django.'),
        findsOneWidget,
      );
      expect(
        find.text('Thumbnail: https://example.com/intern.png'),
        findsOneWidget,
      );
      expect(find.text('Status: Sedang berlangsung'), findsOneWidget);

      // Close dialog and verify form resets
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Pilih tanggal mulai'), findsOneWidget);
    },
  );
}
