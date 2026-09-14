import 'package:flutter/material.dart';
import 'package:findmytutor/backend/models/tutor_model.dart';
import 'package:findmytutor/widgets/app_colors.dart';

/// A horizontal card widget displaying a tutor's profile summary.
///
/// Shows a placeholder image on the left with the tutor's name, subject,
/// and rating on the right. Matches the tutor listing cards in the wireframe.
class TutorCard extends StatelessWidget {
  final TutorModel tutor;
  final VoidCallback? onTap;

  const TutorCard({
    super.key,
    required this.tutor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Tutor image placeholder
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.person,
                size: 36,
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(width: 14),
            // Tutor info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tutor.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tutor.subject,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: AppColors.teal),
                      const SizedBox(width: 4),
                      Text(
                        tutor.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.white.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
