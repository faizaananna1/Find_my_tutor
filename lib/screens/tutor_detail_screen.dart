import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findmytutor/backend/models/tutor_model.dart';
import 'package:findmytutor/backend/services/auth_service.dart';
import 'package:findmytutor/backend/services/booking_service.dart';
import 'package:findmytutor/widgets/app_colors.dart';

class TutorDetailScreen extends StatefulWidget {
  final TutorModel tutor;

  const TutorDetailScreen({super.key, required this.tutor});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  void _showBookingBottomSheet(BuildContext context) {
    final noteController = TextEditingController();
    DateTime selectedDate = DateTime.now().add(const Duration(days: 1));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Book Session with ${widget.tutor.shortName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Date:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.calendar_today, color: AppColors.teal),
                        label: Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: const TextStyle(
                            color: AppColors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 60)),
                          );
                          if (picked != null) {
                            setModalState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Add a note or specific topics...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      final authService = Provider.of<AuthService>(context, listen: false);
                      final bookingService = Provider.of<BookingService>(context, listen: false);
                      final user = authService.currentUserModel;

                      final studentId = user?.uid ?? 'guest-student';
                      final studentName = user?.fullName ?? 'Student';
                      final studentEmail = user?.email ?? 'student@example.com';

                      await bookingService.createBooking(
                        studentId: studentId,
                        studentName: studentName,
                        studentEmail: studentEmail,
                        tutorId: widget.tutor.id,
                        tutorName: widget.tutor.name,
                        subject: widget.tutor.subject,
                        requestedDate: selectedDate,
                        note: noteController.text.trim(),
                      );

                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Booking request sent to ${widget.tutor.shortName}!',
                            ),
                            backgroundColor: AppColors.teal,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'CONFIRM BOOKING',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(widget.tutor.name),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.dark,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.teal.withValues(alpha: 0.1),
                    backgroundImage: widget.tutor.photoUrl != null
                        ? NetworkImage(widget.tutor.photoUrl!)
                        : AssetImage(widget.tutor.imagePath) as ImageProvider,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tutor.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.tutor.subject} Specialist',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.teal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.tutor.rating}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${widget.tutor.experienceYears} Years Exp.',
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
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // Hourly Rate & Recognition
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hourly Rate',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.dark.withValues(alpha: 0.5),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '৳${widget.tutor.hourlyRate.toInt()} / hr',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.teal,
                        ),
                      ),
                    ],
                  ),
                  if (widget.tutor.hasRecognition)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.teal.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.emoji_events, color: AppColors.teal, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            widget.tutor.recognitionTitle ?? 'Award Winner',
                            style: const TextStyle(
                              color: AppColors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),

              // About / Bio
              const Text(
                'About Tutor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.tutor.bio,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.dark.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),

              // Subjects Handled
              if (widget.tutor.subjectsHandled.isNotEmpty) ...[
                const Text(
                  'Subjects & Topics',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.tutor.subjectsHandled
                      .map(
                        (subj) => Chip(
                          label: Text(subj),
                          backgroundColor: AppColors.teal.withValues(alpha: 0.08),
                          side: BorderSide.none,
                          labelStyle: const TextStyle(
                            color: AppColors.teal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
              ],

              // Contact Info
              const Text(
                'Contact Info',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.email_outlined, color: AppColors.teal),
                title: Text(widget.tutor.email.isNotEmpty ? widget.tutor.email : 'Available upon booking'),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.phone_outlined, color: AppColors.teal),
                title: Text(widget.tutor.phone.isNotEmpty ? widget.tutor.phone : 'Available upon booking'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => _showBookingBottomSheet(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.teal,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'BOOK A SESSION NOW',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
