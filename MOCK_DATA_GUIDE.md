# 🎬 Mock Data Guide - Video URLs & Images

## ✅ What's Included

Your app now uses **dummy JSON data** with:
- ✅ 15 anime titles with descriptions
- ✅ Random images from Picsum (placeholder service)
- ✅ 8-15 episodes per anime
- ✅ Placeholder video URL (Big Buck Bunny)

## 📸 Images

Currently using **Picsum Photos** for all images:
- Anime posters: `https://picsum.photos/seed/anime-name/400/600`
- Banners: `https://picsum.photos/seed/anime-name-banner/1200/400`
- Episode thumbnails: `https://picsum.photos/seed/anime-episode/400/225`

### To Replace Images:
1. Open `lib/data/datasources/remote/mock_anime_data.dart`
2. Replace `imageUrl` and `bannerUrl` with your own URLs
3. Or keep Picsum - images change each time for variety!

## 🎥 Video URLs

### Current Placeholder
All episodes use: `https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4`

This is a **free sample video** from Google for testing.

### To Replace Video URLs

**Option 1: Update Mock Data File**
```dart
// File: lib/data/datasources/remote/mock_anime_data.dart
// Line ~220 in _generateEpisodes method

'videoUrl': 'YOUR_VIDEO_URL_HERE',  // Replace this
```

**Option 2: Use Your Own Video URLs**
Update each anime's episodes with your video URLs:
```dart
{
  'id': '1-ep1',
  'animeId': '1',
  'episodeNumber': 1,
  'videoUrl': 'https://your-cdn.com/attack-on-titan/episode-1.mp4',
  // ... other fields
}
```

**Option 3: Use a Video Streaming API**
If you have a video streaming service:
1. Keep the current structure
2. Update the `videoUrl` field to point to your API
3. The video player will automatically use it

## 🎬 Sample Video URLs for Testing

Free sample videos you can use for testing:

```dart
// Google Sample Videos
'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'
'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'
'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'

// Or test with your own MP4 files
```

## 📝 How Mock Data Works

### File Location
```
lib/data/datasources/remote/mock_anime_data.dart
```

### Data Structure
```dart
class MockAnimeData {
  static const List<Map<String, dynamic>> trendingAnime = [
    {
      'id': '1',
      'title': 'Attack on Titan',
      'imageUrl': 'https://picsum.photos/seed/aot/400/600',
      'videoUrl': 'YOUR_VIDEO_URL',
      // ... more fields
    },
  ];
}
```

### Using Mock Data
The API service automatically uses this mock data:
```dart
// File: lib/data/datasources/remote/anime_api_service.dart

Future<List<AnimeModel>> getTrendingAnime() async {
  await Future.delayed(const Duration(milliseconds: 500)); // Simulate delay
  
  final List<dynamic> data = MockAnimeData.trendingAnime;
  return data.map((json) => AnimeModel.fromJson(json)).toList();
}
```

## 🔄 Switch to Real API

When you're ready to use a real API, update `anime_api_service.dart`:

```dart
// Uncomment the real API section at the bottom of the file:

Future<List<AnimeModel>> getTrendingAnime() async {
  try {
    final response = await _dio.get('/anime/trending');
    final List<dynamic> data = response.data;
    return data.map((json) => AnimeModel.fromJson(json)).toList();
  } catch (e) {
    rethrow;
  }
}
```

And update the base URL in `lib/core/config/app_config.dart`:
```dart
baseUrl: 'https://your-api-url.com',
```

## 🎯 Quick Customization

### Add More Anime
```dart
// In mock_anime_data.dart
static const List<Map<String, dynamic>> trendingAnime = [
  // ... existing anime
  {
    'id': '16',
    'title': 'Your Anime Title',
    'description': 'Your description',
    'imageUrl': 'https://your-image-url.com/image.jpg',
    'bannerUrl': 'https://your-image-url.com/banner.jpg',
    'rating': 8.5,
    'totalEpisodes': 12,
    'status': 'Ongoing',
    'genres': ['Action', 'Adventure'],
    'releaseYear': '2024',
  },
];
```

### Change Episode Count
```dart
// In mock_anime_data.dart, getEpisodes() method
'1': _generateEpisodes('1', 24, 'Attack on Titan'), // Change 24 to your count
```

### Use Your Own Images
Replace Picsum URLs with your own:
```dart
'imageUrl': 'https://your-cdn.com/anime/poster.jpg',
'bannerUrl': 'https://your-cdn.com/anime/banner.jpg',
```

## 🚀 Testing Your Videos

### Test Video Playback
1. Run the app: `flutter run`
2. Click on any anime
3. Click on any episode
4. Video should play automatically

### Add Your Video URL
1. Get your video URL (must be direct .mp4 link or HLS stream)
2. Update `videoUrl` in `mock_anime_data.dart`
3. Hot reload the app
4. Test the video player

## 📱 Video Formats Supported

The video player (chewie + video_player) supports:
- ✅ MP4
- ✅ HLS (.m3u8)
- ✅ DASH
- ✅ HTTP/HTTPS streaming

## ⚠️ Important Notes

1. **CORS Issues**: If testing on web, ensure your video URLs support CORS
2. **HTTPS Required**: Videos must be served over HTTPS (except localhost)
3. **Direct Links**: Video URLs should be direct links to video files
4. **Streaming**: For production, use a proper CDN (Cloudflare, AWS CloudFront, etc.)

## 💡 Production Recommendations

For a production anime app, consider:

1. **Video Hosting**:
   - AWS S3 + CloudFront
   - Cloudflare Stream
   - Bunny.net CDN
   - Vimeo API

2. **Image Hosting**:
   - Cloudinary
   - imgix
   - AWS S3
   - Your own CDN

3. **API Backend**:
   - Node.js/Express
   - Django/FastAPI
   - Firebase
   - Supabase

## 🎉 You're All Set!

Your app now has:
- ✅ 15 anime with images
- ✅ 120+ episodes with thumbnails
- ✅ Working video player
- ✅ Easy to customize

Just replace the `videoUrl` field when you have your own videos!

---

**Need Help?**
- Check the video player code: `lib/presentation/pages/video_player/video_player_page.dart`
- Check mock data: `lib/data/datasources/remote/mock_anime_data.dart`
- Check API service: `lib/data/datasources/remote/anime_api_service.dart`
