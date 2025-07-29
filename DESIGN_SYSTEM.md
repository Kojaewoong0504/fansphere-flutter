# Berry Music Hub Design System

A comprehensive Flutter design system optimized for dark themes with modern purple/cyan/electric color palette.

## 🎨 Color Palette

### Primary Colors
```dart
// Purple tones - Primary brand color
AppColors.primaryPurple        // #8B5CF6 - Main purple
AppColors.primaryPurpleLight   // #A78BFA - Light purple
AppColors.primaryPurpleDark    // #7C3AED - Dark purple

// Cyan tones - Secondary accent
AppColors.secondaryCyan        // #06B6D4 - Main cyan
AppColors.secondaryCyanLight   // #22D3EE - Light cyan
AppColors.secondaryCyanDark    // #0891B2 - Dark cyan

// Electric Green - Action color
AppColors.accentElectric       // #10B981 - Main electric
AppColors.accentElectricLight  // #34D399 - Light electric
AppColors.accentElectricDark   // #059669 - Dark electric

// Amber - Warning/Premium color
AppColors.accentAmber          // #F59E0B - Main amber
AppColors.accentAmberLight     // #FCD34D - Light amber
AppColors.accentAmberDark      // #D97706 - Dark amber
```

### Dark Theme Colors
```dart
// Text colors for dark theme
AppColors.darkTextPrimary      // #FFFFFF - Primary text
AppColors.darkTextSecondary    // #E0E0E0 - Secondary text
AppColors.darkTextTertiary     // #BDBDBD - Tertiary text

// Background colors
AppColors.darkBackground       // #121212 - Main background
AppColors.cardBackgroundDark   // #1E1E1E - Card background
AppColors.cardBorderDark       // #333333 - Card borders
```

### Gradients
```dart
// Predefined gradients
AppGradients.primaryToLight    // Purple gradient
AppGradients.electricTheme     // Electric green gradient
AppGradients.cyanTheme         // Cyan gradient
AppGradients.primaryRadial     // Radial purple gradient
```

## 📝 Typography

### Using Text Styles
```dart
// Basic usage
Text('Title', style: AppTextStyles.titleLarge)

// With dark theme extensions
Text('Title', style: AppTextStyles.titleLarge.darkPrimary)
Text('Subtitle', style: AppTextStyles.bodyMedium.darkSecondary)
Text('Caption', style: AppTextStyles.caption.darkTertiary)
```

### Available Text Styles
```dart
AppTextStyles.displayLarge      // 32px, Bold
AppTextStyles.headlineLarge     // 28px, Bold
AppTextStyles.headlineMedium    // 24px, SemiBold
AppTextStyles.headlineSmall     // 20px, SemiBold
AppTextStyles.titleLarge        // 18px, SemiBold
AppTextStyles.titleMedium       // 16px, Medium
AppTextStyles.titleSmall        // 14px, Medium
AppTextStyles.bodyLarge         // 16px, Regular
AppTextStyles.bodyMedium        // 14px, Regular
AppTextStyles.bodySmall         // 12px, Regular
AppTextStyles.labelLarge        // 14px, Medium
AppTextStyles.labelMedium       // 12px, Medium
AppTextStyles.labelSmall        // 11px, Medium
AppTextStyles.caption           // 10px, Regular

// Custom styles
AppTextStyles.modernTitle       // 24px, Bold - For section titles
AppTextStyles.modernSubtitle    // 16px, Medium - For section subtitles
```

### Color Extensions
```dart
// Dark theme colors
.darkPrimary    // White text for dark backgrounds
.darkSecondary  // Light gray text for dark backgrounds
.darkTertiary   // Medium gray text for dark backgrounds

// Brand colors
.primaryPurple  // Purple text
.secondaryCyan  // Cyan text
.accentElectric // Electric green text
.accentAmber    // Amber text

// Utility colors
.onPrimary      // White text on colored backgrounds
.secondary      // Secondary text color
.tertiary       // Tertiary text color
```

## 🎯 Buttons

### Basic Usage
```dart
// Primary button
BerryButton.primary(
  text: 'Play Music',
  onPressed: () => print('Pressed'),
  icon: Icon(Icons.play_arrow),
)

// Secondary button
BerryButton.secondary(
  text: 'Follow',
  onPressed: () => print('Pressed'),
)

// Cyan style button
BerryButton.cyan(
  text: 'Premium',
  onPressed: () => print('Pressed'),
  size: BerryButtonSize.small,
)

// Accent button
BerryButton.accent(
  text: 'Save',
  onPressed: () => print('Pressed'),
)

// Outline button
BerryButton.outline(
  text: 'Cancel',
  onPressed: () => print('Pressed'),
)
```

### Button Sizes
```dart
enum BerryButtonSize {
  small,    // 32px height
  medium,   // 40px height (default)
  large,    // 48px height
}
```

### Button Properties
```dart
BerryButton.primary(
  text: 'Button Text',
  onPressed: () {},
  icon: Icon(Icons.star),          // Optional icon
  size: BerryButtonSize.large,     // Button size
  isLoading: false,                // Loading state
  isFullWidth: false,              // Full width button
  isEnabled: true,                 // Enable/disable state
)
```

## 🃏 Cards

### Basic Cards
```dart
// Basic card
BerryCard(
  type: BerryCardType.basic,
  title: 'Card Title',
  subtitle: 'Card subtitle',
  leading: Icon(Icons.music_note),
  trailing: Icon(Icons.more_vert),
  onTap: () => print('Card tapped'),
)

// Elevated card with shadow
BerryCard(
  type: BerryCardType.elevated,
  title: 'Elevated Card',
  subtitle: 'With shadow effect',
)

// Outlined card
BerryCard(
  type: BerryCardType.outlined,
  title: 'Outlined Card',
  subtitle: 'With colored border',
)
```

### Music Cards
```dart
// Spotify-style music card
BerryCard.music(
  title: 'Song Title',
  artist: 'Artist Name',
  albumCover: Container(
    color: AppColors.primaryPurple,
    child: Icon(Icons.music_note, color: AppColors.textOnPrimary),
  ),
  trailing: IconButton(
    icon: Icon(Icons.play_circle_filled),
    onPressed: () => print('Play song'),
  ),
  onTap: () => print('Song tapped'),
)
```

### Gradient Cards
```dart
// Gradient card
BerryCard.gradient(
  title: 'Premium Features',
  subtitle: 'Unlock unlimited streaming',
  height: 120,
  gradientColors: AppColors.primaryGradient,
  onTap: () => print('Premium tapped'),
)

// Custom gradient
BerryCard.gradient(
  title: 'New Releases',
  subtitle: 'Fresh music every Friday',
  gradientColors: AppColors.cyanGradient,
  height: 100,
)
```

### Custom Cards
```dart
// Card with custom child
BerryCard(
  type: BerryCardType.elevated,
  child: Column(
    children: [
      Text('Custom Content'),
      ElevatedButton(
        onPressed: () {},
        child: Text('Action'),
      ),
    ],
  ),
)
```

### Berry Shape
```dart
// Decorative berry-shaped container
BerryShape(
  size: 80,
  color: AppColors.primaryPurple,
  onTap: () => print('Berry tapped'),
  child: Icon(
    Icons.music_note,
    color: AppColors.textOnPrimary,
    size: 32,
  ),
)
```

## 📝 Input Fields

### Basic Inputs
```dart
// Standard text input
BerryInput(
  label: 'Full Name',
  hint: 'Enter your full name',
  helperText: 'This will be displayed publicly',
  onChanged: (value) => print('Text: $value'),
)

// Email input
BerryInput.email(
  controller: emailController,
  onChanged: (value) => print('Email: $value'),
)

// Password input
BerryInput.password(
  controller: passwordController,
  onChanged: (value) => print('Password entered'),
)

// Search input
BerryInput.search(
  hint: 'Search music...',
  controller: searchController,
  onSubmitted: (query) => print('Searching: $query'),
)
```

### Multiline Input
```dart
BerryInput(
  type: BerryInputType.multiline,
  label: 'Description',
  hint: 'Enter description...',
  maxLines: 3,
  maxLength: 200,
)
```

### Input States
```dart
BerryInput(
  label: 'Username',
  hint: 'Enter username',
  enabled: false,              // Disabled state
  readOnly: true,              // Read-only state
  errorText: 'Username taken', // Error state
  helperText: 'Choose unique', // Helper text
)
```

### Search Bar
```dart
BerrySearchBar(
  hint: 'Search music, artists, albums...',
  controller: searchController,
  onChanged: (value) => print('Search: $value'),
  onSubmitted: (value) => print('Submitted: $value'),
  showFilter: true,
  onFilterTap: () => print('Filter tapped'),
)
```

## 🎠 Carousel

### Album Carousel
```dart
BerryCarousel.albums(
  sectionTitle: 'Recent Albums',
  onSeeAll: () => print('See all albums'),
  items: [
    BerryCarouselItem(
      title: 'Album Title',
      subtitle: 'Artist Name',
      image: Container(
        color: AppColors.primaryPurple,
        child: Icon(Icons.album, color: AppColors.textOnPrimary),
      ),
      onTap: () => print('Album tapped'),
    ),
    // More items...
  ],
)
```

### Playlist Carousel
```dart
BerryCarousel.playlists(
  sectionTitle: 'Your Playlists',
  onSeeAll: () => print('See all playlists'),
  items: [
    BerryCarouselItem(
      title: 'Morning Coffee',
      subtitle: '24 songs',
      image: Container(
        color: AppColors.accentAmber,
        child: Icon(Icons.coffee, color: AppColors.textOnPrimary),
      ),
      badge: CarouselBadge.new_(),
      onTap: () => print('Playlist tapped'),
    ),
  ],
)
```

### Artist Carousel
```dart
BerryCarousel.artists(
  sectionTitle: 'Popular Artists',
  items: [
    BerryCarouselItem(
      title: 'Artist Name',
      subtitle: '2.1M followers',
      image: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryPurpleLight,
        ),
        child: Icon(Icons.person, color: AppColors.textOnPrimary),
      ),
      badge: CarouselBadge.hot(),
    ),
  ],
)
```

### Featured Carousel
```dart
BerryCarousel.featured(
  sectionTitle: 'Featured Content',
  items: [
    BerryCarouselItem(
      title: 'Summer Vibes 2024',
      subtitle: 'The hottest tracks of summer',
      image: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.electricTheme,
        ),
        child: Icon(Icons.music_note, size: 48),
      ),
      badge: CarouselBadge.premium(),
    ),
  ],
)
```

### Carousel Badges
```dart
// Predefined badges
CarouselBadge.new_()      // Green "NEW" badge
CarouselBadge.hot()       // Amber "HOT" badge
CarouselBadge.premium()   // Purple "PREMIUM" badge

// Custom badge
CarouselBadge(
  text: 'EXCLUSIVE',
  backgroundColor: AppColors.accentElectric,
  textColor: AppColors.textOnPrimary,
)
```

## 🧭 Navigation

### Bottom Navigation
```dart
BerryBottomNavigation(
  currentIndex: currentIndex,
  onTap: (index) => setState(() => currentIndex = index),
  items: [
    BerryNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    BerryNavItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
      label: 'Search',
    ),
    // More items...
  ],
)
```

### Tab Bar
```dart
BerryTabBar(
  tabs: ['Music', 'Podcasts', 'Radio'],
  controller: tabController,
  onTap: (index) => print('Tab $index tapped'),
  isScrollable: true,
)
```

### App Bar
```dart
// Basic app bar
BerryAppBar(
  title: 'Berry Music',
  centerTitle: true,
  actions: [
    IconButton(
      icon: Icon(Icons.person_outline),
      onPressed: () => print('Profile tapped'),
    ),
  ],
)

// App bar with custom title widget
BerryAppBar(
  titleWidget: ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
      colors: [
        AppColors.primaryPurpleLight,
        AppColors.secondaryCyanLight,
        AppColors.accentElectricLight,
      ],
    ).createShader(bounds),
    child: Text(
      'Berry Music Hub',
      style: AppTextStyles.headlineSmall.copyWith(
        color: AppColors.pureWhite,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  bottom: BerryTabBar(
    tabs: ['Home', 'Search', 'Library'],
    controller: tabController,
  ),
)

// Search app bar
BerryAppBar.search(
  onSearchTap: () => print('Search tapped'),
  actions: [
    IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () => print('Filter tapped'),
    ),
  ],
)
```

### Drawer
```dart
BerryDrawer(
  userName: 'Music Lover',
  userEmail: 'user@berriz.in',
  userAvatar: Container(
    color: AppColors.accentElectric,
    child: Icon(Icons.person, color: AppColors.textOnPrimary),
  ),
  items: [
    BerryDrawerItem(
      icon: Icons.home_outlined,
      title: 'Home',
      subtitle: 'Discover new music',
    ),
    BerryDrawerItem(
      icon: Icons.library_music_outlined,
      title: 'My Library',
      subtitle: 'Your playlists & favorites',
    ),
    BerryDrawerItem(
      icon: Icons.settings_outlined,
      title: 'Settings',
    ),
  ],
  onItemTap: (index) => print('Drawer item $index tapped'),
)
```

## 🎨 Theme Integration

### Using the Theme
```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berry Music Hub',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Force dark theme
      home: DemoScreen(),
    );
  }
}
```

### Accessing Theme Colors
```dart
// Get theme brightness
final isDark = Theme.of(context).brightness == Brightness.dark;

// Use theme-aware colors
Container(
  color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
  child: Text(
    'Theme-aware text',
    style: isDark 
      ? AppTextStyles.bodyLarge.darkPrimary 
      : AppTextStyles.bodyLarge,
  ),
)
```

## 📋 Best Practices

### 1. Text Styling
```dart
// ✅ Good - Use text style extensions
Text('Title', style: AppTextStyles.titleLarge.darkPrimary)

// ❌ Avoid - Manual color assignment
Text('Title', style: TextStyle(color: Colors.white))
```

### 2. Color Usage
```dart
// ✅ Good - Use predefined colors
Container(color: AppColors.primaryPurple)

// ❌ Avoid - Hard-coded colors
Container(color: Color(0xFF8B5CF6))
```

### 3. Responsive Design
```dart
// ✅ Good - Use relative sizing
BerryButton.primary(
  text: 'Button',
  isFullWidth: MediaQuery.of(context).size.width < 600,
)
```

### 4. Gradient Usage
```dart
// ✅ Good - Use predefined gradients
Container(
  decoration: BoxDecoration(
    gradient: AppGradients.primaryToLight,
  ),
)
```

### 5. Accessibility
```dart
// ✅ Good - Provide semantic labels
BerryButton.primary(
  text: 'Play',
  onPressed: playMusic,
  icon: Icon(Icons.play_arrow),
  // Automatically handles accessibility
)
```

## 🔧 Customization

### Extending Colors
```dart
// Add to AppColors class
class AppColors {
  // Existing colors...
  
  // Custom colors
  static const Color customBlue = Color(0xFF1E40AF);
  static const Color customGreen = Color(0xFF16A34A);
}
```

### Creating Custom Buttons
```dart
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  
  const CustomButton({
    required this.text,
    this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return BerryButton.primary(
      text: text,
      onPressed: onPressed,
      // Add custom styling here
    );
  }
}
```

### Custom Text Styles
```dart
// Extend AppTextStyles
extension CustomTextStyles on TextStyle {
  TextStyle get customBold => copyWith(
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );
}

// Usage
Text('Custom Text', style: AppTextStyles.bodyLarge.customBold)
```

## 📱 Example Implementation

```dart
class MusicPlayerScreen extends StatefulWidget {
  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BerryAppBar(
        title: 'Now Playing',
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Album Art
          BerryCard.gradient(
            height: 300,
            gradientColors: AppGradients.primaryRadial,
            child: Icon(
              Icons.music_note,
              size: 120,
              color: AppColors.textOnPrimary,
            ),
          ),
          
          SizedBox(height: 24),
          
          // Song Info
          Text(
            'Song Title',
            style: AppTextStyles.headlineMedium.darkPrimary,
          ),
          Text(
            'Artist Name',
            style: AppTextStyles.titleMedium.darkSecondary,
          ),
          
          SizedBox(height: 32),
          
          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BerryButton.outline(
                text: 'Previous',
                onPressed: () {},
                icon: Icon(Icons.skip_previous),
              ),
              BerryButton.primary(
                text: 'Play',
                onPressed: () {},
                icon: Icon(Icons.play_arrow),
                size: BerryButtonSize.large,
              ),
              BerryButton.outline(
                text: 'Next',
                onPressed: () {},
                icon: Icon(Icons.skip_next),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

---

## 🎯 Quick Reference

### Import Statements
```dart
// Core theme
import '../core/theme/colors.dart';
import '../core/theme/text_styles.dart';
import '../core/theme/app_theme.dart';

// Widgets
import '../widgets/berry_button.dart';
import '../widgets/berry_card.dart';
import '../widgets/berry_input.dart';
import '../widgets/berry_navigation.dart';
import '../widgets/berry_carousel.dart';
```

### Essential Components
- **BerryButton**: 5 variants (primary, secondary, cyan, accent, outline)
- **BerryCard**: 5 types (basic, elevated, outlined, gradient, music)
- **BerryInput**: 5 types (text, email, password, search, multiline)
- **BerryCarousel**: 4 types (albums, playlists, artists, featured)
- **BerryNavigation**: Bottom nav, tab bar, app bar, drawer

### Color Palette Summary
- **Primary**: Purple (#8B5CF6)
- **Secondary**: Cyan (#06B6D4)  
- **Accent**: Electric Green (#10B981)
- **Warning**: Amber (#F59E0B)
- **Background**: Dark (#121212)
- **Cards**: Dark Gray (#1E1E1E)

This design system provides a complete foundation for building consistent, accessible, and visually appealing Flutter applications with a modern dark theme aesthetic.