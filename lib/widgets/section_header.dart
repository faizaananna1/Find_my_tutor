import 'package:flutter/material.dart';
import 'package:findmytutor/widgets/app_colors.dart';

/// A reusable section header with a title and optional "See All" action.
///
/// Used to introduce sections like "Recognition", "Top Tutors", etc.
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.dark,
            ),
          ),
          if (onSeeAllPressed != null)
            GestureDetector(
              onTap: onSeeAllPressed,
              child: const Text(
                'See All',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.teal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
