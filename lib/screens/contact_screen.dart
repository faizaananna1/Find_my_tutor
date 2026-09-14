import 'package:flutter/material.dart';
import 'package:findmytutor/widgets/app_colors.dart';
import 'package:findmytutor/widgets/custom_app_bar.dart';

/// The contact screen of the FindMyTutor app.
///
/// Displays app contact information including email, phone, and address.
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: 'Contact'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Get in Touch',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Have questions? Reach out to us and we\'ll get back to you as soon as possible.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.dark.withValues(alpha: 0.5),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),

              // Contact items
              _buildContactItem(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'support@findmytutor.com',
              ),
              _buildContactItem(
                icon: Icons.phone_outlined,
                title: 'Phone',
                subtitle: '+880 1234-567890',
              ),
              _buildContactItem(
                icon: Icons.location_on_outlined,
                title: 'Address',
                subtitle: 'Dhaka, Bangladesh',
              ),
              _buildContactItem(
                icon: Icons.access_time_outlined,
                title: 'Hours',
                subtitle: 'Sat - Thu, 9:00 AM - 6:00 PM',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a single contact info row with an icon, title, and subtitle.
  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.teal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.teal, size: 24),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.dark.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
