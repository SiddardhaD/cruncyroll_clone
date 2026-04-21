# 🚀 Quick Start Guide

## ✅ FIXED - Ready to Run!

The build runner issues have been resolved. The app now uses **Dio directly** instead of Retrofit, avoiding all code generation problems.

## 📝 Step-by-Step Setup

### Step 1: Generate Code Files (REQUIRED)

The code generation is already completed! But if you need to regenerate:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates:
- `lib/data/models/anime_model.g.dart` ✅
- `lib/data/models/episode_model.g.dart` ✅

**Note**: Retrofit is no longer used, so no retrofit generator errors!

### Step 2: Run the App

```bash
flutter run
```

### Step 3: Configure API (Optional)

If you have a real API:

1. Open `lib/core/config/app_config.dart`
2. Update the `baseUrl` for your environment:
   ```dart
   static const AppConfig _developmentConfig = AppConfig(
     baseUrl: 'https://your-api-url.com',  // Change this
     apiKey: 'your_api_key',                // Change this
   );
   ```

## 🛠️ Available Commands

### Run Code Generation (Required First Time)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Watch Mode (Auto-regenerate on file changes)
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Clean Generated Files
```bash
flutter pub run build_runner clean
```

### Run the App
```bash
# Development
flutter run

# Release mode
flutter run --release

# Specific device
flutter run -d <device_id>
```

### Build APK
```bash
flutter build apk --release
```

### Build App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

## 📱 Testing with Mock Data

Since this is a boilerplate, the app will fail to load data without a real API. To test:

1. **Option 1**: Set up a mock API server
2. **Option 2**: Modify the data sources to return mock data temporarily
3. **Option 3**: Use a public anime API like [Jikan](https://jikan.moe/)

### Quick Mock Data Setup

Create a file `lib/data/datasources/remote/mock_api_service.dart`:

```dart
class MockApiService {
  static List<Map<String, dynamic>> getMockAnime() {
    return [
      {
        'id': '1',
        'title': 'Attack on Titan',
        'description': 'Humanity fights against giants...',
        'imageUrl': 'https://example.com/image.jpg',
        'rating': 9.0,
        'totalEpisodes': 75,
        'status': 'Completed',
        'genres': ['Action', 'Drama'],
        'releaseYear': '2013',
      },
      // Add more mock data
    ];
  }
}
```

## 🎨 Customization Guide

### Change Colors
Edit `lib/core/theme/app_colors.dart`:
```dart
static const Color primaryOrange = Color(0xFFF47521);  // Change this
```

### Change Font
Edit `lib/core/theme/app_theme.dart` and replace `GoogleFonts.lato()` with your font.

### Add New Screens
1. Create page in `lib/presentation/pages/your_screen/`
2. Create BLoC in `lib/presentation/bloc/your_screen/`
3. Register BLoC in `lib/core/di/injection_container.dart`
4. Add route in navigation

## 🐛 Troubleshooting

### Error: "The getter '_$...' isn't defined"
**Solution**: Run `flutter pub run build_runner build --delete-conflicting-outputs`

### Error: "No implementation found for method..."
**Solution**: 
1. Run `flutter clean`
2. Run `flutter pub get`
3. Rebuild the app

### Error: "MissingPluginException"
**Solution**:
1. Stop the app
2. Run `flutter clean`
3. Run `flutter pub get`
4. Rebuild and run

### Hive Errors
**Solution**:
1. Uninstall the app from device
2. Reinstall

### Build Runner Conflicts
**Solution**:
```bash
flutter clean
rm -rf .dart_tool
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📦 Project Structure Quick Reference

```
lib/
├── core/          # Configs, theme, constants, DI, errors
├── data/          # Models, API service, repositories
├── domain/        # Entities, use cases, repository interfaces
├── presentation/  # BLoC, pages, widgets
└── main.dart      # App entry point
```

## ✅ Checklist Before First Run

- [ ] Run `flutter pub get`
- [ ] Run `flutter pub run build_runner build --delete-conflicting-outputs`
- [ ] Check that `.g.dart` files are generated
- [ ] Update API URL in `app_config.dart` (optional)
- [ ] Run `flutter run`

## 🎯 What's Working

✅ App structure with clean architecture
✅ BLoC state management setup
✅ Theme and styling
✅ Responsive design utilities
✅ Dependency injection
✅ UI components and widgets
✅ Navigation structure

## ⚠️ What Needs API Connection

These features need a real API to work:
- Loading anime data
- Searching anime
- Playing videos
- Favorites sync

## 📚 Next Steps

1. **Set up a real API** or mock server
2. **Implement navigation** with go_router
3. **Add search page**
4. **Add authentication**
5. **Add more screens** (profile, settings, etc.)
6. **Write tests**

## 💡 Pro Tips

1. **Use watch mode during development**:
   ```bash
   flutter pub run build_runner watch
   ```

2. **Keep generated files in .gitignore**:
   Add `*.g.dart` to `.gitignore` (optional, depends on team preference)

3. **Format code**:
   ```bash
   flutter format .
   ```

4. **Analyze code**:
   ```bash
   flutter analyze
   ```

## 🤝 Need Help?

- Check `README.md` for detailed documentation
- Check `PROJECT_SUMMARY.md` for architecture overview
- Review the code comments
- Check Flutter/BLoC documentation

---

**Happy Coding! 🎉**
