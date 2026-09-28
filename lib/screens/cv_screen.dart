import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findmytutor/widgets/app_colors.dart';
import 'package:findmytutor/widgets/custom_app_bar.dart';
import 'package:findmytutor/backend/services/auth_service.dart';
import 'package:findmytutor/screens/login_screen.dart';

/// The CV / Profile screen of the FindMyTutor app.
class CvScreen extends StatefulWidget {
  const CvScreen({super.key});

  @override
  State<CvScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {
  void _showEditProfileDialog(BuildContext context, AuthService authService) {
    final user = authService.currentUserModel;
    final nameController = TextEditingController(text: user?.fullName ?? '');
    final phoneController = TextEditingController(text: user?.phone ?? '');
    final locationController = TextEditingController(text: user?.location ?? '');
    final uniController = TextEditingController(text: user?.university ?? '');
    final deptController = TextEditingController(text: user?.department ?? '');
    final yearController = TextEditingController(text: user?.year ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                TextField(
                  controller: uniController,
                  decoration: const InputDecoration(labelText: 'University'),
                ),
                TextField(
                  controller: deptController,
                  decoration: const InputDecoration(labelText: 'Department'),
                ),
                TextField(
                  controller: yearController,
                  decoration: const InputDecoration(labelText: 'Year / Semester'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await authService.updateProfile(
                  fullName: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  location: locationController.text.trim(),
                  university: uniController.text.trim(),
                  department: deptController.text.trim(),
                  year: yearController.text.trim(),
                  preferredSubjects: user?.preferredSubjects ?? ['Math', 'Physics'],
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                      backgroundColor: AppColors.teal,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.teal),
              child: const Text('Save', style: TextStyle(color: AppColors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final user = authService.currentUserModel;

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
                child: const Icon(
                  Icons.person,
                  size: 48,
                  color: AppColors.teal,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user?.fullName ?? 'Guest User',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user?.email ?? 'Not logged in',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.dark.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 16),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.edit, size: 18, color: AppColors.teal),
                    label: const Text('Edit Profile', style: TextStyle(color: AppColors.teal)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.teal),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _showEditProfileDialog(context, authService),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.logout, size: 18, color: Colors.redAccent),
                    label: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.redAccent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await authService.signOut();
                      if (context.mounted) {
                        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Info sections
              _buildSection(
                title: 'Personal Information',
                items: [
                  {'label': 'Email', 'value': user?.email ?? 'N/A'},
                  {'label': 'Phone', 'value': user?.phone.isNotEmpty == true ? user!.phone : '+880 1700-000000'},
                  {'label': 'Location', 'value': user?.location ?? 'Dhaka, Bangladesh'},
                  {'label': 'Account Role', 'value': (user?.role ?? 'student').toUpperCase()},
                ],
              ),
              const SizedBox(height: 20),
              _buildSection(
                title: 'Education',
                items: [
                  {'label': 'University', 'value': user?.university.isNotEmpty == true ? user!.university : 'Dhaka University'},
                  {'label': 'Department', 'value': user?.department.isNotEmpty == true ? user!.department : 'Computer Science'},
                  {'label': 'Year', 'value': user?.year.isNotEmpty == true ? user!.year : '4th Year'},
                ],
              ),
              const SizedBox(height: 20),
              _buildSection(
                title: 'Preferred Subjects',
                items: [
                  {'label': 'Primary', 'value': 'Mathematics'},
                  {'label': 'Secondary', 'value': 'Physics'},
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
