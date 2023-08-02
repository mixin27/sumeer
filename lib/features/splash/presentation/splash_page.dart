import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/shared/shared.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   init();
  // }

  // void init() async {
  //   await Future.delayed(const Duration(milliseconds: 3000));

  //   if (mounted) context.router.replaceAll([const DetailRoute()]);
  // }
  //   if (mounted) context.router.replaceAll([const SignInRoute()]);
  // }

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
