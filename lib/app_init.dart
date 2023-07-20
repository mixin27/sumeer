import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_displaymode/flutter_displaymode.dart';

import 'package:sumeer/utils/utils.dart';

class AppInit {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    PlatformDispatcher.instance.onError = (error, stack) {
      eLog(error.toString(), [error, stack]);
      return true;
    };

    /// https://github.com/flutter/flutter/issues/35162
    if (Platform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }
  }
}
