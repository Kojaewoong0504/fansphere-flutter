import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import '../core/theme/text_styles.dart';

class BerryBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BerryNavItem> items;
  final Color? backgroundColor;
  
  const BerryBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 16,
            spreadRadius: 0,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.primaryPurple,
          unselectedItemColor: AppColors.neutralMedium,
          selectedLabelStyle: AppTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTextStyles.labelSmall,
          items: items.map((item) => BottomNavigationBarItem(
            icon: _buildNavIcon(item.icon, false),
            activeIcon: _buildNavIcon(item.activeIcon ?? item.icon, true),
            label: item.label,
          )).toList(),
        ),
      ),
    );
  }
  
  Widget _buildNavIcon(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: isActive ? BoxDecoration(
        color: AppColors.primaryPurple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ) : null,
      child: Icon(
        icon,
        size: 24,
        color: isActive ? AppColors.primaryPurple : AppColors.neutralMedium,
      ),
    );
  }
}

class BerryNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  
  const BerryNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

// Spotify-inspired tab bar
class BerryTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;
  final TabController controller;
  final ValueChanged<int>? onTap;
  final bool isScrollable;
  final Color? backgroundColor;
  final Color? indicatorColor;
  
  const BerryTabBar({
    super.key,
    required this.tabs,
    required this.controller,
    this.onTap,
    this.isScrollable = false,
    this.backgroundColor,
    this.indicatorColor,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: TabBar(
        controller: controller,
        onTap: onTap,
        isScrollable: isScrollable,
        labelColor: AppColors.pureWhite,
        unselectedLabelColor: AppColors.darkTextSecondary,
        labelStyle: AppTextStyles.titleMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.titleMedium,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3,
            color: indicatorColor ?? AppColors.primaryPurple,
          ),
          insets: const EdgeInsets.symmetric(horizontal: 16),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: tabs.map((tab) => Tab(
          text: tab,
          height: 48,
        )).toList(),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(48);
}

// Custom app bar with berry theme
class BerryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final double? titleSpacing;
  
  const BerryAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = false,
    this.bottom,
    this.titleSpacing,
  });
  
  factory BerryAppBar.search({
    Key? key,
    required VoidCallback onSearchTap,
    Widget? leading,
    List<Widget>? actions,
  }) {
    return BerryAppBar(
      key: key,
      leading: leading,
      titleWidget: GestureDetector(
        onTap: onSearchTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.cardBorderDark,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              const Icon(
                Icons.search,
                color: AppColors.neutralMedium,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Search music, artists...',
                style: AppTextStyles.bodyMedium.tertiary,
              ),
            ],
          ),
        ),
      ),
      actions: actions,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      bottom: bottom,
      titleSpacing: titleSpacing,
      titleTextStyle: AppTextStyles.headlineSmall,
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );
}

// Berry-themed drawer
class BerryDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final Widget? userAvatar;
  final List<BerryDrawerItem> items;
  final ValueChanged<int>? onItemTap;
  final Widget? footer;
  
  const BerryDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.userAvatar,
    required this.items,
    this.onItemTap,
    this.footer,
  });
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.primaryToLight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (userAvatar != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: userAvatar!,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (userName != null)
                      Text(
                        userName!,
                        style: AppTextStyles.titleLarge.onPrimary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (userEmail != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        userEmail!,
                        style: AppTextStyles.bodySmall.onPrimary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          
          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: AppColors.primaryPurple,
                  ),
                  title: Text(
                    item.title,
                    style: AppTextStyles.titleMedium,
                  ),
                  subtitle: item.subtitle != null 
                      ? Text(
                          item.subtitle!,
                          style: AppTextStyles.bodySmall.secondary,
                        ) 
                      : null,
                  onTap: () => onItemTap?.call(index),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                );
              },
            ),
          ),
          
          // Footer
          if (footer != null) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: footer!,
            ),
          ],
        ],
      ),
    );
  }
}

class BerryDrawerItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  
  const BerryDrawerItem({
    required this.icon,
    required this.title,
    this.subtitle,
  });
}