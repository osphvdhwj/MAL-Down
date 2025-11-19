import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal_down/main.dart';

void main() {
  group('MALDownApp Widget Tests', () {
    testWidgets('App loads and displays title', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        const ProviderScope(
          child: MALDownApp(),
        ),
      );

      // Wait for all animations and async operations to complete
      await tester.pumpAndSettle();

      // Verify that the app title appears in the AppBar
      expect(find.text('MAL Down'), findsOneOrMoreWidgets);

      // Verify that key UI elements are present
      expect(find.text('MyAnimeList Image Downloader'), findsOneWidget);
      expect(find.text('Import XML File'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Home screen displays feature items', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MALDownApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify feature items are displayed
      expect(find.text('Smart Download'), findsOneWidget);
      expect(find.text('Auto Organization'), findsOneWidget);
      expect(find.text('EXIF Metadata'), findsOneWidget);

      // Verify feature descriptions
      expect(find.text('Automatic retry with exponential backoff'), findsOneWidget);
      expect(find.text('Categorize by type and genre'), findsOneWidget);
      expect(find.text('Full AVES Gallery integration'), findsOneWidget);
    });

    testWidgets('Import button shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MALDownApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the Import XML File button
      await tester.tap(find.text('Import XML File'));
      await tester.pumpAndSettle();

      // Verify snackbar appears with correct message
      expect(find.text('Import functionality coming soon!'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('Settings button shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MALDownApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the Settings button
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      // Verify snackbar appears with correct message
      expect(find.text('Settings functionality coming soon!'), findsOneWidget);
    });

    testWidgets('FAB is present', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MALDownApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify floating action button exists
      expect(find.text('New Download'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Icons are displayed correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MALDownApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify icons are present
      expect(find.byIcon(Icons.download_rounded), findsOneWidget);
      expect(find.byIcon(Icons.file_upload_outlined), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
      expect(find.byIcon(Icons.add_rounded), findsOneWidget);
      expect(find.byIcon(Icons.cloud_download_outlined), findsOneWidget);
      expect(find.byIcon(Icons.folder_outlined), findsOneWidget);
      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
    });

    testWidgets('Theme switches correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MALDownApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Get the MaterialApp widget
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      // Verify theme and darkTheme are set
      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, isNotNull);
      expect(materialApp.themeMode, ThemeMode.system);
    });
  });

  group('HomeScreen Widget Tests', () {
    testWidgets('HomeScreen renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify key elements
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.text('MAL Down'), findsAtLeastNWidgets(1));
    });
  });
}
