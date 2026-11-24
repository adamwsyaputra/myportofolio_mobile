import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_detail_screen.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

ApiClient _createMockApiClient() {
  final mockHttp = MockClient((request) async {
    if (request.method == 'GET' && request.url.path == '/api/v1/projects/') {
      return http.Response(
        jsonEncode([
          {
            'id': '11111111-1111-1111-1111-111111111111',
            'title': 'Portfolio Website',
            'description': 'Personal Django + Flutter portfolio app.',
            'tech_stack': 'Django, Flutter',
            'project_url': 'https://example.com/portfolio',
            'project_image_url': '',
          },
        ]),
        200,
        headers: {'content-type': 'application/json'},
      );
    }

    if (request.method == 'POST' && request.url.path == '/api/v1/auth/token/') {
      return http.Response(
        jsonEncode({'token': 'mock-token-123'}),
        200,
        headers: {'content-type': 'application/json'},
      );
    }

    if (request.method == 'POST' &&
        request.url.path == '/api/v1/auth/logout/') {
      return http.Response('', 204);
    }

    if (request.method == 'POST' && request.url.path == '/api/v1/projects/') {
      if (request.headers['Authorization'] != 'Token mock-token-123') {
        return http.Response('{"detail": "Unauthorized"}', 401);
      }
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      return http.Response(
        jsonEncode({'id': '22222222-2222-2222-2222-222222222222', ...body}),
        201,
        headers: {'content-type': 'application/json'},
      );
    }

    return http.Response('Not Found', 404);
  });

  return ApiClient(client: mockHttp, baseUrl: 'http://localhost:8000');
}

Future<void> _scrollAndTap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
}

void main() {
  testWidgets(
    'Homepage loads public projects list and opens ProjectDetailScreen without login',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(apiClient: _createMockApiClient()));

      expect(find.text('2506534964'), findsOneWidget);
      expect(find.text('Adam Wahyu Syaputra'), findsOneWidget);
      expect(find.text('PBP D'), findsOneWidget);

      await _scrollAndTap(tester, find.text('Lihat Portofolio'));
      await tester.pumpAndSettle();

      expect(find.byType(ProjectListScreen), findsOneWidget);
      expect(find.text('Portfolio Website'), findsOneWidget);
      expect(find.text('Django, Flutter'), findsOneWidget);

      await tester.tap(find.text('Portfolio Website'));
      await tester.pumpAndSettle();
      expect(find.byType(ProjectDetailScreen), findsOneWidget);
      expect(find.text('https://example.com/portfolio'), findsOneWidget);
    },
  );

  testWidgets(
    'Guarded Add Project prompts LoginScreen, authenticates, and submits POST with token',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(apiClient: _createMockApiClient()));

      // Unauthenticated tap on Tambah Proyek opens LoginScreen
      await _scrollAndTap(tester, find.text('Tambah Proyek'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);

      // Submit login form
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'admin',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'secret',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      // Should now be on ProjectFormPage
      expect(find.byType(ProjectFormPage), findsOneWidget);

      // Dismiss the navigation SnackBar so it does not obscure the Save button
      ScaffoldMessenger.of(tester.element(find.byType(ProjectFormPage)))
          .hideCurrentSnackBar();
      await tester.pumpAndSettle();

      // Fill and submit project form
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'),
        'Mobile DRF App',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Description'),
        'Connected to Django REST Framework.',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Tech Stack'),
        'Flutter, DRF',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Project URL'),
        'https://example.com/drf-app',
      );

      final saveButton = find.widgetWithText(ElevatedButton, 'Save');
      await _scrollAndTap(tester, saveButton);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Project added successfully!'), findsOneWidget);
      expect(find.text('Title: Mobile DRF App'), findsOneWidget);
    },
  );

  testWidgets(
    'ExperienceFormPage navigation, validation, and narrow 360x800 viewport render cleanly',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(MyApp(apiClient: _createMockApiClient()));
      await tester.pumpAndSettle();

      // Open drawer and navigate to Add Experience
      tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
      await tester.pumpAndSettle();
      expect(find.text('Login'), findsOneWidget);
      await tester.tap(find.text('Add Experience'));
      await tester.pumpAndSettle();
      expect(find.byType(ExperienceFormPage), findsOneWidget);

      // Return Home via drawer
      tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(MyHomePage), findsOneWidget);
    },
  );
}
