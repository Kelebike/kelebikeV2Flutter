// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAOMRAffP9SOCAak0Sre_ICS1KOG1wn-Ug',
    appId: '1:143823499442:web:536815bd39df3d526f59ab',
    messagingSenderId: '143823499442',
    projectId: 'kelebike-v2',
    authDomain: 'kelebike-v2.firebaseapp.com',
    storageBucket: 'kelebike-v2.appspot.com',
    measurementId: 'G-JJMX2LN326',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0fCw5Eq5PMYdVkDIvFA6ieAyArEhxMHk',
    appId: '1:143823499442:android:fca31614fae84c496f59ab',
    messagingSenderId: '143823499442',
    projectId: 'kelebike-v2',
    storageBucket: 'kelebike-v2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAx65h_XveVqy1uLXZ7yGA9V1Xu918wlu8',
    appId: '1:143823499442:ios:5c156b912fb0cffe6f59ab',
    messagingSenderId: '143823499442',
    projectId: 'kelebike-v2',
    storageBucket: 'kelebike-v2.appspot.com',
    iosClientId: '143823499442-ng6vgr9cgfs9q5gk6n50q5g86lnog8om.apps.googleusercontent.com',
    iosBundleId: 'com.example.kelebikev2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAx65h_XveVqy1uLXZ7yGA9V1Xu918wlu8',
    appId: '1:143823499442:ios:5c156b912fb0cffe6f59ab',
    messagingSenderId: '143823499442',
    projectId: 'kelebike-v2',
    storageBucket: 'kelebike-v2.appspot.com',
    iosClientId: '143823499442-ng6vgr9cgfs9q5gk6n50q5g86lnog8om.apps.googleusercontent.com',
    iosBundleId: 'com.example.kelebikev2',
  );
}
