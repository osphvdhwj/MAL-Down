# MAL-Down Setup Guide - 2025 Edition

## Quick Start

This guide will help you set up and build MAL-Down after the 2025 modernization update.

## Prerequisites

### Required Software

1. **Flutter SDK 3.24.0+**
   ```bash
   flutter --version
   # Should show 3.24.0 or higher
   ```

2. **Dart SDK 3.5.0+**
   ```bash
   dart --version
   # Should show 3.5.0 or higher
   ```

3. **Android Studio** or **VS Code** with Flutter/Dart extensions

4. **Java JDK 17**
   ```bash
   java -version
   # Should show version 17
   ```

5. **Android SDK**
   - Platform: Android 15 (API 35)
   - Build Tools: 35.0.0
   - Command Line Tools: Latest

### Optional Tools

- **Git** for version control
- **Make** for using Makefile commands
- **ADB** for device debugging

## Installation Steps

### 1. Clone and Checkout

```bash
# Clone the repository
git clone https://github.com/osphvdhwj/MAL-Down.git
cd MAL-Down

# Checkout the modernized branch
git checkout feature/2025-modernization
```

### 2. Verify Flutter Setup

```bash
# Check Flutter installation
flutter doctor -v

# Update Flutter if needed
flutter upgrade

# Accept Android licenses
flutter doctor --android-licenses
```

### 3. Clean and Install Dependencies

```bash
# Clean any previous builds
flutter clean

# Remove old dependencies
rm -rf .dart_tool/
rm pubspec.lock

# Get dependencies
flutter pub get
```

If you get dependency resolution errors, ensure you're using compatible versions:
- Flutter: 3.24.0+
- Dart: 3.5.0+

### 4. Run Code Generation

```bash
# Generate code for Riverpod, Freezed, JSON
flutter pub run build_runner build --delete-conflicting-outputs
```

For continuous generation during development:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 5. Verify Setup

```bash
# Check for issues
flutter analyze

# Format code
dart format .

# Run tests (if available)
flutter test
```

## Running the App

### Development Mode

```bash
# Run on connected device/emulator
flutter run

# Run with hot reload enabled
flutter run --debug
```

### Using Makefile (Recommended)

If you have Make installed:

```bash
# See all available commands
make help

# Complete setup
make setup

# Run in development
make run-dev

# Build release APK
make build-release
```

## Building Release APKs

### For Poco X5 Pro (ARM64 only)

```bash
flutter build apk \
  --release \
  --target-platform android-arm64 \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
```

Or with Make:
```bash
make build-apk-arm64
```

### For All Devices (ARM64 + ARM)

```bash
flutter build apk \
  --release \
  --split-per-abi \
  --target-platform android-arm64,android-arm \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
```

Or with Make:
```bash
make build-release
```

### For Play Store (App Bundle)

```bash
flutter build appbundle \
  --release \
  --target-platform android-arm64,android-arm \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
```

Or with Make:
```bash
make build-appbundle
```

## Troubleshooting

### Issue: "equatable ^2.0.8 which doesn't match any versions"

**Solution**: This is from an old cached pubspec. Make sure you're on the `feature/2025-modernization` branch:

```bash
git checkout feature/2025-modernization
git pull origin feature/2025-modernization
flutter clean
rm pubspec.lock
flutter pub get
```

### Issue: Gradle build fails

**Solution**: Update Android Gradle plugin:

```bash
# Clean Gradle cache
cd android
./gradlew clean
cd ..

# Rebuild
flutter clean
flutter pub get
flutter build apk --release
```

### Issue: "SDK version doesn't match"

**Solution**: Ensure correct versions:

```bash
# Check versions
flutter --version
dart --version
java -version

# Update if needed
flutter upgrade
flutter doctor -v
```

### Issue: Code generation fails

**Solution**: Clear build cache:

```bash
flutter clean
rm -rf .dart_tool/
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: ProGuard errors in release build

**Solution**: Check ProGuard rules:

1. Verify `android/app/proguard-rules.pro` exists
2. Check `android/app/build.gradle` has:
   ```gradle
   buildTypes {
       release {
           minifyEnabled true
           shrinkResources true
           proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
       }
   }
   ```

### Issue: Permission errors on Android 13+

**Solution**: The manifest is already updated for Android 13+. Make sure to:

1. Request permissions at runtime
2. Use `READ_MEDIA_IMAGES` instead of `READ_EXTERNAL_STORAGE` on Android 13+
3. Test on Android 13+ device/emulator

## VS Code Setup

### Recommended Extensions

The project includes `.vscode/extensions.json` with recommended extensions:

- Dart Code
- Flutter
- Flutter Snippets
- Awesome Flutter Snippets
- Error Lens
- Code Spell Checker
- GitLens

### VS Code Settings

The project includes `.vscode/settings.json` with optimal settings for Flutter development.

### Launch Configurations

Three launch configurations are available:
1. **MAL Down (Debug)** - Development build
2. **MAL Down (Release)** - Release build
3. **MAL Down (Profile)** - Performance profiling

Press F5 to start debugging with the default configuration.

## Project Structure

After setup, your project should look like:

```
MAL-Down/
├── android/               # Android native code
│   ├── app/
│   │   ├── build.gradle   # Updated for Android 15
│   │   ├── proguard-rules.pro
│   │   └── src/main/
│   │       ├── AndroidManifest.xml
│   │       └── res/xml/
│   │           ├── file_paths.xml
│   │           └── data_extraction_rules.xml
├── lib/
│   └── main.dart          # Material Design 3 app
├── .github/
│   └── workflows/
│       └── flutter-ci.yml # CI/CD pipeline
├── .vscode/               # VS Code configuration
├── pubspec.yaml           # Updated dependencies
├── analysis_options.yaml  # 2025 linting rules
├── Makefile              # Build automation
├── README.md             # Project documentation
├── MODERNIZATION_2025.md # Migration guide
├── CHANGELOG.md          # Version history
└── SETUP_GUIDE.md        # This file
```

## Next Steps

After successful setup:

1. **Review Documentation**
   - Read `README.md` for project overview
   - Check `MODERNIZATION_2025.md` for migration details
   - Review `CHANGELOG.md` for version history

2. **Start Development**
   - Implement core features (XML parsing, download manager)
   - Add database layer with Sqflite
   - Set up EXIF metadata service
   - Configure WorkManager background tasks

3. **Testing**
   - Write unit tests
   - Add widget tests
   - Create integration tests
   - Test on real devices

4. **Build and Deploy**
   - Test release builds
   - Optimize APK size
   - Prepare for Play Store
   - Set up signing configuration

## Common Commands Reference

### Flutter Commands

```bash
# Install dependencies
flutter pub get

# Run app
flutter run

# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release

# Analyze code
flutter analyze

# Format code
dart format .

# Run tests
flutter test

# Clean build
flutter clean
```

### Make Commands

```bash
make help            # Show all commands
make setup           # Initial setup
make clean           # Clean build
make get             # Get dependencies
make generate        # Run code generation
make analyze         # Analyze code
make test            # Run tests
make build-release   # Build release APK
make build-appbundle # Build App Bundle
make run-dev         # Run in dev mode
```

### Git Commands

```bash
# Switch to modernization branch
git checkout feature/2025-modernization

# Pull latest changes
git pull origin feature/2025-modernization

# Check current branch
git branch

# View changes
git status
```

## Support

If you encounter issues:

1. Check this setup guide
2. Review troubleshooting section
3. Check [MODERNIZATION_2025.md](MODERNIZATION_2025.md)
4. Run `flutter doctor -v`
5. Create a GitHub issue with:
   - Error message
   - Flutter doctor output
   - Steps to reproduce

## Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Material Design 3](https://m3.material.io)
- [Riverpod Documentation](https://riverpod.dev)
- [Android Developer Guide](https://developer.android.com)

---

**Last Updated**: November 16, 2025  
**Flutter Version**: 3.24.0+  
**Dart Version**: 3.5.0+  
**Target Android**: API 35 (Android 15)
