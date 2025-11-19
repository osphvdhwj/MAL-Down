# MAL Down Test Suite

This directory contains all tests for the MAL Down application.

## Test Structure

```
test/
├── README.md           # This file
├── widget_test.dart    # Widget and UI tests
└── main_test.dart       # Main app initialization tests
```

## Running Tests

### Run all tests
```bash
flutter test
```

### Run tests with coverage
```bash
flutter test --coverage
```

### Run specific test file
```bash
flutter test test/widget_test.dart
```

### Run tests with verbose output
```bash
flutter test --reporter expanded
```

## Test Coverage

After running tests with coverage, you can view the coverage report:

### Generate HTML coverage report
```bash
# Install lcov (Ubuntu/Debian)
sudo apt-get install lcov

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open in browser
open coverage/html/index.html
```

## Current Test Coverage

### Widget Tests (`widget_test.dart`)
- ✅ App initialization and title display
- ✅ Feature items rendering
- ✅ Import button functionality with snackbar
- ✅ Settings button functionality with snackbar
- ✅ Floating Action Button presence
- ✅ Icon rendering
- ✅ Theme switching (light/dark mode)
- ✅ HomeScreen rendering

### Unit Tests (`main_test.dart`)
- ✅ App instantiation
- ✅ HomeScreen instantiation

## Adding New Tests

When adding features, ensure you add corresponding tests:

### Widget Test Example
```dart
testWidgets('Description of what to test', (WidgetTester tester) async {
  // Build the widget
  await tester.pumpWidget(
    const ProviderScope(
      child: MALDownApp(),
    ),
  );

  // Wait for animations
  await tester.pumpAndSettle();

  // Find widgets
  expect(find.text('Expected Text'), findsOneWidget);

  // Interact with widgets
  await tester.tap(find.text('Button'));
  await tester.pumpAndSettle();

  // Verify results
  expect(find.text('Result'), findsOneWidget);
});
```

### Unit Test Example
```dart
test('Description of what to test', () {
  // Setup
  final value = calculateSomething();

  // Verify
  expect(value, equals(expectedValue));
});
```

## Test Best Practices

1. **One assertion per test** - Keep tests focused
2. **Use descriptive names** - Test names should explain what they test
3. **AAA Pattern** - Arrange, Act, Assert
4. **Mock external dependencies** - Use mockito for API calls, databases, etc.
5. **Test edge cases** - Don't just test the happy path
6. **Keep tests fast** - Avoid unnecessary delays
7. **Use `pumpAndSettle()`** - Wait for all animations to complete
8. **Clean up** - Reset state between tests

## Future Test Additions

As features are implemented, add tests for:

- [ ] XML parsing functionality
- [ ] Download manager with retry logic
- [ ] Database operations (Sqflite)
- [ ] EXIF metadata embedding
- [ ] File organization logic
- [ ] Background tasks (WorkManager)
- [ ] Notification handling
- [ ] Settings persistence
- [ ] Navigation flows (GoRouter)
- [ ] State management (Riverpod providers)

## CI/CD Integration

Tests are automatically run on:
- Every push to `main`, `feature/*`, `fix/*` branches
- Every pull request to `main`

See `.github/workflows/flutter-ci.yml` for CI configuration.

## Troubleshooting

### Tests fail with "No Material widget found"
Wrap your widget with `MaterialApp` or `ProviderScope`:
```dart
await tester.pumpWidget(
  const MaterialApp(
    home: YourWidget(),
  ),
);
```

### Tests timeout
Increase timeout or check for infinite loops:
```dart
testWidgets('Test', (WidgetTester tester) async {
  // ...
}, timeout: const Timeout(Duration(seconds: 30)));
```

### Golden file tests fail
Update golden files:
```bash
flutter test --update-goldens
```

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Widget Testing](https://docs.flutter.dev/cookbook/testing/widget/introduction)
- [Unit Testing](https://docs.flutter.dev/cookbook/testing/unit/introduction)
- [Mockito Documentation](https://pub.dev/packages/mockito)
- [flutter_test API](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
