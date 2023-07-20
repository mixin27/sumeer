import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/app_init.dart';
import 'package:sumeer/app_widget.dart';

void main() async {
  await AppInit.init();

  runApp(
    ProviderScope(
      child: AppWidget(),
    ),
  );
}
