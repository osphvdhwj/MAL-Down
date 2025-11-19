# MAL Down - Troubleshooting Guide

This guide helps you debug and resolve common issues with the MAL Down project.

## 🚨 Common Issues

### 1. CI Test Failures

#### Problem: "0 tests passed, 1 failed"

**Cause:** No test files existed in the `test/` directory.

**Solution:** ✅ Fixed in PR #3
- Created comprehensive widget test suite
- Added test documentation
- Updated CI workflow to handle missing tests gracefully

**Verify fix:**
```bash
flutter test
```

Expected output:
```
✅ All tests passed!
```

---

### 2. Build Runner Issues

#### Problem: "Cannot find generated files (*.g.dart, *.freezed.dart)"

**Cause:** Code generation hasn't been run.

**Solution:**
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**For watching changes:**
```bash
flutter pub run build_runner watch
```

---

### 3. Asset Loading Errors

#### Problem: "Unable to load asset: assets/..."

**Cause:** Asset files referenced in pubspec.yaml don't exist.

**Current Status:**
- ✅ Asset directories exist with .gitkeep files
- 🟡 Font assets need to be added (currently using Google Fonts fallback)

**Solutions:**

**Option 1: Use Google Fonts Only (Recommended)**

Remove font section from `pubspec.yaml`:
```yaml
# Remove this section if not using local fonts
fonts:
  - family: Roboto
    fonts:
      - asset: assets/fonts/Roboto/Roboto-Regular.ttf
```

Google Fonts already provides Roboto via:
```dart
GoogleFonts.robotoTextTheme()
```

**Option 2: Add Local Fonts**

1. Download Roboto fonts from [Google Fonts](https://fonts.google.com/specimen/Roboto)
2. Create directory structure:
```
assets/
└── fonts/
    └── Roboto/
        ├── Roboto-Regular.ttf
        ├── Roboto-Bold.ttf
        └── Roboto-Medium.ttf
```
3. Run `flutter clean && flutter pub get`

---

### 4. Android Build Errors

#### Problem: "Execution failed for task ':app:processReleaseMainManifest'"

**Possible Causes:**
- Gradle cache corruption
- Kotlin version mismatch
- Dependency conflicts

**Solutions:**

```bash
# Clean build
flutter clean
cd android
./gradlew clean
cd ..

# Rebuild
flutter pub get
flutter build apk
```

#### Problem: "Java heap space" or "OutOfMemoryError"

**Solution:**

Edit `android/gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx4096m -XX:MaxMetaspaceSize=1024m
```

---

### 5. Linting Errors

#### Problem: "Too many linting errors"

**Project has 150+ lint rules enabled** - This is intentional for production quality.

**Check current issues:**
```bash
flutter analyze
```

**Auto-fix formatting:**
```bash
dart format .
```

**Common fixes:**

1. **Missing const constructors**
```dart
// ❌ Wrong
MyWidget()

// ✅ Correct
const MyWidget()
```

2. **Prefer single quotes**
```dart
// ❌ Wrong
String name = "MAL Down";

// ✅ Correct
String name = 'MAL Down';
```

3. **Require trailing commas**
```dart
// ❌ Wrong
Column(
  children: [
    Text('Hello'),
    Text('World')
  ]
)

// ✅ Correct
Column(
  children: [
    Text('Hello'),
    Text('World'),
  ],
)
```

---

### 6. Test Issues

#### Problem: "No Material widget found"

**Cause:** Widget test not wrapped in MaterialApp or ProviderScope.

**Solution:**
```dart
testWidgets('Test', (tester) async {
  await tester.pumpWidget(
    const ProviderScope(
      child: MaterialApp(
        home: YourWidget(),
      ),
    ),
  );
});
```

#### Problem: "Test timeout"

**Cause:** Widget has animations or async operations.

**Solution:**
```dart
// Wait for animations
await tester.pumpAndSettle();

// Or increase timeout
testWidgets('Test', (tester) async {
  // ...
}, timeout: const Timeout(Duration(seconds: 30)));
```

---

### 7. Dependency Conflicts

#### Problem: "Version solving failed"

**Solutions:**

```bash
# Update dependencies
flutter pub upgrade

# Force resolve
flutter pub get --no-precompile

# Clear cache
flutter pub cache repair
```

---

### 8. GitHub Actions Failures

#### Problem: "Workflow fails on analyze step"

**Check workflow logs:**
1. Go to Actions tab
2. Click failed workflow
3. Expand failed step

**Common fixes:**

```bash
# Run locally to reproduce
flutter analyze --fatal-infos
flutter test
```

#### Problem: "Test job skipped"

**Cause:** Analyze job failed (by design - tests need analysis to pass first).

**Solution:** Fix analysis errors first.

---

## 🔧 Debug Commands

### Flutter Environment
```bash
# Check Flutter installation
flutter doctor -v

# Check versions
flutter --version
dart --version

# List connected devices
flutter devices
```

### Dependencies
```bash
# Show dependency tree
flutter pub deps

# Show outdated packages
flutter pub outdated

# Upgrade all
flutter pub upgrade --major-versions
```

### Build Information
```bash
# Show available build flavors
flutter build apk --help

# Verbose build
flutter build apk --verbose

# Analyze binary size
flutter build apk --analyze-size
```

### Cleaning
```bash
# Full clean
flutter clean
flutter pub get

# Clear build cache
rm -rf build/

# Clear all caches
flutter pub cache clean
```

---

## 📊 Performance Profiling

### Profile Mode
```bash
# Run in profile mode
flutter run --profile

# With performance overlay
flutter run --profile --trace-skia
```

### Build Trace
```bash
# Trace build
flutter build apk --trace-skia

# Analyze build
flutter build apk --analyze-size
```

---

## 🐛 Known Issues

### 1. ProGuard Warnings

**Status:** Expected in release builds

**Impact:** None if rules are correct

**Monitor:** Check ProGuard logs after adding new dependencies

### 2. Google Fonts Download on First Run

**Status:** Expected behavior

**Impact:** First app launch downloads fonts (small delay)

**Solution:** Pre-cache fonts or use local fonts

---

## 📧 Getting Help

### Before Opening an Issue

1. **Check this troubleshooting guide**
2. **Run diagnostics:**
   ```bash
   flutter doctor -v
   flutter analyze
   flutter test
   ```
3. **Clean and rebuild:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

### Opening an Issue

Include:
- [ ] Flutter version (`flutter --version`)
- [ ] Error message (full stack trace)
- [ ] Steps to reproduce
- [ ] Expected vs actual behavior
- [ ] Device/emulator info

### Useful Links

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Project README](README.md)
- [Test Guide](test/README.md)
- [Issue Tracker](https://github.com/osphvdhwj/MAL-Down/issues)

---

## ✅ Checklist for Common Tasks

### Starting Development
```bash
☐ flutter doctor -v
☐ flutter pub get
☐ flutter pub run build_runner build --delete-conflicting-outputs
☐ flutter analyze
☐ flutter test
☐ flutter run
```

### Before Committing
```bash
☐ dart format .
☐ flutter analyze --fatal-infos
☐ flutter test
☐ git add .
☐ git commit -m "message"
```

### Before Release
```bash
☐ flutter test --coverage
☐ flutter analyze --fatal-infos
☐ flutter build apk --release
☐ Test release APK on physical device
☐ Check ProGuard logs
☐ Update version in pubspec.yaml
☐ Update CHANGELOG.md
```

---

**Last Updated:** 2025-11-19  
**Version:** 2.0.0
