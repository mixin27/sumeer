import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/utils/utils.dart';

final languageLevelProvider = StateProvider<LanguageLevelEnum?>((ref) {
  return null;
});

class AddCertificateForm extends ConsumerStatefulWidget {
  final int? index;
  final Certificate? certificate;
  const AddCertificateForm(this.certificate, this.index, {super.key});

  @override
  ConsumerState<AddCertificateForm> createState() => _AddLanguageFormState();
}

class _AddLanguageFormState extends ConsumerState<AddCertificateForm> {
  final certificateController = TextEditingController();
  final additionalController = TextEditingController();
  final levelController = TextEditingController();
  List<LanguageLevelEnum> languageLevelList = [
    LanguageLevelEnum.beginner,
    LanguageLevelEnum.elementary,
    LanguageLevelEnum.limitedWorking,
    LanguageLevelEnum.highlyProficient,
    LanguageLevelEnum.native,
  ];
  String percentage = '';
  // List<String> skillList = [
  //   'Novice',
  //   'Beginner',
  //   'SkillFull',
  //   'Experienced',
  //   'Expert'
  // ];
  @override
  void initState() {
    super.initState();
    setData();
  }

  void getPercentage(String level) {
    switch (level) {
      case 'Beginner':
        percentage = '0.1';
      case 'Elementary':
        percentage = '0.2';
      case 'Limited working':
        percentage = '0.5';
      case 'Highly proficient':
        percentage = '0.8';
      case 'Native':
        percentage = '1.0';
      default:
        percentage = '0';
    }
  }

  Future<void> setData() async {
    Future.microtask(() {
      // final skill = ref.watch(userSkillProvider);
      if (widget.certificate != null) {
        certificateController.text = widget.certificate?.title ?? '';
        additionalController.text = widget.certificate?.description ?? '';
      } else {
        ref.read(languageLevelProvider.notifier).state =
            LanguageLevelEnum.beginner;
        getPercentage(getLanguageLevel(
          LanguageLevelEnum.beginner,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fLog('widget index ${widget.index}');
    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add certificate',
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
                    TextInputFieldWidget(
                      controller: certificateController,
                      title: 'Certificate',
                    ),
                    TextInputFieldWidget(
                      controller: additionalController,
                      title: 'Additional information',
                    ),
                    // TextInputFieldWidget(
                    //   readOnly: true,
                    //   controller: levelController,
                    //   title: "Select skill level",
                    //   suffixIcon: DropdownButton(
                    //     underline: const SizedBox(),
                    //     icon: const Icon(Icons.keyboard_arrow_down),

                    //     // Array list of items
                    //     items: skillList.map((SkillLevel items) {
                    //       return DropdownMenuItem(
                    //         value: items,
                    //         child: Text(
                    //           getSkillLevel(items),
                    //         ),
                    //       );
                    //     }).toList(),
                    //     // After selecting the desired option,it will
                    //     // change button value to selected value
                    //     onChanged: (val) {
                    //       if (val != null) {
                    //         ref
                    //             .read(skillLevelProvider.notifier)
                    //             .update((state) => val);
                    //         levelController.text = getSkillLevel(val);
                    //       }
                    //       wtfLog('skill level onchange', val);
                    //       wtfLog('skill level providere',
                    //           ref.watch(skillLevelProvider));
                    //     },
                    //   ),
                    // ),
                    // Text(
                    //   "Select language level",
                    //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    //         fontSize: 18,
                    //       ),
                    // ),
                    // DecoratedBox(
                    //   decoration: ShapeDecoration(
                    //     color: Theme.of(context)
                    //         .colorScheme
                    //         .primary
                    //         .withOpacity(0.03),
                    //     shape: RoundedRectangleBorder(
                    //       side: BorderSide(
                    //         color: Theme.of(context)
                    //             .colorScheme
                    //             .onBackground
                    //             .withOpacity(0.2),
                    //         style: BorderStyle.solid,
                    //       ),
                    //       borderRadius: const BorderRadius.all(
                    //         Radius.circular(8),
                    //       ),
                    //     ),
                    //   ),
                    //   child: DropdownButton(
                    //     isExpanded: true,
                    //     underline: const SizedBox(),
                    //     icon: const Icon(Icons.keyboard_arrow_down),
                    //     value: ref.watch(languageLevelProvider),
                    //     padding: const EdgeInsets.symmetric(horizontal: 10),

                    //     // Array list of items
                    //     items: languageLevelList.map((LanguageLevelEnum items) {
                    //       return DropdownMenuItem(
                    //         value: items,
                    //         child: Text(
                    //           getLanguageLevel(items),
                    //         ),
                    //       );
                    //     }).toList(),
                    //     // After selecting the desired option,it will
                    //     // change button value to selected value
                    //     onChanged: (val) {
                    //       if (val != null) {
                    //         ref
                    //             .read(languageLevelProvider.notifier)
                    //             .update((state) => val);
                    //         levelController.text = getLanguageLevel(val);
                    //         getPercentage(getLanguageLevel(val));
                    //       }
                    //       fLog('skill level onchange $val');
                    //     },
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    SaveBottomSheetWidget(
                      onTap: () {
                        // final oldLanguageSection =
                        //     ref.watch(languageSectionProvider);
                        final oldResumeData = ref.watch(resumeDataProvider);
                        final oldCertificateSection =
                            oldResumeData?.certificate?.certificates ?? [];
                        Certificate language = Certificate(
                          title: certificateController.text,
                          description: additionalController.text,
                        );

                        if (certificateController.text.isEmpty) {
                          return Navigator.of(context).pop();
                        } else {
                          if (widget.index != null) {
                            List<Certificate> list1 = [];
                            List<Certificate> list = oldCertificateSection;
                            for (var element in list) {
                              list1.add(element);
                            }
                            list1.removeAt(widget.index ?? 0);

                            list1.insert(widget.index ?? 0, language);
                            CertificateSection languageSection =
                                CertificateSection(
                                    title: '', certificates: list1);

                            ref
                                .read(certificateSectionProvider.notifier)
                                .update((state) => languageSection);

                            final newResumeData = oldResumeData?.copyWith(
                                certificate:
                                    ref.watch(certificateSectionProvider));
                            ref
                                .read(resumeDataProvider.notifier)
                                .update((state) => newResumeData);
                          } else {
                            List<Certificate> certificateList =
                                oldCertificateSection.isEmpty
                                    ? [language]
                                    : [...oldCertificateSection, language];

                            CertificateSection certificateSection =
                                CertificateSection(
                              title: '',
                              certificates: certificateList,
                            );

                            ref
                                .read(certificateSectionProvider.notifier)
                                .update((state) => certificateSection);

                            final newResumeData = oldResumeData?.copyWith(
                              certificate:
                                  ref.watch(certificateSectionProvider),
                            );
                            ref
                                .read(resumeDataProvider.notifier)
                                .update((state) => newResumeData);
                          }
                        }
                        tLog(ref
                                .watch(resumeDataProvider)
                                ?.certificate
                                ?.certificates
                                .first ??
                            []);

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
