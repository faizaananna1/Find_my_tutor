/// Data model representing a registered user in FindMyTutor (Student or Tutor).
class UserModel {
  final String uid;
  final String email;
  final String fullName;
  final String phone;
  final String location;
  final String role; // 'student' or 'tutor'
  final String university;
  final String department;
  final String year;
  final List<String> preferredSubjects;
  final String? photoUrl;
  final DateTime? createdAt;

  const UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    this.phone = '',
    this.location = 'Dhaka, Bangladesh',
    this.role = 'student',
    this.university = '',
    this.department = '',
    this.year = '',
    this.preferredSubjects = const [],
    this.photoUrl,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'location': location,
      'role': role,
      'university': university,
      'department': department,
      'year': year,
      'preferredSubjects': preferredSubjects,
      'photoUrl': photoUrl,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return UserModel(
      uid: docId ?? map['uid'] as String? ?? '',
      email: map['email'] as String? ?? '',
      fullName: map['fullName'] as String? ?? 'User',
      phone: map['phone'] as String? ?? '',
      location: map['location'] as String? ?? 'Dhaka, Bangladesh',
      role: map['role'] as String? ?? 'student',
      university: map['university'] as String? ?? '',
      department: map['department'] as String? ?? '',
      year: map['year'] as String? ?? '',
      preferredSubjects: (map['preferredSubjects'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      photoUrl: map['photoUrl'] as String?,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
    );
  }

  UserModel copyWith({
    String? fullName,
    String? phone,
    String? location,
    String? university,
    String? department,
    String? year,
    List<String>? preferredSubjects,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      role: role,
      university: university ?? this.university,
      department: department ?? this.department,
      year: year ?? this.year,
      preferredSubjects: preferredSubjects ?? this.preferredSubjects,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt,
    );
  }
}
