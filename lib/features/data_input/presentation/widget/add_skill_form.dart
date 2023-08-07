import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:searchfield/searchfield.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/utils/utils.dart';

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
  List<String> skillList = ['Novice', 'Beginner', 'Experienced', 'Expert'];
  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    Future.microtask(() {
      // final skill = ref.watch(userSkillProvider);
      if (widget.skill != null) {
        skillController.text = widget.skill?.skill ?? '';
        infoController.text = widget.skill?.information ?? '';
        levelController.text = widget.skill?.level.toString() ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    wtfLog('widget index', widget.index);
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
                    TextInputFieldWidget(
                      controller: levelController,
                      title: "Select skill level",
                      suffixIcon: DropdownButton(
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: skillList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (val) {
                          levelController.text = val.toString();
                        },
                      ),
                    ),
                    SaveBottomSheetWidget(
                      onTap: () {
                        final oldSkillSection = ref.watch(skillSectionProvider);
                        final oldResumeData = ref.watch(resumeDataProvider);
                        Skill skill = Skill(
                          skill: skillController.text,
                          information: infoController.text,
                          level: SkillLevel.expert,
                        );
                        if (skillController.text.isEmpty) {
                          return Navigator.of(context).pop();
                        } else {
                          if (widget.index != null) {
                            List<Skill> list1 = [];
                            List<Skill> list = oldSkillSection?.skills ?? [];
                            for (var element in list) {
                              list1.add(element);
                            }
                            list1.removeAt(widget.index ?? 0);
                            wLog('updated list remove', list1);

                            list1.insert(widget.index ?? 0, skill);
                            wLog('updated list', list1);
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
                            List<Skill> skillList = oldSkillSection == null
                                ? [skill]
                                : [...oldSkillSection.skills, skill];

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
