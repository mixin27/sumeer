import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';

final skillLevelProvider = StateProvider<SkillLevelEnum?>((ref) {
  return null;
});

class AddSkillForm extends ConsumerStatefulWidget {
  final int? index;
  final Skill? skill;
  const AddSkillForm(this.skill, this.index, {super.key});

  @override
  ConsumerState<AddSkillForm> createState() => _AddSkillFormState();
}

class _AddSkillFormState extends ConsumerState<AddSkillForm> {
  final skillController = TextEditingController();
  final infoController = TextEditingController();
  final levelController = TextEditingController();
  List<SkillLevelEnum> skillList = [
    SkillLevelEnum.novice,
    SkillLevelEnum.beginner,
    SkillLevelEnum.skillfull,
    SkillLevelEnum.experienced,
    SkillLevelEnum.expert,
  ];
  String percentage = "";

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    Future.microtask(() {
      // final skill = ref.watch(userSkillProvider);

      if (widget.skill != null) {
        setState(() {
          skillController.text = widget.skill?.name ?? '';
          infoController.text = widget.skill?.information ?? '';
          ref.read(skillLevelProvider.notifier).state = widget.skill!.level;
          levelController.text = getSkillLevel(
            widget.skill!.level ?? SkillLevelEnum.novice,
          );
          getPercentage(getSkillLevel(
            widget.skill!.level ?? SkillLevelEnum.novice,
          ));
        });
      } else {
        setState(() {
          ref.read(skillLevelProvider.notifier).state = SkillLevelEnum.novice;
          levelController.text = getSkillLevel(
            SkillLevelEnum.novice,
          );
          getPercentage(getSkillLevel(
            SkillLevelEnum.novice,
          ));
        });
      }
    });
  }

  void getPercentage(String level) {
    switch (level) {
      case "Novice":
        percentage = "0.1";
      case "Beginner":
        percentage = "0.2";
      case "Skill Full":
        percentage = "0.5";
      case "Experienced":
        percentage = "0.8";
      case "Expert":
        percentage = "1.0";
      default:
        percentage = "0";
    }
  }

  @override
  Widget build(BuildContext context) {
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
                "Add Skill",
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
                      controller: skillController,
                      title: "Skill",
                    ),
                    TextInputFieldWidget(
                      controller: infoController,
                      title: "Information/ Sub-skills",
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
                    Text(
                      "Select skill level",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                          ),
                    ),
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.03),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.2),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: ref.watch(skillLevelProvider),
                        padding: const EdgeInsets.symmetric(horizontal: 10),

                        // Array list of items
                        items: skillList.map((SkillLevelEnum items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              getSkillLevel(items),
                            ),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (val) {
                          if (val != null) {
                            ref
                                .read(skillLevelProvider.notifier)
                                .update((state) => val);
                            levelController.text = getSkillLevel(val);
                            getPercentage(getSkillLevel(val));
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SaveBottomSheetWidget(
                      onTap: () {
                        final oldResumeData = ref.watch(resumeDataProvider);
                        // final oldSkillSection = ref.watch(skillSectionProvider);
                        final oldSkillSection =
                            oldResumeData?.skill?.skills ?? [];

                        Skill skill = Skill(
                            name: skillController.text,
                            information: infoController.text,
                            level: ref.watch(skillLevelProvider),
                            percentage: double.parse(percentage));

                        if (skillController.text.isEmpty) {
                          return Navigator.of(context).pop();
                        } else {
                          if (widget.index != null) {
                            List<Skill> list1 = [];
                            List<Skill> list = oldSkillSection;
                            for (var element in list) {
                              list1.add(element);
                            }
                            list1.removeAt(widget.index ?? 0);

                            list1.insert(widget.index ?? 0, skill);
                            SkillSection skillSection =
                                SkillSection(title: '', skills: list1);

                            ref
                                .read(skillSectionProvider.notifier)
                                .update((state) => skillSection);

                            final newResumeData = oldResumeData?.copyWith(
                                skill: ref.watch(skillSectionProvider));
                            ref
                                .read(resumeDataProvider.notifier)
                                .update((state) => newResumeData);
                          } else {
                            List<Skill> skillList = oldSkillSection.isEmpty
                                ? [skill]
                                : [...oldSkillSection, skill];

                            SkillSection skillSection =
                                SkillSection(title: '', skills: skillList);

                            ref
                                .read(skillSectionProvider.notifier)
                                .update((state) => skillSection);

                            final newResumeData = oldResumeData?.copyWith(
                              skill: ref.watch(skillSectionProvider),
                            );
                            ref
                                .read(resumeDataProvider.notifier)
                                .update((state) => newResumeData);
                          }
                        }

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
