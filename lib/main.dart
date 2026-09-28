import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:findmytutor/app.dart';
import 'package:findmytutor/backend/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization notice: $e');
  }
  runApp(const FindMyTutorApp());
}
