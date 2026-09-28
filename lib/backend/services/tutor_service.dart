import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmytutor/backend/models/tutor_model.dart';
import 'package:findmytutor/backend/models/subject_model.dart';

/// Service class providing tutor & subject data backed by Cloud Firestore.
class TutorService extends ChangeNotifier {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static List<TutorModel> _cachedTutors = _initialTutors;
  static final List<SubjectModel> _cachedSubjects = _initialSubjects;
  static bool _isInitialized = false;

  /// Returns the list of available subject categories.
  static List<SubjectModel> getSubjects() => _cachedSubjects;

  /// Returns the list of available tutors.
  static List<TutorModel> getTutors() => _cachedTutors;

  /// Returns the recognized tutor (the one with a recognition award).
  static TutorModel? getRecognizedTutor() {
    return _cachedTutors.cast<TutorModel?>().firstWhere(
          (tutor) => tutor!.hasRecognition,
          orElse: () => _cachedTutors.isNotEmpty ? _cachedTutors.first : null,
        );
  }

  /// Initializes Firestore data listener and seeds sample data if needed.
  static Future<void> initializeData() async {
    if (_isInitialized) return;
    _isInitialized = true;

    try {
      final tutorSnapshot = await _firestore.collection('tutors').get();
      if (tutorSnapshot.docs.isEmpty) {
        // Seed initial tutors to Cloud Firestore
        for (final tutor in _initialTutors) {
          await _firestore.collection('tutors').doc(tutor.id).set(tutor.toMap());
        }
      } else {
        _cachedTutors = tutorSnapshot.docs
            .map((doc) => TutorModel.fromMap(doc.data(), docId: doc.id))
            .toList();
      }
    } catch (e) {
      debugPrint('TutorService Firestore sync notice: $e');
    }
  }

  /// Search and filter tutors by subject name or search query.
  static List<TutorModel> searchTutors({String? subject, String? query}) {
    return _cachedTutors.where((tutor) {
      final matchesSubject = subject == null ||
          subject.isEmpty ||
          tutor.subject.toLowerCase() == subject.toLowerCase();

      final matchesQuery = query == null ||
          query.isEmpty ||
          tutor.name.toLowerCase().contains(query.toLowerCase()) ||
          tutor.subject.toLowerCase().contains(query.toLowerCase());

      return matchesSubject && matchesQuery;
    }).toList();
  }

  /// Fetch single tutor by ID.
  static TutorModel? getTutorById(String id) {
    try {
      return _cachedTutors.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Seed Subject list fallback
  static List<SubjectModel> get _initialSubjects => const [
        SubjectModel(name: 'Physics', icon: Icons.science_outlined),
        SubjectModel(name: 'Chemistry', icon: Icons.biotech_outlined),
        SubjectModel(name: 'English', icon: Icons.menu_book_outlined),
        SubjectModel(name: 'Math', icon: Icons.calculate_outlined),
      ];

  /// Seed Tutor list fallback
  static List<TutorModel> get _initialTutors => const [
        TutorModel(
          id: '331275',
          name: 'Md. Mushfikur Rahman',
          subject: 'Math',
          rating: 4.8,
          imagePath: 'assets/images/tutor_placeholder.png',
          recognitionTitle: 'Tutor of the Month',
          recognitionDate: 'August 2026',
          bio: 'Specialized in Higher Math and Calculus with 5+ years of teaching experience.',
          hourlyRate: 600.0,
          email: 'mushfikur@tutor.com',
          phone: '+880 1711-123456',
          experienceYears: 5,
          subjectsHandled: ['Math', 'Calculus', 'Algebra'],
        ),
        TutorModel(
          id: '331276',
          name: 'Ayesha Siddiqua',
          subject: 'Physics',
          rating: 4.6,
          imagePath: 'assets/images/tutor_placeholder.png',
          bio: 'Physics enthusiast breaking down complex mechanics & thermodynamics concepts.',
          hourlyRate: 550.0,
          email: 'ayesha@tutor.com',
          phone: '+880 1812-654321',
          experienceYears: 4,
          subjectsHandled: ['Physics', 'Astrophysics'],
        ),
        TutorModel(
          id: '331277',
          name: 'Rahim Uddin Ahmed',
          subject: 'Chemistry',
          rating: 4.5,
          imagePath: 'assets/images/tutor_placeholder.png',
          bio: 'Organic and Inorganic Chemistry expert helping students top their exams.',
          hourlyRate: 500.0,
          email: 'rahim@tutor.com',
          phone: '+880 1913-789012',
          experienceYears: 3,
          subjectsHandled: ['Chemistry', 'Biochemistry'],
        ),
        TutorModel(
          id: '331278',
          name: 'Fatima Begum',
          subject: 'English',
          rating: 4.7,
          imagePath: 'assets/images/tutor_placeholder.png',
          bio: 'IELTS Band 8.5 certified English literature & language instructor.',
          hourlyRate: 500.0,
          email: 'fatima@tutor.com',
          phone: '+880 1614-345678',
          experienceYears: 4,
          subjectsHandled: ['English', 'IELTS', 'Grammar'],
        ),
      ];
}
