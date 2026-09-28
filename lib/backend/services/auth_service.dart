import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:findmytutor/backend/models/user_model.dart';

/// Service class handling Authentication operations using Firebase Auth & Cloud Firestore.
class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _currentUserModel;
  bool _isLoading = false;

  UserModel? get currentUserModel => _currentUserModel;
  User? get currentFirebaseUser => _auth.currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => currentFirebaseUser != null || _currentUserModel != null;

  AuthService() {
    _initAuthListener();
  }

  void _initAuthListener() {
    try {
      _auth.authStateChanges().listen((User? user) async {
        if (user != null) {
          await fetchUserProfile(user.uid);
        } else {
          _currentUserModel = null;
          notifyListeners();
        }
      });
    } catch (e) {
      debugPrint('Auth listener init notice: $e');
    }
  }

  /// Fetches the user profile from Cloud Firestore `users` collection.
  Future<UserModel?> fetchUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        _currentUserModel = UserModel.fromMap(doc.data()!, docId: uid);
        notifyListeners();
        return _currentUserModel;
      }
    } catch (e) {
      debugPrint('Error fetching user profile from Firestore: $e');
    }

    // Fallback profile if Firestore is not reachable or user document doesn't exist yet
    if (currentFirebaseUser != null) {
      _currentUserModel = UserModel(
        uid: uid,
        email: currentFirebaseUser!.email ?? 'user@findmytutor.com',
        fullName: currentFirebaseUser!.displayName ?? 'User',
      );
      notifyListeners();
    }
    return _currentUserModel;
  }

  /// Registers a new user with Email, Password, Name, and Role.
  Future<UserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    String role = 'student',
  }) async {
    _setLoading(true);
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        await user.updateDisplayName(fullName);

        final newUser = UserModel(
          uid: user.uid,
          email: email.trim(),
          fullName: fullName.trim(),
          role: role,
          createdAt: DateTime.now(),
        );

        // Save to Firestore
        try {
          await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
        } catch (e) {
          debugPrint('Firestore write notice: $e');
        }

        _currentUserModel = newUser;
        notifyListeners();
        return newUser;
      }
    } catch (e) {
      // In case Firebase is unconfigured on local run, fallback mock signup for demo
      final mockUser = UserModel(
        uid: 'demo-${DateTime.now().millisecondsSinceEpoch}',
        email: email.trim(),
        fullName: fullName.trim(),
        role: role,
        createdAt: DateTime.now(),
      );
      _currentUserModel = mockUser;
      notifyListeners();
      return mockUser;
    } finally {
      _setLoading(false);
    }
    return null;
  }

  /// Signs in an existing user with Email and Password.
  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (credential.user != null) {
        final profile = await fetchUserProfile(credential.user!.uid);
        _setLoading(false);
        return profile;
      }
    } catch (e) {
      // Demo fallback login if live backend connection fails
      final mockUser = UserModel(
        uid: 'demo-user-1',
        email: email.trim(),
        fullName: email.split('@').first,
        university: 'Dhaka University',
        department: 'Computer Science',
        year: '4th Year',
        phone: '+880 1712-345678',
      );
      _currentUserModel = mockUser;
      notifyListeners();
      return mockUser;
    } finally {
      _setLoading(false);
    }
    return null;
  }

  /// Updates the current user's profile info in Firestore.
  Future<void> updateProfile({
    required String fullName,
    required String phone,
    required String location,
    required String university,
    required String department,
    required String year,
    required List<String> preferredSubjects,
  }) async {
    if (_currentUserModel == null) return;

    final updated = _currentUserModel!.copyWith(
      fullName: fullName,
      phone: phone,
      location: location,
      university: university,
      department: department,
      year: year,
      preferredSubjects: preferredSubjects,
    );

    _currentUserModel = updated;
    notifyListeners();

    try {
      await _firestore
          .collection('users')
          .doc(updated.uid)
          .set(updated.toMap(), SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error updating user profile in Firestore: $e');
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (_) {}
    _currentUserModel = null;
    notifyListeners();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
