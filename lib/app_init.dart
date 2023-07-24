import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import 'package:sumeer/shared/shared.dart';

class AppInit {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// Firebase initialization
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // FirebaseCrashlytics
    if (kReleaseMode) {
      // Pass all uncaught "fatal" errors from the framework to Crashlytics
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    /// https://github.com/flutter/flutter/issues/35162
    if (Platform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }
  }
}
