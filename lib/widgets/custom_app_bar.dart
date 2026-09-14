import 'package:flutter/material.dart';
import 'package:findmytutor/widgets/app_colors.dart';

/// A reusable app bar with hamburger menu, centered title, and notification icon.
///
/// Used across all screens to maintain a consistent top bar appearance.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onMenuPressed,
    this.onNotificationPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.dark),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onPressed: onMenuPressed ?? () => Scaffold.of(context).openDrawer(),
        tooltip: 'Menu',
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.dark,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.dark,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: onNotificationPressed ?? () {},
          tooltip: 'Notifications',
        ),
      ],
    );
  }
}
