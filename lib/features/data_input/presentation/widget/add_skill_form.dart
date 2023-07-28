import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/features/templates/domain/cv_model.dart';

class AddSkillForm extends ConsumerStatefulWidget {
  const AddSkillForm({super.key});

  @override
  ConsumerState<AddSkillForm> createState() => _AddSkillFormState();
}

class _AddSkillFormState extends ConsumerState<AddSkillForm> {
  final skillController = TextEditingController();
  final infoController = TextEditingController();
  final levelController = TextEditingController();
  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    Future.microtask(() {
      final skill = ref.watch(userSkillProvider);
      if (skill != null) {
        skillController.text = skill.skill;
        infoController.text = skill.info;
        levelController.text = skill.level;
      }
    });
  }

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
                    ),
                    SaveBottomSheetWidget(
                      onTap: () {
                        UserSkill skill = UserSkill(
                          skill: skillController.text,
                          info: infoController.text,
                          level: levelController.text,
                        );
                        ref
                            .read(userSkillListProvider.notifier)
                            .update((state) => [...state, skill]);
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
