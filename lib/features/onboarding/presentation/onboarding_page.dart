import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_animation/onboarding_animation.dart';
import 'package:sumeer/shared/shared.dart';

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
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            ),
            _GetCardsContent(
              image: AssetPaths.onborading2,
              cardContent:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            ),
            _GetCardsContent(
              image: AssetPaths.onborading3,
              cardContent:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
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

class _GetCardsContent extends StatelessWidget {
  final String image, cardContent;

  const _GetCardsContent({
    Key? key,
    this.image = '',
    this.cardContent = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              cardContent,
              // style: GoogleFonts.pacifico(fontSize: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}
