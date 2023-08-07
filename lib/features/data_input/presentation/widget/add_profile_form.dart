import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';

class AddProfileForm extends ConsumerStatefulWidget {
  const AddProfileForm({super.key});

  @override
  ConsumerState<AddProfileForm> createState() => _AddProfileFormState();
}

class _AddProfileFormState extends ConsumerState<AddProfileForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            color: Theme.of(context).colorScheme.background),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Create Profile",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const TextInputFieldWidget(
                      title: "Text",
                      hintText:
                          "Introduce yourself by pitching your skill & explaining how they can be of value to a company",
                      maxLines: 4,
                    ),
                    SaveBottomSheetWidget(
                      onTap: () {
                        // final oldProfileSection = ref.watch(profileProvider);
                        // final oldResumeData = ref.watch(resumeDataProvider);
                        // ProfileSection education = Prof(
                        //   degree: degreeController.text,
                        //   school: schoolController.text,
                        //   city: cityController.text,
                        //   startDate: selectedStartDate,
                        //   endDate: selectedEndDate,
                        // );
                        // if (degreeController.text.isEmpty &&
                        //     schoolController.text.isEmpty) {
                        //   return Navigator.of(context).pop();
                        // } else {
                        //   if (widget.index != null) {
                        //     List<Education> list1 = [];
                        //     List<Education> list =
                        //         oldEduSection?.educations ?? [];
                        //     for (var element in list) {
                        //       list1.add(element);
                        //     }
                        //     list1.removeAt(widget.index ?? 0);
                        //     wLog('updated list remove', list1);

                        //     list1.insert(widget.index ?? 0, education);
                        //     wLog('updated list', list1);
                        //     EducationSection educationSection =
                        //         EducationSection(title: '', educations: list1);

                        //     ref
                        //         .read(educationSectionProvider.notifier)
                        //         .update((state) => educationSection);

                        //     final newResumeData = oldResumeData?.copyWith(
                        //         education: ref.watch(educationSectionProvider));
                        //     ref
                        //         .read(resumeDataProvider.notifier)
                        //         .update((state) => newResumeData);
                        //   } else {
                        //     List<Education> eduList = oldEduSection == null
                        //         ? [education]
                        //         : [...oldEduSection.educations, education];
                        //     EducationSection eduScetion = EducationSection(
                        //       title: '',
                        //       educations: eduList,
                        //     );
                        //     ref
                        //         .read(educationSectionProvider.notifier)
                        //         .update((state) => eduScetion);
                        //     // ResumeData resumeData = ResumeData(
                        //     //     education: ref.watch(educationSectionProvider));
                        //     final newResumeData = oldResumeData?.copyWith(
                        //       education: ref.watch(educationSectionProvider),
                        //     );
                        //     ref
                        //         .read(resumeDataProvider.notifier)
                        //         .update((state) => newResumeData);
                        //     // ref
                        //     //     .read(resumeDataProvider.notifier)
                        //     //     .update((state) => state);
                        //   }
                        // }

                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
