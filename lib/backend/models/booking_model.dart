/// Data model for tutor booking requests.
class BookingModel {
  final String id;
  final String studentId;
  final String studentName;
  final String studentEmail;
  final String tutorId;
  final String tutorName;
  final String subject;
  final String status; // 'pending', 'accepted', 'rejected', 'completed'
  final DateTime requestedDate;
  final String note;
  final DateTime createdAt;

  const BookingModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.studentEmail,
    required this.tutorId,
    required this.tutorName,
    required this.subject,
    this.status = 'pending',
    required this.requestedDate,
    this.note = '',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'studentEmail': studentEmail,
      'tutorId': tutorId,
      'tutorName': tutorName,
      'subject': subject,
      'status': status,
      'requestedDate': requestedDate.toIso8601String(),
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return BookingModel(
      id: docId ?? map['id'] as String? ?? '',
      studentId: map['studentId'] as String? ?? '',
      studentName: map['studentName'] as String? ?? 'Student',
      studentEmail: map['studentEmail'] as String? ?? '',
      tutorId: map['tutorId'] as String? ?? '',
      tutorName: map['tutorName'] as String? ?? 'Tutor',
      subject: map['subject'] as String? ?? 'General',
      status: map['status'] as String? ?? 'pending',
      requestedDate: DateTime.tryParse(map['requestedDate'].toString()) ?? DateTime.now(),
      note: map['note'] as String? ?? '',
      createdAt: DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now(),
    );
  }
}
