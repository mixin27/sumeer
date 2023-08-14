import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/logger/logger.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final Box box;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
  }

  void init() async {
    box = Hive.box(AppConsts.keyPrefs);
    final bool firstTime = box.get(AppConsts.keyFirstTime, defaultValue: true);
    if (firstTime) {
      tLog('First time user.');
      // Navigate to Starter Route
      // await box.put(AppConsts.keyFirstTime, false);

      // if (mounted) context.router.replaceAll([const StarterRoute()]);
    } else {
      tLog('Not a first time user.');
      // Navigate to Main Rotue
      // context.router.replaceAll([const MainRoute()]);
    }
    context.router.replaceAll([const StarterRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetPaths.logo,
          width: 100,
        ),
      ),
    );
  }
}
