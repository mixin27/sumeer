import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/shared/shared.dart';

// final initializationProvider = FutureProvider<Unit>((ref) async {
//   await ref.read(onboardingNotifierProvider.notifier).checkOnboardingStatus();
//   return unit;
// });

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen(initializationProvider, (previous, next) {});
    // ref.listen<OnboardingState>(
    //   onboardingNotifierProvider,
    //   (previous, state) {
    //     state.maybeWhen(
    //       orElse: () {},
    //       done: (toMain) {
    //         dLog('toMain : $toMain');
    //         // if (toMain != null && toMain) {
    //         Future.delayed(Duration(seconds: toMain == true ? 2 : 0))
    //             .then((value) {
    //           _appRouter.pushAndPopUntil(
    //             const MainRoute(),
    //             predicate: (_) => false,
    //           );
    //         });
    //         // }
    //       },
    //       notYet: () {
    //         dLog('toMain : notYet state');
    //         Future.delayed(const Duration(seconds: 3)).then(
    //           (value) => _appRouter.pushAndPopUntil(
    //             const OnboardingRoute(),
    //             predicate: (_) => false,
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
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
