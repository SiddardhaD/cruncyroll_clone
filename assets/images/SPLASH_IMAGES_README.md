# Splash Images for Login Page

This folder should contain **20 anime poster/banner images** for the animated login background.

## Required Images

Please add 20 PNG/JPG images named:

- `splash1.png`
- `splash2.png`
- `splash3.png`
- ...
- `splash20.png`

## Image Specifications

### Dimensions
- **Recommended**: 400px width x 600px height (portrait)
- **Aspect Ratio**: 2:3 (poster style)
- **Format**: PNG or JPG
- **Size**: < 500KB each for better performance

### Style
- Anime posters/banners
- High quality, vibrant colors
- Recognizable anime shows (Naruto, One Piece, Demon Slayer, etc.)
- Mix of popular and diverse anime

## How They're Used

The login page displays these images in **4 horizontal rows**:

- **Row 1**: 5 images, scrolling RIGHT →
- **Row 2**: 6 images, scrolling LEFT ←
- **Row 3**: 5 images, scrolling RIGHT →
- **Row 4**: 6 images, scrolling LEFT ←

### Animation Effect
```
Row 1: [splash1] [splash2] [splash3] [splash4] [splash5] → → →
Row 2: ← ← ← [splash6] [splash7] [splash8] [splash9] [splash10] [splash11]
Row 3: [splash12] [splash13] [splash14] [splash15] [splash16] → → →
Row 4: ← ← ← [splash17] [splash18] [splash19] [splash20]
```

Each row scrolls infinitely in opposite directions creating a dynamic parallax effect!

## Image Distribution

| Row | Direction | Images Used | Count |
|-----|-----------|-------------|-------|
| 1   | Right →   | splash1-5   | 5     |
| 2   | Left ←    | splash6-11  | 6     |
| 3   | Right →   | splash12-16 | 5     |
| 4   | Left ←    | splash17-20 | 4     |

## Where to Get Images

### Option 1: Download Anime Posters
- [MyAnimeList](https://myanimelist.net/) - Download poster images
- [AniList](https://anilist.co/) - High-quality anime art
- [Google Images](https://images.google.com/) - Search "anime poster"

### Option 2: Use Popular Anime
- Naruto
- One Piece
- Demon Slayer
- Attack on Titan
- My Hero Academia
- Jujutsu Kaisen
- Dragon Ball
- Hunter x Hunter
- Death Note
- Fullmetal Alchemist
- Bleach
- Sword Art Online
- Tokyo Ghoul
- Steins;Gate
- Code Geass
- Cowboy Bebop
- One Punch Man
- Mob Psycho 100
- Chainsaw Man
- Spy x Family

### Option 3: Use Placeholder Images
For testing, you can temporarily use:
- Placeholder images from [Unsplash](https://unsplash.com/)
- Colored rectangles with numbers
- Screenshots from anime

## Image Naming

Make sure to name exactly as:
```
splash1.png   ✅ Correct
splash01.png  ❌ Wrong
Splash1.png   ❌ Wrong (capital S)
splash_1.png  ❌ Wrong (underscore)
```

## Example Image Structure

```
assets/
  images/
    splash1.png   ← Naruto poster
    splash2.png   ← One Piece poster
    splash3.png   ← Demon Slayer poster
    splash4.png   ← Attack on Titan poster
    splash5.png   ← My Hero Academia poster
    splash6.png   ← Jujutsu Kaisen poster
    ...
    splash20.png  ← Spy x Family poster
```

## Tips for Best Results

1. **Consistent Style**: Use similar style posters (all official posters or all fan art)
2. **Color Variety**: Mix different color palettes for visual interest
3. **Popular Shows**: Use recognizable anime for brand association
4. **High Quality**: Clear, sharp images look more professional
5. **Proper Sizing**: Resize to ~400x600px before adding to reduce app size

## Testing Without Images

If you haven't added images yet, the app will show:
- Gray placeholder boxes with image icons
- The login functionality still works
- Once you add images, just hot reload and they'll appear!

## Performance Note

- 20 images × ~500KB = ~10MB total
- Consider compressing images if app size becomes an issue
- The animation is optimized for smooth 60fps scrolling

## pubspec.yaml

The images are already configured in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

This includes all images in the folder, so just drop your images in and reload!

---

## Quick Start

1. Download/create 20 anime poster images
2. Resize to ~400x600px (optional but recommended)
3. Rename to `splash1.png` through `splash20.png`
4. Place in `assets/images/` folder
5. Restart the app
6. Enjoy the beautiful animated login screen! 🎬✨
