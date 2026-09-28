import 'package:flutter/material.dart';

/// Data model representing a subject category in FindMyTutor.
class SubjectModel {
  final String id;
  final String name;
  final IconData icon;

  const SubjectModel({
    this.id = '',
    required this.name,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    final codePoint = map['iconCodePoint'] as int? ?? Icons.book_outlined.codePoint;
    final fontFamily = map['iconFontFamily'] as String? ?? 'MaterialIcons';
    return SubjectModel(
      id: docId ?? map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Subject',
      icon: IconData(codePoint, fontFamily: fontFamily),
    );
  }
}
