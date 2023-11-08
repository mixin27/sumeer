import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/app_widget.dart';

import 'shared/errors/error_logger.dart';

/// Helper class to initialize services and configure the error handlers
class AppBootstrap {
  /// Create the root widget that should be passed to [runApp].
  Widget createRootWidget({required ProviderContainer container}) {
    // * Register error handlers. For more info, see:
    // * https://docs.flutter.dev/testing/errors
    final errorLogger = container.read(errorLoggerProvider);
    registerErrorHandlers(errorLogger);

    return UncontrolledProviderScope(
      container: container,
      child: AppWidget(),
    );
  }
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };

  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorLogger.logError(error, stack);
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('An error occurred'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Center(
          child: Text(details.toString()),
        ),
      ),
    );
  };
}
