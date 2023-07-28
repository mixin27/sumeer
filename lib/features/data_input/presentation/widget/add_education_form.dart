import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/features/templates/domain/cv_model.dart';

class AddEducationForm extends ConsumerStatefulWidget {
  const AddEducationForm({super.key});

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
  Widget build(BuildContext context) {
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
                            UserEducation education = UserEducation(
                                degree: degreeController.text,
                                school: schoolController.text,
                                city: cityController.text,
                                startDate: startDateController.text,
                                endDate: endDateController.text);
                            ref
                                .read(userEducationListProvider.notifier)
                                .update((state) => [...state, education]);
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
