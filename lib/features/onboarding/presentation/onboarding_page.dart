import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onboarding_animation/onboarding_animation.dart';

import 'package:sumeer/shared/shared.dart';

import '../onboarding_feat.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnBoarding Animation',
      home: OnBoardingAnimationExample(),
    );
  }
}

class OnBoardingAnimationExample extends StatefulWidget {
  const OnBoardingAnimationExample({Key? key}) : super(key: key);

  @override
  State<OnBoardingAnimationExample> createState() =>
      _OnBoardingAnimationExampleState();
}

class _OnBoardingAnimationExampleState
    extends State<OnBoardingAnimationExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OnBoardingAnimation(
          controller: PageController(initialPage: 1),
          pages: const [
            _GetCardsContent(
              image: AssetPaths.onborading1,
              cardContent:
                  'Create your CV/ Resume easily with our free builder and professional templates.',
            ),
            _GetCardsContent(
              image: AssetPaths.onborading2,
              cardContent:
                  'Create your CV/ Resume easily with our free builder and professional templates.',
            ),
            _GetCardsContent(
              isShowButton: true,
              image: AssetPaths.onborading3,
              cardContent:
                  'Create your CV/ Resume easily with our free builder and professional templates.',
            ),
          ],
          indicatorDotHeight: 7.0,
          indicatorDotWidth: 7.0,
          indicatorType: IndicatorType.expandingDots,
          indicatorPosition: IndicatorPosition.bottomCenter,
          indicatorSwapType: SwapType.normal,
        ),
      ),
    );
  }
}

class _GetCardsContent extends ConsumerWidget {
  final String image, cardContent;
  final bool isShowButton;

  const _GetCardsContent({
    Key? key,
    this.image = '',
    this.cardContent = '',
    this.isShowButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              child: Image.asset(image),
            ),
            Text(
              textAlign: TextAlign.center,
              'Build a Professional Resume \n for Free',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              textAlign: TextAlign.center,
              cardContent,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            isShowButton
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(88, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                    onPressed: () {
                      ref
                          .read(onboardingNotifierProvider.notifier)
                          .markAsShown(toMain: false);
                    },
                    child: Text(
                      'Get Started',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  )
                : const SizedBox(),
            isShowButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
