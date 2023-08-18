import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/shared.dart';

@RoutePage()
class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 0,
      // ),
      body: Stack(
        children: [
          SvgPicture.asset(
            AssetPaths.background,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetPaths.logo,
                        width: 200,
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SvgPicture.asset(
                                  AssetPaths.starter,
                                  width: MediaQuery.sizeOf(context).width * 0.6,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                AppStrings.loremIpsum,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                AppStrings.loremIpsumParagraph.substring(0, 90),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              context.router.replaceAll([const MainRoute()]);
                            },
                            child: const Text("Skip"),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () async {
                              ref
                                  .read(resumeRepositoryProvider)
                                  .clearLocalData();
                              ref
                                  .read(selectedResumeTemplateProvider.notifier)
                                  .update((state) => resumeTemplates.first);
                              context.router
                                  .push(const StarterPersonalDetailRoute());
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            child: const Text("Get Started"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // List<Step> getSteps(int currentStep) {
  //   return <Step>[
  //     Step(
  //       state: currentStep > 0 ? StepState.complete : StepState.indexed,
  //       isActive: currentStep >= 0,
  //       title: const Text("Personal Detail"),
  //       content: const PersonalInformationForm(),
  //     ),
  //     Step(
  //       state: currentStep > 1 ? StepState.complete : StepState.indexed,
  //       isActive: currentStep >= 1,
  //       title: const Text("Education"),
  //       content: const EducationForm(),
  //     ),
  //     Step(
  //       state: currentStep > 2 ? StepState.complete : StepState.indexed,
  //       isActive: currentStep >= 2,
  //       title: const Text("Experience"),
  //       content: const ExperienceForm(),
  //     ),
  //   ];
  // }
}
