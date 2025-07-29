import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import '../core/theme/text_styles.dart';
import '../widgets/berry_button.dart';
import '../widgets/berry_card.dart';
import '../widgets/berry_input.dart';
import '../widgets/berry_navigation.dart';
import '../widgets/berry_carousel.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> with TickerProviderStateMixin {
  int _currentNavIndex = 0;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BerryAppBar(
        titleWidget: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.primaryPurpleLight,
              AppColors.secondaryCyanLight,
              AppColors.accentElectricLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Berry Music Hub',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.pureWhite,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 1.0,
              shadows: [
                Shadow(
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  color: AppColors.darkBackground.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline),
          ),
        ],
        bottom: BerryTabBar(
          tabs: const ['Buttons', 'Cards', 'Inputs', 'Carousel', 'More'],
          controller: _tabController,
        ),
      ),
      drawer: BerryDrawer(
        userName: 'Music Lover',
        userEmail: 'user@berriz.in',
        userAvatar: Container(
          color: AppColors.accentElectric,
          child: const Icon(
            Icons.person,
            color: AppColors.textOnPrimary,
            size: 32,
          ),
        ),
        items: const [
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
            icon: Icons.trending_up_outlined,
            title: 'Trending',
            subtitle: 'What\'s hot right now',
          ),
          BerryDrawerItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildButtonsDemo(),
          _buildCardsDemo(),
          _buildInputsDemo(),
          _buildCarouselDemo(),
          _buildMoreDemo(),
        ],
      ),
      bottomNavigationBar: BerryBottomNavigation(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
        items: const [
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
          BerryNavItem(
            icon: Icons.library_music_outlined,
            activeIcon: Icons.library_music,
            label: 'Library',
          ),
          BerryNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Button Styles',
            style: AppTextStyles.modernTitle.darkPrimary,
          ),
          const SizedBox(height: 16),
          
          // Primary Buttons
          Text('Primary Buttons', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              BerryButton.primary(
                text: 'Play Music',
                onPressed: () => _showSnackBar('Play Music tapped'),
                icon: const Icon(Icons.play_arrow, size: 20),
              ),
              BerryButton.primary(
                text: 'Loading...',
                isLoading: true,
                onPressed: () {},
              ),
              BerryButton.primary(
                text: 'Large Button',
                size: BerryButtonSize.large,
                onPressed: () => _showSnackBar('Large button tapped'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Cyan Style Buttons
          Text('Cyan Style', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              BerryButton.cyan(
                text: 'Follow Artist',
                onPressed: () => _showSnackBar('Following artist'),
                icon: const Icon(Icons.add, size: 18),
              ),
              BerryButton.cyan(
                text: 'Premium',
                size: BerryButtonSize.small,
                onPressed: () => _showSnackBar('Upgrade to Premium'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Outline Buttons
          Text('Outline Buttons', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              BerryButton.outline(
                text: 'Add to Playlist',
                onPressed: () => _showSnackBar('Added to playlist'),
                icon: const Icon(Icons.playlist_add, size: 20),
              ),
              BerryButton.outline(
                text: 'Share',
                size: BerryButtonSize.small,
                onPressed: () => _showSnackBar('Sharing...'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Full Width Button
          Text('Full Width', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          BerryButton.primary(
            text: 'Start Free Trial',
            onPressed: () => _showSnackBar('Starting free trial'),
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCardsDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Card Variations',
            style: AppTextStyles.modernTitle.darkPrimary,
          ),
          const SizedBox(height: 16),
          
          // Music Cards
          Text('Music Cards', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          BerryCard.music(
            title: 'Like Berries',
            artist: 'Berry Artists',
            albumCover: Container(
              color: AppColors.accentElectric,
              child: const Icon(
                Icons.music_note,
                color: AppColors.textOnPrimary,
                size: 24,
              ),
            ),
            trailing: IconButton(
              onPressed: () => _showSnackBar('Playing song'),
              icon: const Icon(Icons.play_circle_filled),
              color: AppColors.secondaryCyan,
            ),
            onTap: () => _showSnackBar('Song tapped'),
          ),
          
          BerryCard.music(
            title: 'Sweet Dreams',
            artist: 'Dream Team',
            albumCover: Container(
              color: AppColors.primaryPurple,
              child: const Icon(
                Icons.album,
                color: AppColors.textOnPrimary,
                size: 24,
              ),
            ),
            trailing: IconButton(
              onPressed: () => _showSnackBar('Adding to favorites'),
              icon: const Icon(Icons.favorite_border),
              color: AppColors.accentAmber,
            ),
          ),
          const SizedBox(height: 24),
          
          // Gradient Cards
          Text('Gradient Cards', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          BerryCard.gradient(
            title: 'Premium Features',
            subtitle: 'Unlock unlimited music streaming and exclusive content',
            height: 120,
            onTap: () => _showSnackBar('Premium card tapped'),
          ),
          const SizedBox(height: 12),
          BerryCard.gradient(
            title: 'New Releases',
            subtitle: 'Fresh music every Friday',
            gradientColors: AppColors.cyanGradient,
            height: 100,
            onTap: () => _showSnackBar('New releases tapped'),
          ),
          const SizedBox(height: 24),
          
          // Standard Cards
          Text('Standard Cards', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: BerryCard(
                  type: BerryCardType.elevated,
                  title: 'Playlists',
                  subtitle: '24 playlists',
                  leading: const Icon(
                    Icons.queue_music,
                    color: AppColors.primaryPurple,
                    size: 32,
                  ),
                  onTap: () => _showSnackBar('Playlists tapped'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: BerryCard(
                  type: BerryCardType.outlined,
                  title: 'Artists',
                  subtitle: '152 following',
                  leading: const Icon(
                    Icons.person,
                    color: AppColors.accentElectric,
                    size: 32,
                  ),
                  onTap: () => _showSnackBar('Artists tapped'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Berry Shape Demo
          Text('Berry Shape', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BerryShape(
                size: 80,
                color: AppColors.primaryPurple,
                onTap: () => _showSnackBar('Shape 1 tapped'),
                child: const Icon(
                  Icons.music_note,
                  color: AppColors.textOnPrimary,
                  size: 32,
                ),
              ),
              BerryShape(
                size: 80,
                color: AppColors.accentElectric,
                onTap: () => _showSnackBar('Shape 2 tapped'),
                child: const Icon(
                  Icons.favorite,
                  color: AppColors.textOnPrimary,
                  size: 32,
                ),
              ),
              BerryShape(
                size: 80,
                color: AppColors.secondaryCyan,
                onTap: () => _showSnackBar('Shape 3 tapped'),
                child: const Icon(
                  Icons.play_arrow,
                  color: AppColors.textOnPrimary,
                  size: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputsDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Input Components',
            style: AppTextStyles.modernTitle.darkPrimary,
          ),
          const SizedBox(height: 16),
          
          // Search Bar
          Text('Search Bar', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          BerrySearchBar(
            controller: _searchController,
            onChanged: (value) => debugPrint('Search: $value'),
            onSubmitted: (value) => _showSnackBar('Searching for: $value'),
            showFilter: true,
            onFilterTap: () => _showSnackBar('Filter tapped'),
          ),
          const SizedBox(height: 24),
          
          // Login Form
          Text('Login Form', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          BerryInput.email(
            controller: _emailController,
            onChanged: (value) => debugPrint('Email: $value'),
          ),
          const SizedBox(height: 16),
          BerryInput.password(
            controller: _passwordController,
            onChanged: (value) => debugPrint('Password length: ${value.length}'),
          ),
          const SizedBox(height: 16),
          BerryButton.primary(
            text: 'Sign In',
            isFullWidth: true,
            onPressed: () => _showSnackBar('Signing in...'),
          ),
          const SizedBox(height: 24),
          
          // Other Input Types
          Text('Other Input Types', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          const BerryInput(
            label: 'Playlist Name',
            hint: 'Enter playlist name',
            helperText: 'Choose a unique name for your playlist',
          ),
          const SizedBox(height: 16),
          const BerryInput(
            type: BerryInputType.multiline,
            label: 'Description',
            hint: 'Tell us about your playlist...',
            maxLines: 3,
            maxLength: 200,
          ),
          const SizedBox(height: 16),
          const BerryInput(
            label: 'Genre',
            hint: 'Select genre',
            enabled: false,
            helperText: 'Feature coming soon',
          ),
        ],
      ),
    );
  }

  Widget _buildMoreDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Features',
            style: AppTextStyles.modernTitle.darkPrimary,
          ),
          const SizedBox(height: 16),
          
          // Typography Showcase
          Text('Typography', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          BerryCard(
            type: BerryCardType.elevated,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display Large', style: AppTextStyles.displayLarge.darkPrimary),
                const SizedBox(height: 8),
                Text('Headline Medium', style: AppTextStyles.headlineMedium.darkPrimary),
                const SizedBox(height: 8),
                Text('Title Large', style: AppTextStyles.titleLarge.darkPrimary),
                const SizedBox(height: 8),
                Text('Body Large - This is the main body text style used throughout the app for regular content.', 
                     style: AppTextStyles.bodyLarge.darkPrimary),
                const SizedBox(height: 8),
                Text('Label Medium', style: AppTextStyles.labelMedium.primaryPurple),
                const SizedBox(height: 8),
                Text('Modern Subtitle', style: AppTextStyles.modernSubtitle.darkSecondary),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Color Palette
          Text('Color Palette', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          BerryCard(
            type: BerryCardType.basic,
            child: Column(
              children: [
                _buildColorRow('Primary Purple', AppColors.primaryPurple),
                _buildColorRow('Secondary Cyan', AppColors.secondaryCyan),
                _buildColorRow('Accent Electric', AppColors.accentElectric),
                _buildColorRow('Accent Amber', AppColors.accentAmber),
                _buildColorRow('Dark Background', AppColors.darkBackground),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Interactive Elements
          Text('Interactive Elements', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          BerryCard(
            type: BerryCardType.basic,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.volume_up, color: AppColors.primaryPurple),
                  title: const Text('Volume'),
                  subtitle: const Text('Adjust playback volume'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) => _showSnackBar('Volume ${value ? 'on' : 'off'}'),
                    activeColor: AppColors.accentElectric,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.high_quality, color: AppColors.accentAmber),
                  title: const Text('High Quality'),
                  subtitle: const Text('Stream in high quality'),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) => _showSnackBar('Quality ${value ? 'high' : 'normal'}'),
                    activeColor: AppColors.accentElectric,
                  ),
                ),
                const Divider(),
                Slider(
                  value: 0.7,
                  onChanged: (value) {},
                  activeColor: AppColors.primaryPurple,
                  inactiveColor: AppColors.neutralLight,
                ),
                Text('Song Progress', style: AppTextStyles.bodySmall.darkSecondary),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Action Buttons
          Text('Actions', style: AppTextStyles.titleMedium.darkPrimary),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'shuffle',
                onPressed: () => _showSnackBar('Shuffle mode'),
                backgroundColor: AppColors.accentAmber,
                child: const Icon(Icons.shuffle),
              ),
              FloatingActionButton(
                heroTag: 'play',
                onPressed: () => _showSnackBar('Play/Pause'),
                backgroundColor: AppColors.accentElectric,
                child: const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                heroTag: 'repeat',
                onPressed: () => _showSnackBar('Repeat mode'),
                backgroundColor: AppColors.primaryPurple,
                child: const Icon(Icons.repeat),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorRow(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.cardBorder,
                width: 1,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: AppTextStyles.bodyMedium.darkPrimary,
            ),
          ),
          Text(
            '#${((color.r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0').toUpperCase()}'
            '${((color.g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0').toUpperCase()}'
            '${((color.b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0').toUpperCase()}',
            style: AppTextStyles.labelSmall.darkSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselDemo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          
          // Featured Carousel
          BerryCarousel.featured(
            sectionTitle: 'Featured Albums',
            onSeeAll: () => _showSnackBar('See all featured'),
            items: [
              BerryCarouselItem(
                title: 'Summer Vibes 2024',
                subtitle: 'The hottest tracks of summer',
                image: Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.electricTheme,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.music_note,
                      size: 48,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                badge: CarouselBadge.new_(),
                onTap: () => _showSnackBar('Featured: Summer Vibes'),
              ),
              BerryCarouselItem(
                title: 'Electronic Dreams',
                subtitle: 'Synthwave and electronic beats',
                image: Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.primaryRadial,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.queue_music,
                      size: 48,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                badge: CarouselBadge.hot(),
                onTap: () => _showSnackBar('Featured: Electronic Dreams'),
              ),
              BerryCarouselItem(
                title: 'Chill Lounge',
                subtitle: 'Relaxing music for work and study',
                image: Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.cyanTheme,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.headphones,
                      size: 48,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                onTap: () => _showSnackBar('Featured: Chill Lounge'),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Albums Carousel
          BerryCarousel.albums(
            sectionTitle: 'Recent Albums',
            onSeeAll: () => _showSnackBar('See all albums'),
            items: [
              BerryCarouselItem(
                title: 'Midnight Jazz',
                subtitle: 'Smooth Jazz Collective',
                image: Container(
                  color: AppColors.primaryPurple,
                  child: const Center(
                    child: Icon(
                      Icons.album,
                      size: 32,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                onTap: () => _showSnackBar('Album: Midnight Jazz'),
              ),
              BerryCarouselItem(
                title: 'Rock Anthems',
                subtitle: 'Thunder Band',
                image: Container(
                  color: AppColors.accentAmber,
                  child: const Center(
                    child: Icon(
                      Icons.music_note,
                      size: 32,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                onTap: () => _showSnackBar('Album: Rock Anthems'),
              ),
              BerryCarouselItem(
                title: 'Ocean Waves',
                subtitle: 'Nature Sounds',
                image: Container(
                  color: AppColors.secondaryCyan,
                  child: const Center(
                    child: Icon(
                      Icons.waves,
                      size: 32,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                badge: CarouselBadge.new_(),
                onTap: () => _showSnackBar('Album: Ocean Waves'),
              ),
              BerryCarouselItem(
                title: 'Electronic Pulse',
                subtitle: 'DJ Synthwave',
                image: Container(
                  color: AppColors.accentElectric,
                  child: const Center(
                    child: Icon(
                      Icons.graphic_eq,
                      size: 32,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                onTap: () => _showSnackBar('Album: Electronic Pulse'),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Artists Carousel
          BerryCarousel.artists(
            sectionTitle: 'Popular Artists',
            onSeeAll: () => _showSnackBar('See all artists'),
            items: [
              BerryCarouselItem(
                title: 'Luna Martinez',
                subtitle: '2.1M followers',
                image: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryPurpleLight,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                onTap: () => _showSnackBar('Artist: Luna Martinez'),
              ),
              BerryCarouselItem(
                title: 'The Waves',
                subtitle: '890K followers',
                image: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryCyanLight,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.group,
                      size: 40,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                onTap: () => _showSnackBar('Artist: The Waves'),
              ),
              BerryCarouselItem(
                title: 'DJ Echo',
                subtitle: '1.5M followers',
                image: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentElectricLight,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.headset_mic,
                      size: 40,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                badge: CarouselBadge.hot(),
                onTap: () => _showSnackBar('Artist: DJ Echo'),
              ),
              BerryCarouselItem(
                title: 'Acoustic Soul',
                subtitle: '654K followers',
                image: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentAmberLight,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.piano,
                      size: 40,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                onTap: () => _showSnackBar('Artist: Acoustic Soul'),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Playlists Carousel
          BerryCarousel.playlists(
            sectionTitle: 'Your Playlists',
            onSeeAll: () => _showSnackBar('See all playlists'),
            items: [
              BerryCarouselItem(
                title: 'Morning Coffee',
                subtitle: '24 songs',
                image: Container(
                  color: AppColors.accentAmberDark,
                  child: const Center(
                    child: Icon(
                      Icons.coffee,
                      size: 28,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                onTap: () => _showSnackBar('Playlist: Morning Coffee'),
              ),
              BerryCarouselItem(
                title: 'Workout Mix',
                subtitle: '45 songs',
                image: Container(
                  color: AppColors.accentElectricDark,
                  child: const Center(
                    child: Icon(
                      Icons.fitness_center,
                      size: 28,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                onTap: () => _showSnackBar('Playlist: Workout Mix'),
              ),
              BerryCarouselItem(
                title: 'Study Focus',
                subtitle: '67 songs',
                image: Container(
                  color: AppColors.primaryPurpleDark,
                  child: const Center(
                    child: Icon(
                      Icons.school,
                      size: 28,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                badge: CarouselBadge.premium(),
                onTap: () => _showSnackBar('Playlist: Study Focus'),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColors.primaryPurple,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}