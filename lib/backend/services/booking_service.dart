import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:findmytutor/backend/models/booking_model.dart';

/// Service managing tutor booking requests in Cloud Firestore.
class BookingService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<BookingModel> _localBookings = [];

  List<BookingModel> get localBookings => List.unmodifiable(_localBookings);

  /// Submits a new tutor booking request to Cloud Firestore.
  Future<BookingModel> createBooking({
    required String studentId,
    required String studentName,
    required String studentEmail,
    required String tutorId,
    required String tutorName,
    required String subject,
    required DateTime requestedDate,
    String note = '',
  }) async {
    final docRef = _firestore.collection('bookings').doc();
    final booking = BookingModel(
      id: docRef.id,
      studentId: studentId,
      studentName: studentName,
      studentEmail: studentEmail,
      tutorId: tutorId,
      tutorName: tutorName,
      subject: subject,
      status: 'pending',
      requestedDate: requestedDate,
      note: note,
      createdAt: DateTime.now(),
    );

    try {
      await docRef.set(booking.toMap());
    } catch (e) {
      debugPrint('Firestore booking save error (fallback to local): $e');
    }

    _localBookings.insert(0, booking);
    notifyListeners();
    return booking;
  }

  /// Streams bookings for a given user (as student or tutor).
  Stream<List<BookingModel>> getUserBookingsStream(String userId, {bool isTutor = false}) {
    final field = isTutor ? 'tutorId' : 'studentId';
    try {
      return _firestore
          .collection('bookings')
          .where(field, isEqualTo: userId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => BookingModel.fromMap(doc.data(), docId: doc.id))
              .toList());
    } catch (e) {
      debugPrint('Stream bookings error: $e');
      return Stream.value(_localBookings);
    }
  }

  /// Updates status of a booking (e.g., 'accepted', 'rejected', 'completed').
  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).update({'status': newStatus});
    } catch (e) {
      debugPrint('Firestore update status notice: $e');
    }

    final index = _localBookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      final old = _localBookings[index];
      _localBookings[index] = BookingModel(
        id: old.id,
        studentId: old.studentId,
        studentName: old.studentName,
        studentEmail: old.studentEmail,
        tutorId: old.tutorId,
        tutorName: old.tutorName,
        subject: old.subject,
        status: newStatus,
        requestedDate: old.requestedDate,
        note: old.note,
        createdAt: old.createdAt,
      );
      notifyListeners();
    }
  }
}
