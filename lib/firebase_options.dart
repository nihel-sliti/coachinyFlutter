// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDEllThkGWcNgWULTUFvAn1NbLPHyFFros',
    appId: '1:248139743838:web:428ad4a17fde0f8d8eeacf',
    messagingSenderId: '248139743838',
    projectId: 'coatchiny',
    authDomain: 'coatchiny.firebaseapp.com',
    storageBucket: 'coatchiny.firebasestorage.app',
    measurementId: 'G-J915XGLST5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhSu-h6Cp51v36jxiyXWuXVH74BRwr5Co',
    appId: '1:248139743838:android:39a417550e53a2568eeacf',
    messagingSenderId: '248139743838',
    projectId: 'coatchiny',
    storageBucket: 'coatchiny.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBL8O1kAx7Ntd_nsy6hpvWHQTx0dY0c4w4',
    appId: '1:248139743838:ios:d6c32af28ccf36ca8eeacf',
    messagingSenderId: '248139743838',
    projectId: 'coatchiny',
    storageBucket: 'coatchiny.firebasestorage.app',
    iosBundleId: 'com.example.coachiny',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBL8O1kAx7Ntd_nsy6hpvWHQTx0dY0c4w4',
    appId: '1:248139743838:ios:d6c32af28ccf36ca8eeacf',
    messagingSenderId: '248139743838',
    projectId: 'coatchiny',
    storageBucket: 'coatchiny.firebasestorage.app',
    iosBundleId: 'com.example.coachiny',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDEllThkGWcNgWULTUFvAn1NbLPHyFFros',
    appId: '1:248139743838:web:4a0b3133ff7efeb68eeacf',
    messagingSenderId: '248139743838',
    projectId: 'coatchiny',
    authDomain: 'coatchiny.firebaseapp.com',
    storageBucket: 'coatchiny.firebasestorage.app',
    measurementId: 'G-TZZF4MH759',
  );

}