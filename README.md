# MAL Down 📱

**MAL Down - The ultimate MyAnimeList image downloader with intelligent organization and AVES Gallery metadata embedding**

[![Flutter Version](https://img.shields.io/badge/Flutter-3.32+-02569B?logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.5+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Android](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android)](https://www.android.com)
[![Material Design 3](https://img.shields.io/badge/Material-Design%203-757575?logo=material-design)](https://m3.material.io)

## 🌟 Features

### Core Functionality

- ✅ **XML Import**: Parse MyAnimeList anime and manga export files
- ✅ **Smart Download**: 5 automatic retry attempts with exponential backoff
- ✅ **EXIF Metadata**: Full metadata embedding compatible with AVES Gallery
- ✅ **Intelligent Organization**: Auto-categorize into Anime/Manga/Hentai folders
- ✅ **Genre Subfolders**: Automatic genre-based subfolder creation
- ✅ **Placeholder Generation**: Creates informative images when downloads fail
- ✅ **Background Processing**: Download in background with WorkManager
- ✅ **Progress Tracking**: Real-time download progress with notifications
- ✅ **Offline-First**: Full offline functionality with local database

### User Interface

- 🎨 **Material Design 3**: Modern, beautiful UI following MD3 guidelines
- 🌓 **Dark Mode**: Full dark theme support with true black AMOLED optimization
- 📊 **Statistics Dashboard**: Track your collection and downloads
- 🔍 **Search & Filter**: Find entries by title, genre, or status
- 📱 **Optimized for Poco X5 Pro**: 120Hz AMOLED display support
- 🎭 **Smooth Animations**: 60fps animations and transitions

### Advanced Features

- 💾 **Smart Caching**: Efficient image and data caching
- 📋 **Batch Operations**: Process multiple entries at once
- 🔔 **Notifications**: Download progress and completion alerts
- 🗂️ **Gallery Integration**: Seamless integration with Android gallery apps
- 🏷️ **Tag Management**: Organize with custom tags
- 📈 **Analytics**: Track download statistics and storage usage
- 🔒 **Security**: Secure storage for sensitive data, SSL pinning

## 🚀 Installation

### Prerequisites

- Flutter SDK 3.32.0 or higher
- Dart SDK 3.5.0 or higher
- Android Studio / VS Code
- Android SDK (API 23 - 35)
- Java JDK 17+
- Git

### Quick Start

```bash
# Clone the repository
git clone https://github.com/osphvdhwj/MAL-Down.git
cd MAL-Down

# Checkout the modernized branch
git checkout feature/2025-modernization

# Install dependencies
flutter pub get

# Generate code (for Riverpod, Freezed, JSON)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Building Release APK

```bash
# Build App Bundle for Play Store (Recommended)
flutter build appbundle \
  --release \
  --target-platform android-arm64,android-arm \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols

# Build Split APKs for direct distribution
flutter build apk \
  --release \
  --split-per-abi \
  --target-platform android-arm64,android-arm \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols

# Build for Poco X5 Pro specifically (ARM64 only)
flutter build apk \
  --release \
  --target-platform android-arm64 \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
```

## 📋 Requirements

### Target Device: Poco X5 Pro

- **Display**: 6.67" AMOLED, 1080x2400, 120Hz
- **Processor**: Qualcomm Snapdragon 778G
- **RAM**: 6GB/8GB
- **Storage**: 128GB/256GB
- **Android**: 12+ (upgradable to 13/14)

### Minimum Requirements

- **Android**: 6.0 (API 23) or higher
- **Target**: Android 15 (API 35)
- **RAM**: 3GB minimum
- **Storage**: 500MB for app + space for images
- **Internet**: Required for downloads

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **MVVM** pattern and modern 2025 best practices.

### Project Structure

```
lib/
├── core/                        # Core utilities and constants
│   ├── constants/              # App-wide constants
│   ├── error/                  # Error handling
│   ├── network/                # Network configuration
│   ├── theme/                  # Material Design 3 theming
│   └── utils/                  # Utility functions
├── features/                    # Feature modules
│   ├── download/
│   │   ├── data/              # Data layer
│   │   │   ├── datasources/   # Remote & local data sources
│   │   │   ├── models/        # Data models
│   │   │   └── repositories/  # Repository implementations
│   │   ├── domain/            # Domain layer
│   │   │   ├── entities/      # Business entities
│   │   │   ├── repositories/  # Repository interfaces
│   │   │   └── usecases/      # Business logic
│   │   └── presentation/      # Presentation layer
│   │       ├── providers/     # Riverpod providers
│   │       ├── pages/         # UI pages
│   │       └── widgets/       # Reusable widgets
│   ├── import/                # XML import feature
│   ├── gallery/               # Gallery integration
│   └── settings/              # App settings
└── main.dart                   # App entry point
```

### Key Technologies

- **State Management**: Riverpod 2.6+ with code generation
- **UI Framework**: Material Design 3
- **Database**: Sqflite for local storage
- **Networking**: Dio 5.7+ with retry interceptor
- **Background Tasks**: WorkManager
- **Navigation**: GoRouter
- **Code Generation**: Build Runner, Freezed, JSON Serializable

## 📚 Documentation

- **[DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)**: Complete development documentation
- **[CONTRIBUTING.md](CONTRIBUTING.md)**: Contribution guidelines
- **[CHANGELOG.md](CHANGELOG.md)**: Version history
- **[BUILD_STATUS.md](BUILD_STATUS.md)**: Build and deployment status
- **[PROJECT_INFO.md](PROJECT_INFO.md)**: Detailed project information

## 🔧 Configuration

### Environment Setup

1. **Flutter Configuration**
   ```bash
   flutter doctor -v
   flutter channel stable
   flutter upgrade
   ```

2. **Android SDK Setup**
   - Install Android SDK Platform 35 (Android 15)
   - Install Android SDK Build-Tools 35.0.0
   - Accept Android licenses: `flutter doctor --android-licenses`

3. **Code Generation**
   ```bash
   # One-time build
   flutter pub run build_runner build --delete-conflicting-outputs
   
   # Watch mode for development
   flutter pub run build_runner watch --delete-conflicting-outputs
   ```

### ProGuard Configuration

The app includes comprehensive ProGuard rules for release builds:
- Flutter framework optimization
- Database and EXIF preservation
- Logging removal for production
- Size reduction techniques

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Generate coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 🔐 Security Features

- ✅ **Secure Storage**: Encrypted storage for sensitive data
- ✅ **SSL Pinning**: Certificate pinning for network security
- ✅ **Input Validation**: Comprehensive input sanitization
- ✅ **ProGuard**: Code obfuscation for release builds
- ✅ **Permission Management**: Runtime permission handling for Android 13+

## 📦 Dependencies

### Core Dependencies
- `flutter_riverpod`: ^2.6.1 - State management
- `dio`: ^5.7.0 - HTTP client
- `sqflite`: ^2.4.1 - Local database
- `workmanager`: ^0.5.2 - Background tasks
- `native_exif`: ^0.6.2 - EXIF metadata
- `go_router`: ^14.6.2 - Navigation

See [pubspec.yaml](pubspec.yaml) for complete dependency list.

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

### Development Workflow

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes following the code style guidelines
4. Run tests: `flutter test`
5. Run linter: `flutter analyze`
6. Commit changes: `git commit -m 'Add amazing feature'`
7. Push to branch: `git push origin feature/amazing-feature`
8. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **MyAnimeList** for providing anime/manga data
- **AVES Gallery** for metadata standards
- **Flutter Team** for the amazing framework
- **Material Design** for design guidelines
- **Contributors** for making this project better

## 📮 Support

- 🐛 **Report Bugs**: [GitHub Issues](https://github.com/osphvdhwj/MAL-Down/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/osphvdhwj/MAL-Down/discussions)
- 📧 **Contact**: Create an issue on GitHub

## 🎯 Roadmap

- [x] Material Design 3 implementation
- [x] Android 14+ compliance
- [x] Comprehensive ProGuard rules
- [x] Security enhancements
- [ ] MyAnimeList API integration
- [ ] Cloud backup support
- [ ] Multi-language support
- [ ] Dark theme variations
- [ ] Advanced filtering options
- [ ] Export functionality

---

**Made with ❤️ using Flutter and Material Design 3**

⭐ Star this repository if you found it helpful!

[Report Bug](https://github.com/osphvdhwj/MAL-Down/issues) • [Request Feature](https://github.com/osphvdhwj/MAL-Down/issues) • [Documentation](https://github.com/osphvdhwj/MAL-Down/wiki)
