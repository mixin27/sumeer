import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/utils/utils.dart';

class AddEducationForm extends ConsumerStatefulWidget {
  final int? index;
  final Education? education;
  const AddEducationForm(this.education, this.index, {super.key});

  @override
  ConsumerState<AddEducationForm> createState() => _AddEducationFormState();
}

class _AddEducationFormState extends ConsumerState<AddEducationForm> {
  final degreeController = TextEditingController();
  final schoolController = TextEditingController();
  final cityController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    Future.microtask(() {
      // final skill = ref.watch(userSkillProvider);
      if (widget.education != null) {
        degreeController.text = widget.education?.degree ?? '';
        schoolController.text = widget.education?.school ?? '';
        cityController.text = widget.education?.city.toString() ?? '';
        startDateController.text = widget.education?.startDate.toString() ?? '';
        endDateController.text = widget.education?.endDate.toString() ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    wLog('index number', 'called');
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
                  "Add Education",
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
                          controller: degreeController,
                          title: "Degree",
                        ),
                        TextInputFieldWidget(
                          controller: schoolController,
                          title: "School",
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
                        SaveBottomSheetWidget(
                          onTap: () {
                            final oldEduSection =
                                ref.watch(educationSectionProvider);
                            final oldResumeData = ref.watch(resumeDataProvider);
                            Education education = Education(
                              degree: degreeController.text,
                              school: schoolController.text,
                              city: cityController.text,
                              startDate: DateTime.now(),
                              endDate: DateTime.now(),
                            );
                            if (degreeController.text.isEmpty &&
                                schoolController.text.isEmpty) {
                              return Navigator.of(context).pop();
                            } else {
                              if (widget.index != null) {
                                List<Education> list1 = [];
                                List<Education> list =
                                    oldEduSection?.educations ?? [];
                                for (var element in list) {
                                  list1.add(element);
                                }
                                list1.removeAt(widget.index ?? 0);
                                wLog('updated list remove', list1);

                                list1.insert(widget.index ?? 0, education);
                                wLog('updated list', list1);
                                EducationSection educationSection =
                                    EducationSection(
                                        title: '', educations: list1);

                                ref
                                    .read(educationSectionProvider.notifier)
                                    .update((state) => educationSection);

                                final newResumeData = oldResumeData?.copyWith(
                                    education:
                                        ref.watch(educationSectionProvider));
                                ref
                                    .read(resumeDataProvider.notifier)
                                    .update((state) => newResumeData);
                              } else {
                                List<Education> eduList = oldEduSection == null
                                    ? [education]
                                    : [...oldEduSection.educations, education];
                                EducationSection eduScetion = EducationSection(
                                  title: '',
                                  educations: eduList,
                                );
                                ref
                                    .read(educationSectionProvider.notifier)
                                    .update((state) => eduScetion);
                                // ResumeData resumeData = ResumeData(
                                //     education: ref.watch(educationSectionProvider));
                                final newResumeData = oldResumeData?.copyWith(
                                  education:
                                      ref.watch(educationSectionProvider),
                                );
                                ref
                                    .read(resumeDataProvider.notifier)
                                    .update((state) => newResumeData);
                                // ref
                                //     .read(resumeDataProvider.notifier)
                                //     .update((state) => state);
                              }
                            }

                            Navigator.pop(context);
                          },
                        )
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
