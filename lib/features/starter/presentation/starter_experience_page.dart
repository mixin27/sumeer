import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/features.dart';
import 'package:sumeer/features/starter/feat_starter.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
import 'package:sumeer/widgets/svg_image_provider.dart';

@RoutePage()
class StarterExperiencePage extends HookConsumerWidget {
  const StarterExperiencePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showExperience = ref.watch(showExperienceFormProvider);
    final formKey = ref.watch(experienceFormKeyProvider);

    final experiences = ref.watch(experiencesProvider);

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
                    'Experience',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: experiences.isNotEmpty
                        ? null
                        : () {
                            final personalDetail =
                                ref.watch(personalDetailProvider);
                            final educations = ref.watch(educationsProvider);

                            final starterResumeData = ResumeData(
                              personalDetail: personalDetail,
                              education: educations.isNotEmpty
                                  ? EducationSection(
                                      educations: educations,
                                    )
                                  : null,
                              experience: experiences.isNotEmpty
                                  ? ExperienceSection(
                                      experiences: experiences,
                                    )
                                  : null,
                            );
                            tLog('StarterResumeData => $starterResumeData');
                            ref
                                .read(starterResumeDataProvider.notifier)
                                .update((state) => starterResumeData);

                            context.router.push(const StarterCompleteRoute());
                          },
                    child: const Text('Skip'),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Your work history showcases your accomplishments. Add your previous job roles, starting with the most recent.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!showExperience)
                    ElevatedButton.icon(
                      onPressed: () {
                        ref
                            .read(showExperienceFormProvider.notifier)
                            .update((state) => true);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      icon: const Icon(Icons.add_outlined),
                      label: const Text('Add Experience'),
                    ),
                  if (showExperience) ...[
                    OutlinedButton.icon(
                      onPressed: () {
                        ref
                            .read(showExperienceFormProvider.notifier)
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
                          final startDate = ref.watch(expStartDateProvider);
                          final endDate = ref.watch(expEndDateProvider);
                          final employerName = ref.watch(expEmployerProvider);
                          final jobTitle = ref.watch(expJobTitleProvider);
                          final city = ref.watch(expCityProvider);
                          final country = ref.watch(expCountryProvider);
                          final description = ref.watch(expDescriptionProvider);
                          final isPresent = ref.watch(expIsPresentProvider);

                          final employer = Employer(name: employerName ?? '');

                          final experience = Experience(
                            employer: employer,
                            jobTitle: jobTitle ?? '',
                            city: city,
                            country: country,
                            description: description,
                            startDate: startDate,
                            endDate: isPresent ? null : endDate,
                            isPresent: isPresent,
                          );

                          ref
                              .read(experiencesProvider.notifier)
                              .update((state) => [...state, experience]);
                          ref
                              .read(showExperienceFormProvider.notifier)
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
              if (showExperience)
                const Column(
                  children: [
                    SizedBox(height: 20),
                    ExperienceForm(),
                  ],
                ),
              const SizedBox(height: 20),
              Column(
                children: List.generate(
                  experiences.length,
                  (index) {
                    final experience = experiences[index];
                    return ListTile(
                      title: Text(experience.employer?.name ?? ''),
                      subtitle: Text(experience.jobTitle),
                      trailing: IconButton(
                        onPressed: () {
                          ref
                              .read(experiencesProvider.notifier)
                              .update((state) {
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
                    onPressed: showExperience
                        ? null
                        : () {
                            final personalDetail =
                                ref.watch(personalDetailProvider);
                            final educations = ref.watch(educationsProvider);

                            final starterResumeData = ResumeData(
                              personalDetail: personalDetail,
                              education: educations.isNotEmpty
                                  ? EducationSection(
                                      educations: educations,
                                    )
                                  : null,
                              experience: experiences.isNotEmpty
                                  ? ExperienceSection(
                                      experiences: experiences,
                                    )
                                  : null,
                            );
                            tLog('StarterResumeData => $starterResumeData');
                            ref
                                .read(starterResumeDataProvider.notifier)
                                .update((state) => starterResumeData);

                            context.router.push(const StarterCompleteRoute());
                          },
                    style: FilledButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Complete'),
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
