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
    apiKey: 'AIzaSyCN7t_iA6nQINdRS69DoT6JitXurNA9UgA',
    appId: '1:604374980802:web:dc5c1eeda1504b6bc5435b',
    messagingSenderId: '604374980802',
    projectId: 'sumeer-flutter',
    authDomain: 'sumeer-flutter.firebaseapp.com',
    storageBucket: 'sumeer-flutter.appspot.com',
    measurementId: 'G-CETEQ42JMC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqRccira3mYvuhfdOkJcfD5kiRYiChPI0',
    appId: '1:604374980802:android:0f03a30f20aad05cc5435b',
    messagingSenderId: '604374980802',
    projectId: 'sumeer-flutter',
    storageBucket: 'sumeer-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgToUhPvEwE5yA4IJv2uiP5ClpJ0jmf5A',
    appId: '1:604374980802:ios:f838003518d7f4a4c5435b',
    messagingSenderId: '604374980802',
    projectId: 'sumeer-flutter',
    storageBucket: 'sumeer-flutter.appspot.com',
    iosClientId: '604374980802-smlmgdhn17p8oshdkh7diri6qfgt33s3.apps.googleusercontent.com',
    iosBundleId: 'com.systematic.sumeer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgToUhPvEwE5yA4IJv2uiP5ClpJ0jmf5A',
    appId: '1:604374980802:ios:92fe8b3765f2628ac5435b',
    messagingSenderId: '604374980802',
    projectId: 'sumeer-flutter',
    storageBucket: 'sumeer-flutter.appspot.com',
    iosClientId: '604374980802-27u990gliaeb0lfpu9bljoqvo4danv66.apps.googleusercontent.com',
    iosBundleId: 'com.systematic.sumeer.RunnerTests',
  );
}
