# MAL Down 📱

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Android](https://img.shields.io/badge/Android-12%2B-3DDC84?logo=android)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Android-blue)
![Device](https://img.shields.io/badge/Optimized%20for-Poco%20X5%20Pro-orange)

**MAL Down - The ultimate MyAnimeList image downloader with intelligent organization and AVES Gallery metadata embedding**

</div>

---

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

---

## 🚀 Installation

### Prerequisites
- Flutter SDK 3.0 or higher
- Android Studio / VS Code
- Android SDK (API 23+)
- Git

### Quick Start

```bash
# Clone the repository
git clone https://github.com/osphvdhwj/MAL-Down.git
cd MAL-Down

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Building Release APK

```bash
# Build for Poco X5 Pro (ARM64)
flutter build apk --release --target-platform android-arm64 --split-per-abi
```

---

## 📋 Requirements

### Target Device: Poco X5 Pro
- **Display**: 6.67" AMOLED, 1080x2400, 120Hz
- **Processor**: Qualcomm Snapdragon 778G
- **RAM**: 6GB/8GB
- **Storage**: 128GB/256GB
- **Android**: 12+ (upgradable to 13)

### Minimum Requirements
- **Android**: 6.0 (API 23) or higher
- **RAM**: 3GB minimum
- **Storage**: 500MB for app + space for images
- **Internet**: Required for downloads

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **MVVM** pattern.

### Key Components
- **Riverpod** for state management
- **Material Design 3** for UI
- **Sqflite** for local database
- **Dio** for HTTP requests
- **WorkManager** for background tasks

---

## 📚 Documentation

- **[DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)**: Complete development documentation
- **[CONTRIBUTING.md](CONTRIBUTING.md)**: Contribution guidelines
- **[CHANGELOG.md](CHANGELOG.md)**: Version history

---

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **MyAnimeList** for providing anime/manga data
- **AVES Gallery** for metadata standards
- **Flutter Team** for the amazing framework
- **Material Design** for design guidelines

---

<div align="center">

**Made with ❤️ using Flutter**

⭐ Star this repository if you found it helpful!

[Report Bug](https://github.com/osphvdhwj/MAL-Down/issues) • [Request Feature](https://github.com/osphvdhwj/MAL-Down/issues)

</div>