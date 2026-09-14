import 'package:flutter/material.dart';
import 'package:findmytutor/widgets/app_colors.dart';
import 'package:findmytutor/widgets/custom_app_bar.dart';
import 'package:findmytutor/widgets/subject_icon.dart';
import 'package:findmytutor/widgets/tutor_card.dart';
import 'package:findmytutor/widgets/recognition_card.dart';
import 'package:findmytutor/widgets/section_header.dart';
import 'package:findmytutor/backend/models/subject_model.dart';
import 'package:findmytutor/backend/models/tutor_model.dart';
import 'package:findmytutor/backend/services/tutor_service.dart';

/// The main home screen of the FindMyTutor app.
///
/// Displays:
/// - A horizontally scrollable row of subject category icons
/// - A recognition card highlighting an awarded tutor
/// - A list of top tutor cards
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<SubjectModel> _subjects;
  late final List<TutorModel> _tutors;
  late final TutorModel? _recognizedTutor;

  int _selectedSubjectIndex = -1;

  @override
  void initState() {
    super.initState();
    _subjects = TutorService.getSubjects();
    _tutors = TutorService.getTutors();
    _recognizedTutor = TutorService.getRecognizedTutor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: 'Home Screen'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Subject categories row ---
              _buildSubjectRow(),
              const SizedBox(height: 24),

              // --- Recognition section ---
              if (_recognizedTutor != null) ...[
                const SectionHeader(title: 'Recognition'),
                RecognitionCard(tutor: _recognizedTutor),
                const SizedBox(height: 24),
              ],

              // --- Top tutors section ---
              SectionHeader(
                title: 'Top Tutors',
                onSeeAllPressed: () {
                  // Placeholder for navigation
                },
              ),
              ..._tutors.map(
                (tutor) => TutorCard(
                  tutor: tutor,
                  onTap: () {
                    // Placeholder for tutor detail navigation
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the horizontally scrollable subject categories row.
  Widget _buildSubjectRow() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _subjects.length,
        separatorBuilder: (_, _) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          final subject = _subjects[index];
          return SubjectIcon(
            icon: subject.icon,
            label: subject.name,
            isSelected: _selectedSubjectIndex == index,
            onTap: () {
              setState(() {
                _selectedSubjectIndex =
                    _selectedSubjectIndex == index ? -1 : index;
              });
            },
          );
        },
      ),
    );
  }
}
