import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/app_bootstrap.dart';
import 'package:sumeer/shared/shared.dart';

import 'shared/errors/async_error_logger.dart';

/// Extension methods specific for the main project configuration
extension AppBootstrapMain on AppBootstrap {
  /// Creates the top-level [ProviderContainer] by overriding providers with fake
  /// repositories only. This is useful for testing purposes and for running the
  /// app with a "fake" backend.
  ///
  /// Note: all repositories needed by the app can be accessed via providers.
  /// Some of these providers throw an [UnimplementedError] by default.
  ///
  /// Example:
  /// ```dart
  /// @Riverpod(keepAlive: true)
  /// LocalCartRepository localCartRepository(LocalCartRepositoryRef ref) {
  ///   throw UnimplementedError();
  /// }
  /// ```
  ///
  /// As a result, this method does two things:
  /// - create and configure the repositories as desired
  /// - override the default implementations with a list of "overrides"
  Future<ProviderContainer> createMainProviderContainer({
    List<Override> overrides = const [],
  }) async {
    final container = ProviderContainer(
      overrides: overrides,
      observers: [AsyncErrorLogger()],
    );

    return container;
  }

  Future<void> setupHiveFlutter() async {
    // Initialize hive
    await Hive.initFlutter();
    // Open the prefs box
    await Hive.openBox(AppConsts.keyPrefs);
  }

  Future<void> setupFlutterLogs() async {
    await FlutterLogs.initLogs(
      logLevelsEnabled: [
        LogLevel.INFO,
        LogLevel.WARNING,
        LogLevel.ERROR,
        LogLevel.SEVERE,
      ],
      directoryStructure: DirectoryStructure.FOR_DATE,
      timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
      logFileExtension: LogFileExtension.TXT,
      logsExportDirectoryName: 'Exported',
      logsWriteDirectoryName: 'MyLogs',
      debugFileOperations: true,
      isDebuggable: true,
    );
  }

  Future<void> setupRefereshRate() async {
    // https://github.com/flutter/flutter/issues/35162
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        await FlutterDisplayMode.setHighRefreshRate();
      }
    }
  }
}
