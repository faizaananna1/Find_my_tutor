import 'package:flutter/material.dart';
import 'package:findmytutor/backend/models/tutor_model.dart';
import 'package:findmytutor/backend/models/subject_model.dart';

/// Service class providing mock data for the app.
///
/// In a production app, these methods would fetch from an API.
/// For now, they return static sample data.
class TutorService {
  TutorService._();

  /// Returns the list of available subject categories.
  static List<SubjectModel> getSubjects() {
    return const [
      SubjectModel(name: 'Physics', icon: Icons.science_outlined),
      SubjectModel(name: 'Chemistry', icon: Icons.biotech_outlined),
      SubjectModel(name: 'English', icon: Icons.menu_book_outlined),
      SubjectModel(name: 'Math', icon: Icons.calculate_outlined),
    ];
  }

  /// Returns the list of available tutors.
  static List<TutorModel> getTutors() {
    return const [
      TutorModel(
        id: '331275',
        name: 'Md. Mushfikur Rahman',
        subject: 'Math',
        rating: 4.8,
        imagePath: 'assets/images/tutor_placeholder.png',
        recognitionTitle: 'Tutor of the Math',
        recognitionDate: 'August 2026',
      ),
      TutorModel(
        id: '331276',
        name: 'Ayesha Siddiqua',
        subject: 'Physics',
        rating: 4.6,
        imagePath: 'assets/images/tutor_placeholder.png',
      ),
      TutorModel(
        id: '331277',
        name: 'Rahim Uddin Ahmed',
        subject: 'Chemistry',
        rating: 4.5,
        imagePath: 'assets/images/tutor_placeholder.png',
      ),
      TutorModel(
        id: '331278',
        name: 'Fatima Begum',
        subject: 'English',
        rating: 4.7,
        imagePath: 'assets/images/tutor_placeholder.png',
      ),
    ];
  }

  /// Returns the recognized tutor (the one with a recognition award).
  static TutorModel? getRecognizedTutor() {
    return getTutors().cast<TutorModel?>().firstWhere(
          (tutor) => tutor!.hasRecognition,
          orElse: () => null,
        );
  }
}
