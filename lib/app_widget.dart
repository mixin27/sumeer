import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/shared/shared.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sumeer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF407BFF)),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          AppRouterObserver(),
          AutoRouteObserver(),
        ],
      ),
    );
  }
}
