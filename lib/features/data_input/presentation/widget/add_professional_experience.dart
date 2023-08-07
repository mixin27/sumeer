import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/utils/logger/logger.dart';

class AddProfessionalExperienceForm extends ConsumerStatefulWidget {
  final int? index;
  final Experience? experience;
  const AddProfessionalExperienceForm(this.experience, this.index, {super.key});

  @override
  ConsumerState<AddProfessionalExperienceForm> createState() =>
      _AddProfessionalExperienceFormState();
}

class _AddProfessionalExperienceFormState
    extends ConsumerState<AddProfessionalExperienceForm> {
  final employerController = TextEditingController();
  final jobTitleController = TextEditingController();
  final cityController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    Future.microtask(() {
      // final exp = ref.watch(userExpProvider);
      if (widget.experience != null) {
        employerController.text = widget.experience?.employer?.name ?? '';
        jobTitleController.text = widget.experience?.jobTitle ?? '';
        cityController.text = widget.experience?.city ?? '';
        startDateController.text =
            widget.experience?.startDate.toString() ?? '';
        endDateController.text = widget.experience?.endDate.toString() ?? '';
        descriptionController.text = widget.experience?.description ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    wtfLog('widget experience', widget.experience);
    return DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
                color: Theme.of(context).colorScheme.background),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add Professional Experience",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Expanded(
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextInputFieldWidget(
                          controller: employerController,
                          title: "Employer",
                        ),
                        TextInputFieldWidget(
                          controller: jobTitleController,
                          title: "Job Title",
                        ),
                        TextInputFieldWidget(
                          controller: cityController,
                          title: "City",
                        ),
                        TextInputFieldWidget(
                          controller: startDateController,
                          title: "Start Date",
                        ),
                        TextInputFieldWidget(
                          controller: endDateController,
                          title: "End Date",
                        ),
                        TextInputFieldWidget(
                          controller: descriptionController,
                          title: "Description",
                          hintText: "Describe ypur role & achievements",
                          maxLines: 3,
                        ),
                        SaveBottomSheetWidget(
                          onTap: () {
                            final oldExpScetion =
                                ref.watch(experienceSectionProvider);
                            final oldResumeData = ref.watch(resumeDataProvider);
                            vLog('date time', DateTime.now());
                            Employer employer =
                                Employer(name: employerController.text);
                            Experience experience = Experience(
                              employer: employer,
                              jobTitle: jobTitleController.text,
                              city: cityController.text,
                              // startDate: startDate,
                              startDate: DateTime.now(),
                              endDate: DateTime.now(),
                              description: descriptionController.text,
                            );

                            if (jobTitleController.text.isEmpty) {
                              return Navigator.of(context).pop();
                            } else {
                              if (widget.index != null) {
                                List<Experience> list1 = [];
                                List<Experience> list =
                                    oldExpScetion?.experiences ?? [];
                                for (var element in list) {
                                  list1.add(element);
                                }
                                list1.removeAt(widget.index ?? 0);
                                wLog('updated list remove', list1);

                                list1.insert(widget.index ?? 0, experience);
                                wLog('updated list', list1);
                                ExperienceSection skillSection =
                                    ExperienceSection(
                                        title: '', experiences: list1);

                                ref
                                    .read(experienceSectionProvider.notifier)
                                    .update((state) => skillSection);

                                final newResumeData = oldResumeData?.copyWith(
                                    experience:
                                        ref.watch(experienceSectionProvider));
                                ref
                                    .read(resumeDataProvider.notifier)
                                    .update((state) => newResumeData);
                              } else {
                                List<Experience> experienceList =
                                    oldExpScetion == null
                                        ? [experience]
                                        : [
                                            ...oldExpScetion.experiences,
                                            experience
                                          ];
                                ExperienceSection experienceSection =
                                    ExperienceSection(
                                  title: '',
                                  experiences: experienceList,
                                );
                                ref
                                    .read(experienceSectionProvider.notifier)
                                    .update((state) => experienceSection);

                                final newResumeData = oldResumeData?.copyWith(
                                    experience:
                                        ref.watch(experienceSectionProvider));
                                ref
                                    .read(resumeDataProvider.notifier)
                                    .update((state) => newResumeData);
                              }
                            }

                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        });
  }
}
