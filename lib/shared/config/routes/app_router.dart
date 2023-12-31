import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        // Splash
        AutoRoute(page: SplashRoute.page, path: '/'),

        AutoRoute(page: StarterRoute.page, path: '/starter'),
        AutoRoute(
          page: StarterPersonalDetailRoute.page,
          path: '/personal-information',
        ),
        AutoRoute(
          page: StarterEducationRoute.page,
          path: '/education',
        ),
        AutoRoute(
          page: StarterExperienceRoute.page,
          path: '/experience',
        ),
        AutoRoute(
          page: StarterCompleteRoute.page,
          path: '/complete',
        ),

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

        // Auth
        AutoRoute(page: SignInRoute.page, path: '/auth/sign-in'),
        AutoRoute(page: SignUpRoute.page, path: '/auth/sign-up'),

        //data_input
        AutoRoute(page: DetailRoute.page, path: '/detail_page'),

        //personal_detail
        AutoRoute(
          page: PersonalDetailRoute.page,
          path: '/edit_personal_detail',
        ),
        AutoRoute(page: MyFileRoute.page, path: '/my_file'),
        AutoRoute(page: MyFilesRoute.page, path: '/my-files'),

        AutoRoute(page: PrivacyAndPolicyRoute.page, path: '/privacy-policy'),
      ];
}
