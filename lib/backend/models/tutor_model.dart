/// Data model representing a tutor in the FindMyTutor app.
class TutorModel {
  final String id;
  final String name;
  final String subject;
  final double rating;
  final String imagePath;
  final String? photoUrl;
  final String? recognitionTitle;
  final String? recognitionDate;
  final String bio;
  final double hourlyRate;
  final String email;
  final String phone;
  final int experienceYears;
  final List<String> subjectsHandled;

  const TutorModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.rating,
    required this.imagePath,
    this.photoUrl,
    this.recognitionTitle,
    this.recognitionDate,
    this.bio = 'Experienced tutor passionate about teaching.',
    this.hourlyRate = 500.0,
    this.email = '',
    this.phone = '',
    this.experienceYears = 3,
    this.subjectsHandled = const [],
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'rating': rating,
      'imagePath': imagePath,
      'photoUrl': photoUrl,
      'recognitionTitle': recognitionTitle,
      'recognitionDate': recognitionDate,
      'bio': bio,
      'hourlyRate': hourlyRate,
      'email': email,
      'phone': phone,
      'experienceYears': experienceYears,
      'subjectsHandled': subjectsHandled,
    };
  }

  factory TutorModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return TutorModel(
      id: docId ?? map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Tutor',
      subject: map['subject'] as String? ?? 'General',
      rating: (map['rating'] as num?)?.toDouble() ?? 4.5,
      imagePath: map['imagePath'] as String? ?? 'assets/images/tutor_placeholder.png',
      photoUrl: map['photoUrl'] as String?,
      recognitionTitle: map['recognitionTitle'] as String?,
      recognitionDate: map['recognitionDate'] as String?,
      bio: map['bio'] as String? ?? 'Experienced tutor passionate about teaching.',
      hourlyRate: (map['hourlyRate'] as num?)?.toDouble() ?? 500.0,
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      experienceYears: (map['experienceYears'] as num?)?.toInt() ?? 3,
      subjectsHandled: (map['subjectsHandled'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
