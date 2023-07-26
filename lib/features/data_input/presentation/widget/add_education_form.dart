import 'package:flutter/material.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';

class AddEducationForm extends StatelessWidget {
  const AddEducationForm({super.key});

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
                      children: const [
                        TextInputFieldWidget(
                          title: "Degree",
                        ),
                        TextInputFieldWidget(
                          title: "School",
                        ),
                        TextInputFieldWidget(
                          title: "City",
                        ),
                        TextInputFieldWidget(
                          title: "Start Date",
                        ),
                        TextInputFieldWidget(
                          title: "End Date",
                        ),
                        SaveBottomSheetWidget()
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
