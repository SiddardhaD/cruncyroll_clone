# Crunchyroll Anime Streaming App

A modern anime streaming application built with Flutter using BLoC state management and clean architecture.

## Features

- 🎬 Browse trending, popular, and recent anime
- 📺 Watch anime episodes with custom video player
- ⭐ Add anime to favorites
- 🔍 Search functionality
- 📱 Responsive UI for all devices
- 🎨 Beautiful dark theme with Crunchyroll branding
- 💾 Offline caching support
- 🏗️ Clean architecture implementation

## Architecture

This project follows **Clean Architecture** principles with three main layers:

```
lib/
├── core/                       # Core utilities and configurations
│   ├── config/                # App configuration
│   ├── constants/             # App constants
│   ├── di/                    # Dependency injection
│   ├── error/                 # Error handling
│   ├── network/               # Network utilities
│   ├── theme/                 # App theme and colors
│   └── utils/                 # Utility functions
├── data/                      # Data layer
│   ├── datasources/           
│   │   ├── local/            # Local data sources (Hive)
│   │   └── remote/           # Remote data sources (API)
│   ├── models/               # Data models
│   └── repositories/         # Repository implementations
├── domain/                    # Domain layer
│   ├── entities/             # Business entities
│   ├── repositories/         # Repository interfaces
│   └── usecases/             # Business logic
└── presentation/             # Presentation layer
    ├── bloc/                 # BLoC state management
    ├── pages/                # UI pages
    └── widgets/              # Reusable widgets
```

## State Management

This app uses **flutter_bloc** for state management following the BLoC pattern:
- Separation of business logic from UI
- Predictable state changes
- Easy testing
- Reactive programming

## Tech Stack

### Core
- **Flutter** - UI framework
- **Dart** - Programming language

### State Management
- **flutter_bloc** - BLoC state management
- **equatable** - Value equality

### Networking
- **dio** - HTTP client
- **retrofit** - Type-safe REST client
- **connectivity_plus** - Network connectivity

### Local Storage
- **hive** - Local database
- **shared_preferences** - Key-value storage

### Video Player
- **video_player** - Video playback
- **chewie** - Video player UI

### UI & Design
- **google_fonts** (Lato) - Typography
- **flutter_screenutil** - Responsive design
- **cached_network_image** - Image caching
- **shimmer** - Loading animations

### Dependency Injection
- **get_it** - Service locator
- **injectable** - Code generation for DI

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS development setup (for iOS)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/crunchyroll.git
cd crunchyroll
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
flutter run
```

## Configuration

### Environment Setup

The app supports three environments:
- **Development** - For local development
- **Staging** - For testing
- **Production** - For release

Configure in `lib/core/config/app_config.dart`

### API Configuration

Update the API base URL in `lib/core/config/app_config.dart`:
```dart
baseUrl: 'https://your-api-url.com'
```

## Project Structure Explained

### Core Layer
Contains app-wide utilities, configurations, and shared resources:
- **config**: Environment-specific configurations
- **constants**: App-wide constants (routes, endpoints, keys)
- **theme**: Theme data, colors, and text styles
- **error**: Error handling (failures & exceptions)
- **network**: Network connectivity checks
- **di**: Dependency injection setup

### Domain Layer
Contains business logic and entities:
- **entities**: Pure Dart classes representing business objects
- **repositories**: Abstract repository interfaces
- **usecases**: Single-responsibility business logic classes

### Data Layer
Handles data operations:
- **models**: JSON serializable data models
- **datasources**: API and local database implementations
- **repositories**: Concrete implementations of domain repositories

### Presentation Layer
UI and state management:
- **bloc**: BLoC classes (events, states, blocs)
- **pages**: Full-screen pages
- **widgets**: Reusable UI components

## BLoC Pattern

Example BLoC structure:
```dart
// Event
class LoadTrendingAnime extends HomeEvent {}

// State
class HomeState {
  final List<Anime> trendingAnime;
  final HomeStatus status;
}

// BLoC
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Future<void> _onLoadTrendingAnime(event, emit) async {
    // Business logic here
  }
}
```

## Responsive Design

Uses `flutter_screenutil` for responsive layouts:
```dart
width: 100.w,  // Responsive width
height: 50.h,  // Responsive height
fontSize: 16.sp, // Responsive font size
radius: 8.r,   // Responsive radius
```

## Theme & Design

- **Primary Color**: Crunchyroll Orange (#F47521)
- **Background**: Dark theme optimized for video content
- **Typography**: Google Fonts Lato
- **Design System**: Consistent spacing, colors, and components

## Testing

Run tests:
```bash
flutter test
```

Run code generation for tests:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Build & Release

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Code Generation

This project uses code generation for:
- JSON serialization
- Dependency injection
- Retrofit API clients

Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Watch for changes:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Troubleshooting

### Common Issues

1. **Build runner fails**: Delete generated files and run again
   ```bash
   flutter clean
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

2. **Hive errors**: Clear app data or reinstall the app

3. **Video player issues**: Check network permissions and video URL validity

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Crunchyroll for inspiration
- Flutter team for the amazing framework
- Open source community for the packages used

## Contact

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)

Project Link: [https://github.com/yourusername/crunchyroll](https://github.com/yourusername/crunchyroll)
# cruncyroll_clone
