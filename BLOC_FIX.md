# BLoC Navigation Fix - "Cannot add new events after calling close"

## Problem

The error "Bad state: Cannot add new events after calling close" occurred when tapping on anime cards to navigate to the details page. This happened because the code was trying to reuse an existing BLoC instance instead of creating a new one for each navigation.

## Root Cause

The navigation code was using:
```dart
BlocProvider(
  create: (context) => context.read<AnimeDetailsBloc>(), // Wrong!
  child: AnimeDetailsPage(animeId: anime.id),
)
```

This approach tries to reuse the same BLoC instance from the parent context. When you navigate away and back, the BLoC might already be closed, causing the error.

## Solution

Changed to create fresh BLoC instances using GetIt dependency injection:
```dart
BlocProvider(
  create: (context) => getIt<AnimeDetailsBloc>(), // Correct!
  child: AnimeDetailsPage(animeId: anime.id),
)
```

This ensures each navigation gets a brand new BLoC instance with a fresh lifecycle.

## Files Fixed

1. **lib/presentation/widgets/anime_list_section.dart**
   - Added `import '../../../core/di/injection_container.dart'`
   - Changed BLoC creation to use `getIt<AnimeDetailsBloc>()`

2. **lib/presentation/widgets/featured_banner.dart**
   - Added `import '../../core/di/injection_container.dart'`
   - Fixed both navigation points (Start Watching and Continue Watching buttons)

3. **lib/presentation/pages/home/home_page.dart**
   - Added `import '../../../core/di/injection_container.dart'`
   - Fixed banner tap navigation

4. **lib/presentation/widgets/anime_banner_carousel.dart**
   - Fixed SVG rendering to use `SvgPicture.asset` instead of `Image.asset`

## Testing

After the fix:
1. Tap any anime card from the trending/popular/recent sections
2. Navigate to the details page
3. Go back
4. Tap the same or different anime card again
5. No errors should occur!

## Key Takeaway

When navigating to a new page that needs a BLoC:
- ✅ **DO**: Create a new instance using GetIt: `getIt<YourBloc>()`
- ❌ **DON'T**: Reuse existing instance: `context.read<YourBloc>()`

Each navigation should have its own independent BLoC lifecycle.
