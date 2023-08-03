import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/utils/logger/logger.dart';

class AddProfessionalExperienceForm extends ConsumerStatefulWidget {
  final Experience? experience;
  const AddProfessionalExperienceForm(this.experience, {super.key});

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
  }

  Future<void> setData() async {
    Future.microtask(() {
      // final exp = ref.watch(userExpProvider);
      if (widget.experience != null) {
        employerController.text = '';
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
                            vLog('date time', DateTime.now());
                            Experience experience = Experience(
                              employer: null,
                              jobTitle: jobTitleController.text,
                              city: cityController.text,
                              // startDate: startDate,
                              startDate: DateTime.now(),
                              endDate: DateTime.now(),
                              description: descriptionController.text,
                            );
                            List<Experience> experienceList = oldExpScetion ==
                                    null
                                ? [experience]
                                : [...oldExpScetion.experiences, experience];
                            ExperienceSection experienceSection =
                                ExperienceSection(
                              title: '',
                              experiences: experienceList,
                            );
                            ref
                                .read(experienceSectionProvider.notifier)
                                .update((state) => experienceSection);
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
