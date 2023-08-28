import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/shared/shared.dart';

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sumeer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF407BFF)),
        useMaterial3: true,

        // Input
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          fillColor: Color(0xFFF0F0F0),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
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
