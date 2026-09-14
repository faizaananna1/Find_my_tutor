import 'package:flutter/material.dart';
import 'package:findmytutor/widgets/app_colors.dart';

/// A circular icon widget for displaying subject categories.
///
/// Shows a circular container with an icon and a label below it.
/// Used in the horizontally scrollable subject row on the home screen.
class SubjectIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;

  const SubjectIcon({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.teal : AppColors.white,
              border: Border.all(
                color: isSelected ? AppColors.teal : AppColors.dark,
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              size: 28,
              color: isSelected ? AppColors.white : AppColors.dark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}
