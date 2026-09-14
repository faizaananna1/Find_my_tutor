import 'package:flutter/material.dart';
import 'package:findmytutor/widgets/app_colors.dart';
import 'package:findmytutor/widgets/custom_app_bar.dart';

/// The CV / Profile screen of the FindMyTutor app.
///
/// Displays the user's profile summary with placeholder sections
/// for personal info, education, and skills.
class CvScreen extends StatelessWidget {
  const CvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: 'Profile'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              // Profile avatar
              CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.teal.withValues(alpha: 0.1),
                child: Icon(
                  Icons.person,
                  size: 48,
                  color: AppColors.teal.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 24),

              // Info sections
              _buildSection(
                title: 'Personal Information',
                items: const [
                  {'label': 'Email', 'value': 'you@example.com'},
                  {'label': 'Phone', 'value': '+880 0000-000000'},
                  {'label': 'Location', 'value': 'Dhaka, Bangladesh'},
                ],
              ),
              const SizedBox(height: 20),
              _buildSection(
                title: 'Education',
                items: const [
                  {'label': 'University', 'value': 'Your University'},
                  {'label': 'Department', 'value': 'Your Department'},
                  {'label': 'Year', 'value': '2026'},
                ],
              ),
              const SizedBox(height: 20),
              _buildSection(
                title: 'Preferred Subjects',
                items: const [
                  {'label': 'Subject 1', 'value': 'Mathematics'},
                  {'label': 'Subject 2', 'value': 'Physics'},
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a labeled section card with a list of key-value rows.
  Widget _buildSection({
    required String title,
    required List<Map<String, String>> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.dark.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dark.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.dark,
            ),
          ),
          Divider(height: 20, color: AppColors.dark.withValues(alpha: 0.1)),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['label']!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.dark.withValues(alpha: 0.5),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      item['value']!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.dark,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
