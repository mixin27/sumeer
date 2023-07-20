import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';

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
final vLog = prettyLog.v;
final dLog = prettyLog.d;
final iLog = prettyLog.i;
final eLog = prettyLog.e;
final wtfLog = prettyLog.wtf;
