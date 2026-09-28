import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Note: To replace these defaults with your live Firebase credentials,
/// run `flutterfire configure` or replace the placeholder strings below.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.windows:
        return windows;
      default:
        return android;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'demo-api-key-web',
    appId: '1:1234567890:web:demoapp',
    messagingSenderId: '1234567890',
    projectId: 'findmytutor-demo',
    authDomain: 'findmytutor-demo.firebaseapp.com',
    storageBucket: 'findmytutor-demo.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-api-key-android',
    appId: '1:1234567890:android:demoapp',
    messagingSenderId: '1234567890',
    projectId: 'findmytutor-demo',
    storageBucket: 'findmytutor-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'demo-api-key-ios',
    appId: '1:1234567890:ios:demoapp',
    messagingSenderId: '1234567890',
    projectId: 'findmytutor-demo',
    storageBucket: 'findmytutor-demo.appspot.com',
    iosBundleId: 'com.example.findmytutor',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'demo-api-key-windows',
    appId: '1:1234567890:windows:demoapp',
    messagingSenderId: '1234567890',
    projectId: 'findmytutor-demo',
    storageBucket: 'findmytutor-demo.appspot.com',
  );
}
