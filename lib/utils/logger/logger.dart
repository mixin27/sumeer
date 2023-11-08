import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';
import 'package:flutter_logs/flutter_logs.dart';

final prettyLog = Logger(
  filter:
      (kDebugMode || kProfileMode) ? DevelopmentFilter() : ProductionFilter(),
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

final wLog = prettyLog.w;
final tLog = prettyLog.t;
final dLog = prettyLog.d;
final iLog = prettyLog.i;
final eLog = prettyLog.e;
final fLog = prettyLog.f;

const flogI = FlutterLogs.logInfo;
const flogW = FlutterLogs.logWarn;
const flogE = FlutterLogs.logError;
const flogEtrace = FlutterLogs.logErrorTrace;
const flogThis = FlutterLogs.logThis;
const flogToFile = FlutterLogs.logToFile;
