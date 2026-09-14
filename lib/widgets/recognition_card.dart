import 'package:flutter/material.dart';
import 'package:findmytutor/backend/models/tutor_model.dart';
import 'package:findmytutor/widgets/app_colors.dart';

/// A card widget displaying a tutor's recognition/award.
///
/// Matches the "Recognition" section in the wireframe, showing a badge area
/// with the recognition title, tutor ID, name, and date.
class RecognitionCard extends StatelessWidget {
  final TutorModel tutor;

  const RecognitionCard({
    super.key,
    required this.tutor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dark.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          // Badge area
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.teal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Text(
                tutor.recognitionTitle ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.teal,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Tutor details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${tutor.id}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tutor.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dark.withValues(alpha: 0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.dark.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tutor.recognitionDate ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.dark.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
