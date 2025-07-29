import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import '../core/theme/text_styles.dart';

enum BerryCarouselType {
  album,      // Album covers
  playlist,   // Playlist covers
  artist,     // Artist images
  featured,   // Featured content
}

class BerryCarouselItem {
  final String title;
  final String? subtitle;
  final Widget image;
  final VoidCallback? onTap;
  final Widget? badge;

  const BerryCarouselItem({
    required this.title,
    this.subtitle,
    required this.image,
    this.onTap,
    this.badge,
  });
}

class BerryCarousel extends StatefulWidget {
  final List<BerryCarouselItem> items;
  final BerryCarouselType type;
  final double itemWidth;
  final double itemHeight;
  final EdgeInsets? margin;
  final String? sectionTitle;
  final VoidCallback? onSeeAll;
  
  const BerryCarousel({
    super.key,
    required this.items,
    this.type = BerryCarouselType.album,
    this.itemWidth = 160,
    this.itemHeight = 200,
    this.margin,
    this.sectionTitle,
    this.onSeeAll,
  });

  factory BerryCarousel.albums({
    Key? key,
    required List<BerryCarouselItem> items,
    String? sectionTitle = 'Recent Albums',
    VoidCallback? onSeeAll,
    EdgeInsets? margin,
  }) {
    return BerryCarousel(
      key: key,
      items: items,
      type: BerryCarouselType.album,
      itemWidth: 160,
      itemHeight: 220,
      sectionTitle: sectionTitle,
      onSeeAll: onSeeAll,
      margin: margin,
    );
  }

  factory BerryCarousel.playlists({
    Key? key,
    required List<BerryCarouselItem> items,
    String? sectionTitle = 'Your Playlists',
    VoidCallback? onSeeAll,
    EdgeInsets? margin,
  }) {
    return BerryCarousel(
      key: key,
      items: items,
      type: BerryCarouselType.playlist,
      itemWidth: 140,
      itemHeight: 180,
      sectionTitle: sectionTitle,
      onSeeAll: onSeeAll,
      margin: margin,
    );
  }

  factory BerryCarousel.artists({
    Key? key,
    required List<BerryCarouselItem> items,
    String? sectionTitle = 'Popular Artists',
    VoidCallback? onSeeAll,
    EdgeInsets? margin,
  }) {
    return BerryCarousel(
      key: key,
      items: items,
      type: BerryCarouselType.artist,
      itemWidth: 120,
      itemHeight: 160,
      sectionTitle: sectionTitle,
      onSeeAll: onSeeAll,
      margin: margin,
    );
  }

  factory BerryCarousel.featured({
    Key? key,
    required List<BerryCarouselItem> items,
    String? sectionTitle = 'Featured',
    VoidCallback? onSeeAll,
    EdgeInsets? margin,
  }) {
    return BerryCarousel(
      key: key,
      items: items,
      type: BerryCarouselType.featured,
      itemWidth: 280,
      itemHeight: 160,
      sectionTitle: sectionTitle,
      onSeeAll: onSeeAll,
      margin: margin,
    );
  }

  @override
  State<BerryCarousel> createState() => _BerryCarouselState();
}

class _BerryCarouselState extends State<BerryCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: _getViewportFraction(),
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double _getViewportFraction() {
    switch (widget.type) {
      case BerryCarouselType.featured:
        return 0.85;
      case BerryCarouselType.album:
        return 0.45;
      case BerryCarouselType.playlist:
        return 0.4;
      case BerryCarouselType.artist:
        return 0.35;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          if (widget.sectionTitle != null)
            _buildSectionHeader(),
          
          const SizedBox(height: 16),
          
          // Carousel
          SizedBox(
            height: widget.itemHeight,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return _buildCarouselItem(context, index);
              },
            ),
          ),
          
          // Page Indicators (for featured type)
          if (widget.type == BerryCarouselType.featured && widget.items.length > 1)
            _buildPageIndicators(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.sectionTitle!,
            style: AppTextStyles.titleLarge.darkPrimary,
          ),
          if (widget.onSeeAll != null)
            TextButton(
              onPressed: widget.onSeeAll,
              child: Text(
                'See All',
                style: AppTextStyles.labelLarge.secondaryCyan,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, int index) {
    final item = widget.items[index];
    final isActive = index == _currentIndex;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      width: widget.itemWidth,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      transform: Matrix4.identity()
        ..scale(isActive ? 1.0 : 0.95),
      child: GestureDetector(
        onTap: item.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_getBorderRadius()),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowMedium,
                      blurRadius: isActive ? 12 : 8,
                      spreadRadius: 0,
                      offset: Offset(0, isActive ? 6 : 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Main Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(_getBorderRadius()),
                      child: SizedBox.expand(
                        child: item.image,
                      ),
                    ),
                    
                    // Gradient Overlay (for featured type)
                    if (widget.type == BerryCarouselType.featured)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(_getBorderRadius()),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.darkBackground.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                      ),
                    
                    // Badge
                    if (item.badge != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: item.badge!,
                      ),
                    
                    // Play Button Overlay (for albums and playlists)
                    if (widget.type == BerryCarouselType.album || 
                        widget.type == BerryCarouselType.playlist)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.accentElectric,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentElectric.withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: AppColors.textOnPrimary,
                            size: 24,
                          ),
                        ),
                      ),
                    
                    // Artist circular crop for artist type
                    if (widget.type == BerryCarouselType.artist)
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryPurpleLight,
                            width: 2,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Text Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: _getTitleStyle(),
                    maxLines: widget.type == BerryCarouselType.featured ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle!,
                      style: _getSubtitleStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.items.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: index == _currentIndex ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: index == _currentIndex
                  ? AppColors.primaryPurpleLight
                  : AppColors.neutralMedium.withValues(alpha: 0.3),
            ),
          );
        }),
      ),
    );
  }

  double _getBorderRadius() {
    switch (widget.type) {
      case BerryCarouselType.artist:
        return 60; // Circular for artists
      case BerryCarouselType.featured:
        return 16;
      default:
        return 12;
    }
  }

  TextStyle _getTitleStyle() {
    switch (widget.type) {
      case BerryCarouselType.featured:
        return AppTextStyles.titleMedium.darkPrimary;
      case BerryCarouselType.artist:
        return AppTextStyles.labelLarge.darkPrimary;
      default:
        return AppTextStyles.bodyMedium.darkPrimary;
    }
  }

  TextStyle _getSubtitleStyle() {
    switch (widget.type) {
      case BerryCarouselType.featured:
        return AppTextStyles.bodySmall.darkSecondary;
      default:
        return AppTextStyles.labelSmall.darkTertiary;
    }
  }
}

// Utility widget for creating common badges
class CarouselBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const CarouselBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  factory CarouselBadge.new_() {
    return const CarouselBadge(
      text: 'NEW',
      backgroundColor: AppColors.accentElectric,
      textColor: AppColors.textOnPrimary,
    );
  }

  factory CarouselBadge.hot() {
    return const CarouselBadge(
      text: 'HOT',
      backgroundColor: AppColors.accentAmber,
      textColor: AppColors.textOnPrimary,
    );
  }

  factory CarouselBadge.premium() {
    return const CarouselBadge(
      text: 'PREMIUM',
      backgroundColor: AppColors.primaryPurpleLight,
      textColor: AppColors.textOnPrimary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryPurple,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (backgroundColor ?? AppColors.primaryPurple).withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: textColor ?? AppColors.textOnPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}