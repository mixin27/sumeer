import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        // Splash
        AutoRoute(page: SplashRoute.page, path: '/'),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(
          page: MainRoute.page,
          path: '/main',
          children: [
            // Home
            /// sub route should not start wiht "/"
            AutoRoute(page: HomeRoute.page, path: 'home'),
            AutoRoute(page: TemplatesRoute.page, path: 'templates'),
            AutoRoute(page: AccountRoute.page, path: 'account'),
          ],
        ),

        // Resume
        AutoRoute(page: TemplateListingRoute.page, path: '/template_list'),
        AutoRoute(page: ResumePreviewRoute.page, path: '/resume/preview'),
      ];
}
