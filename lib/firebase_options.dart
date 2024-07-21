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
    apiKey: 'AIzaSyCsmRrMHN4479eOGfvyTsnd2Vaj8osNa2Q',
    appId: '1:396961921181:web:0ea8d4a4eaab5f6a65bc74',
    messagingSenderId: '396961921181',
    projectId: 'major-project-45dd9',
    authDomain: 'major-project-45dd9.firebaseapp.com',
    storageBucket: 'major-project-45dd9.appspot.com',
    measurementId: 'G-EV68RLFJJ0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdgO2X2DiCDOfqCALCabPgOJZj314LtzA',
    appId: '1:396961921181:android:a1bfa6692a379da965bc74',
    messagingSenderId: '396961921181',
    projectId: 'major-project-45dd9',
    storageBucket: 'major-project-45dd9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChso6SzLqvSwJnaeiovltm0zgq1Q753Q0',
    appId: '1:396961921181:ios:711e616fb577571465bc74',
    messagingSenderId: '396961921181',
    projectId: 'major-project-45dd9',
    storageBucket: 'major-project-45dd9.appspot.com',
    iosBundleId: 'com.example.upSkill1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChso6SzLqvSwJnaeiovltm0zgq1Q753Q0',
    appId: '1:396961921181:ios:123acadbd841b5ca65bc74',
    messagingSenderId: '396961921181',
    projectId: 'major-project-45dd9',
    storageBucket: 'major-project-45dd9.appspot.com',
    iosBundleId: 'com.example.upSkill1.RunnerTests',
  );
}