import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/shared.dart';

@RoutePage()
class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                'Resume Builder App',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Your Dream Job Awaits - Let's Shape Your CV Together.",
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
                              final box = Hive.box(AppConsts.keyPrefs);
                              await box.put(AppConsts.keyFirstTime, false);

                              if (context.mounted) {
                                context.router.replaceAll([const MainRoute()]);
                              }
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
}
