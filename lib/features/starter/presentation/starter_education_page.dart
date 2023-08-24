import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/features.dart';
import 'package:sumeer/features/starter/feat_starter.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/logger/logger.dart';
import 'package:sumeer/widgets/widgets.dart';

@RoutePage()
class StarterEducationPage extends HookConsumerWidget {
  const StarterEducationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showEducation = ref.watch(showEducationFormProvider);
    final formKey = ref.watch(educationFormKeyProvider);

    final educations = ref.watch(educationsProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: SvgImage(AssetPaths.background),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Education',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: educations.isNotEmpty
                        ? null
                        : () {
                            final personalDetail =
                                ref.watch(personalDetailProvider);
                            tLog("PersonalDetail => $personalDetail");
                            tLog("Educations => $educations");

                            context.router.push(const StarterExperienceRoute());
                          },
                    child: const Text('Skip'),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                AppStrings.loremIpsumParagraph.substring(0, 90),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!showEducation)
                    ElevatedButton.icon(
                      onPressed: () {
                        ref
                            .read(showEducationFormProvider.notifier)
                            .update((state) => true);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      icon: const Icon(Icons.add_outlined),
                      label: const Text('Add Education'),
                    ),
                  if (showEducation) ...[
                    OutlinedButton.icon(
                      onPressed: () {
                        ref
                            .read(showEducationFormProvider.notifier)
                            .update((state) => false);
                      },
                      style: FilledButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      icon: const Icon(Icons.close_outlined),
                      label: const Text('Cancel'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final startDate = ref.watch(eduStartDateProvider);
                          final endDate = ref.watch(eduEndDateProvider);
                          final degree = ref.watch(eduDegreeProvider);
                          final school = ref.watch(eduSchoolProvider);
                          final city = ref.watch(eduCityProvider);
                          final country = ref.watch(eduCountryProvider);
                          final description = ref.watch(eduDescriptionProvider);
                          final isPresent = ref.watch(eduIsPresentProvider);

                          final education = Education(
                            degree: degree,
                            school: school,
                            city: city,
                            country: country,
                            description: description,
                            startDate: startDate,
                            endDate: isPresent ? null : endDate,
                            isPresent: isPresent,
                          );

                          ref
                              .read(educationsProvider.notifier)
                              .update((state) => [...state, education]);
                          ref
                              .read(showEducationFormProvider.notifier)
                              .update((state) => false);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      icon: const Icon(Icons.check_outlined),
                      label: const Text('Save'),
                    ),
                  ],
                ],
              ),
              if (showEducation)
                const Column(
                  children: [
                    SizedBox(height: 20),
                    EducationForm(),
                  ],
                ),
              const SizedBox(height: 20),
              Column(
                children: List.generate(
                  educations.length,
                  (index) {
                    final education = educations[index];
                    return ListTile(
                      title: Text(education.degree ?? ""),
                      subtitle: Text(education.school ?? ""),
                      trailing: IconButton(
                        onPressed: () {
                          ref.read(educationsProvider.notifier).update((state) {
                            final toRemove = state[index];
                            final items = state
                                .where((element) => element != toRemove)
                                .toList();
                            return items;
                          });
                        },
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 20),
                  FilledButton(
                    onPressed: showEducation
                        ? null
                        : () {
                            final personalDetail =
                                ref.watch(personalDetailProvider);
                            tLog("PersonalDetail => $personalDetail");
                            tLog("Educations => $educations");

                            context.router.push(const StarterExperienceRoute());
                          },
                    style: FilledButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text("Next"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
