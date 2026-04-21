class AppConstants {
  AppConstants._();

  static const String appName = 'Crunchyroll';
  static const String appVersion = '1.0.0';
  
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration shortDuration = Duration(milliseconds: 300);
  static const Duration mediumDuration = Duration(milliseconds: 500);
  static const Duration longDuration = Duration(milliseconds: 800);
  
  static const int maxRetries = 3;
  static const int cacheSize = 100;
  static const int videoBufferSize = 50 * 1024 * 1024;
  
  static const double horizontalPadding = 16.0;
  static const double verticalPadding = 16.0;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 8.0;
  
  static const int gridCrossAxisCount = 2;
  static const double gridAspectRatio = 0.7;
  static const double gridSpacing = 12.0;
  
  static const String baseUrl = 'https://api.example.com';
  static const String imageBaseUrl = 'https://images.example.com';
  
  static const String placeholderImageUrl = 'https://via.placeholder.com/300x400';
}

class ApiEndpoints {
  ApiEndpoints._();

  static const String anime = '/anime';
  static const String trending = '/trending';
  static const String popular = '/popular';
  static const String recent = '/recent';
  static const String search = '/search';
  static const String details = '/anime/details';
  static const String episodes = '/anime/episodes';
  static const String watchlist = '/user/watchlist';
  static const String profile = '/user/profile';
}

class StorageKeys {
  StorageKeys._();

  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String theme = 'theme';
  static const String language = 'language';
  static const String isFirstTime = 'is_first_time';
  static const String watchHistory = 'watch_history';
  static const String downloadQuality = 'download_quality';
  static const String autoPlay = 'auto_play';
  static const String skipIntro = 'skip_intro';
}

class AssetPaths {
  AssetPaths._();

  static const String images = 'assets/images/';
  static const String icons = 'assets/icons/';
  static const String animations = 'assets/animations/';
  
  static const String logo = '${images}logo.png';
  static const String placeholder = '${images}placeholder.png';
  static const String noInternet = '${images}no_internet.png';
  static const String emptyState = '${images}empty_state.png';
}

class RouteNames {
  RouteNames._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String animeDetails = '/anime-details';
  static const String videoPlayer = '/video-player';
  static const String search = '/search';
  static const String watchlist = '/watchlist';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String genres = '/genres';
}
