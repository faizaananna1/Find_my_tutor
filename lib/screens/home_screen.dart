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
import 'package:findmytutor/screens/tutor_detail_screen.dart';

/// The main home screen of the FindMyTutor app.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<SubjectModel> _subjects;
  late List<TutorModel> _filteredTutors;
  late final TutorModel? _recognizedTutor;

  int _selectedSubjectIndex = -1;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _subjects = TutorService.getSubjects();
    _filteredTutors = TutorService.getTutors();
    _recognizedTutor = TutorService.getRecognizedTutor();
    TutorService.initializeData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilter() {
    final selectedSubjectName = _selectedSubjectIndex != -1
        ? _subjects[_selectedSubjectIndex].name
        : null;

    setState(() {
      _filteredTutors = TutorService.searchTutors(
        subject: selectedSubjectName,
        query: _searchController.text.trim(),
      );
    });
  }

  void _navigateToDetail(TutorModel tutor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TutorDetailScreen(tutor: tutor),
      ),
    );
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
              // Search Bar
              TextField(
                controller: _searchController,
                onChanged: (_) => _applyFilter(),
                decoration: InputDecoration(
                  hintText: 'Search tutors or subjects...',
                  prefixIcon: const Icon(Icons.search, color: AppColors.teal),
                  filled: true,
                  fillColor: AppColors.dark.withValues(alpha: 0.04),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              const SizedBox(height: 16),

              // Subject categories row
              _buildSubjectRow(),
              const SizedBox(height: 24),

              // Recognition section
              if (_recognizedTutor != null && _selectedSubjectIndex == -1) ...[
                const SectionHeader(title: 'Recognition'),
                GestureDetector(
                  onTap: () => _navigateToDetail(_recognizedTutor),
                  child: RecognitionCard(tutor: _recognizedTutor),
                ),
                const SizedBox(height: 24),
              ],

              // Top tutors section
              SectionHeader(
                title: _selectedSubjectIndex != -1
                    ? '${_subjects[_selectedSubjectIndex].name} Tutors'
                    : 'Top Tutors',
              ),
              if (_filteredTutors.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      'No tutors found matching your search.',
                      style: TextStyle(
                        color: AppColors.dark.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                )
              else
                ..._filteredTutors.map(
                  (tutor) => TutorCard(
                    tutor: tutor,
                    onTap: () => _navigateToDetail(tutor),
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
              _applyFilter();
            },
          );
        },
      ),
    );
  }
}
