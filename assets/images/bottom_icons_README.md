# Bottom Navigation Icons

This folder should contain 5 SVG icons for the bottom navigation bar.

## Required Icons

Please add the following SVG files:

1. **`bottom1.svg`** - Home icon (house icon)
2. **`bottom2.svg`** - My Lists icon (bookmark icon)
3. **`bottom3.svg`** - Browse icon (grid/browse icon)
4. **`bottom4.svg`** - Search icon (magnifying glass/search icon)
5. **`bottom5.svg`** - Account icon (user/profile icon)

## Icon Specifications

- **Format**: SVG
- **Size**: 24x24px (will be scaled automatically)
- **Color**: Icons should be designed in a single color (preferably white or black)
  - The app will automatically apply color filters:
    - **Active state**: Orange (#F47521)
    - **Inactive state**: Gray (#8E8E8E)
- **Style**: Simple, clean icons matching Crunchyroll's design language

## Example Icon Sources

You can get similar icons from:
- [Material Icons](https://fonts.google.com/icons) - Export as SVG
- [Heroicons](https://heroicons.com/) - Free SVG icons
- [Feather Icons](https://feathericons.com/) - Clean SVG icons
- [Font Awesome](https://fontawesome.com/) - Wide variety of icons

## Icon Mappings

| File | Tab | Icon Type | Description |
|------|-----|-----------|-------------|
| bottom1.svg | Home | House/Home | Homepage with anime carousel |
| bottom2.svg | My Lists | Bookmark | User's watchlist and favorites |
| bottom3.svg | Browse | Grid | Browse categories |
| bottom4.svg | Search | Magnifying glass | Search anime |
| bottom5.svg | Account | User circle | Account settings |

## How Icons Are Used

The icons are loaded in `DashboardPage` using `SvgPicture.asset()`:

```dart
SvgPicture.asset(
  'assets/images/bottom1.svg',
  height: 24.h,
  width: 24.w,
  colorFilter: ColorFilter.mode(
    isActive ? AppColors.primaryOrange : AppColors.textSecondary,
    BlendMode.srcIn,
  ),
)
```

The color filter automatically changes the icon color based on whether the tab is active or not.

## Testing Without Icons

If you don't have SVG files yet, the app will show an error widget where the icons should be. You can:

1. Use Material Icons temporarily (requires code change)
2. Download free SVG icons from the sources above
3. Create simple SVG icons using online tools like [Figma](https://figma.com) or [Inkscape](https://inkscape.org)

## Quick Start

1. Download 5 SVG icons (home, bookmark, grid, search, profile)
2. Rename them to: `bottom1.svg`, `bottom2.svg`, `bottom3.svg`, `bottom4.svg`, `bottom5.svg`
3. Place them in `assets/images/` folder
4. Restart the app

The bottom navigation will now display with proper icons that change color when tapped!
