import 'package:flutter/material.dart';
import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';

class AddSkillForm extends StatelessWidget {
  const AddSkillForm({super.key});

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
                  children: const [
                    TextInputFieldWidget(
                      title: "Skill",
                    ),
                    TextInputFieldWidget(
                      title: "Information/ Sub-skills",
                    ),
                    TextInputFieldWidget(
                      title: "Select skill level",
                    ),
                    SaveBottomSheetWidget()
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
