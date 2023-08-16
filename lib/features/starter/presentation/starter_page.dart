import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/features/starter/feat_starter.dart';
import 'package:sumeer/shared/shared.dart';

@RoutePage()
class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final currentUser = ref.watch(authRepositoryProvider).currentUser;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      ref.read(resumeRepositoryProvider).clearLocalData();
                      ref
                          .read(selectedResumeTemplateProvider.notifier)
                          .update((state) => resumeTemplates.first);
                      context.router.push(const StarterPersonalDetailRoute());
                    },
                    child: const Text("Get Started"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      context.router.replaceAll([const MainRoute()]);
                    },
                    child: const Text("Skip"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        // context.router.push(const StarterPersonalDetailRoute());
                        if (currentUser == null) return;
                        final resumeData = await getDummyResumeData();
                        ref
                            .read(upsertResumeDataNotifierProvider.notifier)
                            .upsertResumeData(
                              userId: currentUser.uid,
                              resumeData: resumeData,
                            );
                      },
                      child: const Text("Add Dummy Data"),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Step> getSteps(int currentStep) {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Personal Detail"),
        content: const PersonalInformationForm(),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Education"),
        content: const EducationForm(),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Experience"),
        content: const ExperienceForm(),
      ),
    ];
  }
}
