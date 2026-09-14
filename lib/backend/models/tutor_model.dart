/// Data model representing a tutor in the FindMyTutor app.
class TutorModel {
  final String id;
  final String name;
  final String subject;
  final double rating;
  final String imagePath;
  final String? recognitionTitle;
  final String? recognitionDate;

  const TutorModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.rating,
    required this.imagePath,
    this.recognitionTitle,
    this.recognitionDate,
  });

  /// Returns the tutor's display name in a shortened form.
  String get shortName {
    final parts = name.split(' ');
    if (parts.length <= 2) return name;
    return '${parts.first} ${parts.last}';
  }

  /// Whether this tutor has a recognition award.
  bool get hasRecognition =>
      recognitionTitle != null && recognitionDate != null;
}
