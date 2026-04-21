# Video Player Troubleshooting Guide

## Current Status

✅ **Video URL is accessible**: The server returns HTTP 200
✅ **Network permissions configured**: Both Android and iOS have internet permissions
✅ **Enhanced error logging**: Added detailed console logs and error messages

## Testing Steps

### 1. Run the App and Check Logs

Run your app and navigate to a video. Watch the **console/logcat** for these messages:

```
🎬 Initializing video player...
📹 Video URL: https://avtshare01.rz.tu-ilmenau.de/...
⏳ Waiting for video to initialize...
```

**If successful**, you'll see:
```
✅ Video initialized successfully!
📊 Video info: 1920x1080
⏱️ Duration: 0:00:XX
```

**If failed**, you'll see:
```
❌ ERROR initializing video player: <error details>
```

### 2. Common Issues & Solutions

#### Issue: Video stuck on loading spinner
**Possible causes:**
- Slow network connection (18MB video file)
- Android emulator network issues
- Video codec not supported

**Solutions:**
1. Wait longer (large video takes time)
2. Test on physical device instead of emulator
3. Try smaller video (see below)

#### Issue: Error "Source not supported" or codec error
**Possible causes:**
- H.264 codec might not be available on emulator
- Video resolution too high (1080p)

**Solutions:**
1. Test on physical device
2. Try lower resolution video
3. Update video_player plugin

#### Issue: Black screen with controls
**Possible causes:**
- Video playing but not rendering
- Hardware acceleration issue

**Solutions:**
1. Enable hardware acceleration in AndroidManifest.xml (already done)
2. Try software decoding mode

#### Issue: "Response code: 403" or "Response code: 404"
**Possible causes:**
- Server blocking requests
- URL changed or expired

**Solutions:**
1. Test URL in browser first
2. Check server accepts mobile user agents
3. Try alternative video URLs

### 3. Test with Smaller Video

The current video is 18MB and 1080p. For testing, try a smaller video first:

**Option 1: Change to smaller Big Buck Bunny** (in mock_anime_data.dart):
```dart
'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
```

**Option 2: Tiny test video** (for quick testing):
```dart
'https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_1MB.mp4'
```

### 4. Platform-Specific Debugging

#### Android
1. Open **Android Studio > Logcat**
2. Filter by: `flutter` or `ExoPlayer`
3. Look for video-related errors

#### iOS
1. Open **Xcode > Window > Devices and Simulators**
2. Select your device/simulator
3. Click "Open Console" to see logs

### 5. Emulator vs Physical Device

**Emulator issues:**
- Limited codec support
- Slower network
- Less hardware acceleration

**Recommendation:** Test on physical device for accurate video playback testing.

## Video URL Information

**Current URL:** 
`https://avtshare01.rz.tu-ilmenau.de/avt-vqdb-uhd-1/test_1/segments/bigbuck_bunny_8bit_15000kbps_1080p_60.0fps_h264.mp4`

**Details:**
- Size: ~18MB
- Resolution: 1080p (1920x1080)
- FPS: 60fps
- Codec: H.264
- Bitrate: 15000kbps (high quality)

This is a **high-quality video** which may be too heavy for testing. Consider using a smaller test video first.

## Next Steps

1. **Run the app** and navigate to any episode
2. **Check console logs** for the emoji-marked debug messages
3. **Share the error message** if it fails (look for ❌ messages)
4. **Try on physical device** if emulator has issues
5. **Test with smaller video** if loading takes too long

## Alternative Video URLs (For Testing)

Add these to `mock_anime_data.dart` for testing:

```dart
// Small and fast (recommended for initial testing)
'https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_1MB.mp4',

// Google's test videos (reliable)
'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',

// Medium quality
'https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_5MB.mp4',
```

---

**After testing, please share:**
1. The console log output (especially lines with 🎬 📹 ✅ ❌ emojis)
2. Whether you're testing on emulator or physical device
3. Any error messages shown in the UI
