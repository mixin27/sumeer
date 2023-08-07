import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/utils/logger/logger.dart';
import '../../../../utils/helpers/dialog_helper.dart';
import '../../../../widgets/app_dialog_box.dart';

class AddProfessionalExperienceForm extends ConsumerStatefulWidget {
  final int? index;
  final Experience? experience;
  const AddProfessionalExperienceForm(this.experience, this.index, {super.key});

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
  String selectedStartDateStr = "";
  DateTime? selectedStartDate;
  String selectedEndDateStr = "";
  DateTime? selectedEndDate;
  bool isPresent = false;
  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    Future.microtask(() {
      // final exp = ref.watch(userExpProvider);
      if (widget.experience != null) {
        employerController.text = widget.experience?.employer?.name ?? '';
        jobTitleController.text = widget.experience?.jobTitle ?? '';
        cityController.text = widget.experience?.city ?? '';
        isPresent = widget.experience?.isPresent ?? false;

        descriptionController.text = widget.experience?.description ?? '';

        if (widget.experience?.startDate != null) {
          selectedStartDate = widget.experience?.startDate;
          selectedStartDateStr = DateFormat("MMMM-yyyy")
              .format(selectedStartDate ?? DateTime.now());
          startDateController.text = selectedStartDateStr;
        }
        if (widget.experience?.endDate != null) {
          selectedEndDate = widget.experience?.endDate;
          selectedEndDateStr =
              DateFormat("MMMM-yyyy").format(selectedEndDate ?? DateTime.now());
          endDateController.text = selectedEndDateStr;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    wtfLog('widget experience', widget.experience);
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
                          readOnly: true,
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            size: 30,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          onTap: () => _showStartDatePicker(context),
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: !isPresent,
                              child: Expanded(
                                flex: 7,
                                child: TextInputFieldWidget(
                                  controller: endDateController,
                                  title: "End Date",
                                  readOnly: true,
                                  suffixIcon: Icon(
                                    Icons.calendar_month,
                                    size: 30,
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                  onTap: () => _showDatePicker(context),
                                ),
                              ),
                            ),
                            Checkbox(
                                value: isPresent,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isPresent = value ?? false;
                                  });
                                }),
                            Text(
                              "Is Present",
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                        TextInputFieldWidget(
                          controller: descriptionController,
                          title: "Description",
                          hintText: "Describe ypur role & achievements",
                          maxLines: 3,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SaveBottomSheetWidget(
                          onTap: () {
                            final oldExpScetion =
                                ref.watch(experienceSectionProvider);
                            final oldResumeData = ref.watch(resumeDataProvider);
                            vLog('date time', DateTime.now());
                            Employer employer =
                                Employer(name: employerController.text);
                            Experience experience = Experience(
                              employer: employer,
                              jobTitle: jobTitleController.text,
                              city: cityController.text,
                              isPresent: isPresent,
                              // startDate: startDate,
                              startDate: DateTime.now(),
                              endDate: DateTime.now(),
                              description: descriptionController.text,
                            );

                            if (jobTitleController.text.isEmpty) {
                              return Navigator.of(context).pop();
                            } else {
                              if (widget.index != null) {
                                List<Experience> list1 = [];
                                List<Experience> list =
                                    oldExpScetion?.experiences ?? [];
                                for (var element in list) {
                                  list1.add(element);
                                }
                                list1.removeAt(widget.index ?? 0);
                                wLog('updated list remove', list1);

                                list1.insert(widget.index ?? 0, experience);
                                wLog('updated list', list1);
                                ExperienceSection skillSection =
                                    ExperienceSection(
                                        title: '', experiences: list1);

                                ref
                                    .read(experienceSectionProvider.notifier)
                                    .update((state) => skillSection);

                                final newResumeData = oldResumeData?.copyWith(
                                    experience:
                                        ref.watch(experienceSectionProvider));
                                ref
                                    .read(resumeDataProvider.notifier)
                                    .update((state) => newResumeData);
                              } else {
                                List<Experience> experienceList =
                                    oldExpScetion == null
                                        ? [experience]
                                        : [
                                            ...oldExpScetion.experiences,
                                            experience
                                          ];
                                ExperienceSection experienceSection =
                                    ExperienceSection(
                                  title: '',
                                  experiences: experienceList,
                                );
                                ref
                                    .read(experienceSectionProvider.notifier)
                                    .update((state) => experienceSection);

                                final newResumeData = oldResumeData?.copyWith(
                                    experience:
                                        ref.watch(experienceSectionProvider));
                                ref
                                    .read(resumeDataProvider.notifier)
                                    .update((state) => newResumeData);
                              }
                            }

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

  void _showDatePicker(BuildContext context) {
    showAnimatedDialog(
      context,
      barrierDismissible: true,
      barrierLabel: '',
      dialog: AppDialogBox(
        header: Text(
          "Select Date of Birth",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        content: DatePickerWidget(
          looping: false, // default is not looping
          firstDate: DateTime(1990, 01),
          // lastDate: DateTime(2030, 1, 1),
          initialDate: DateTime.now(),
          dateFormat: "MMMM-yyyy",
          onChange: (DateTime newDate, _) {
            setState(() {
              selectedEndDate = newDate;
            });
          },
          locale: DateTimePickerLocale.en_us,
          pickerTheme: DateTimePickerTheme(
              itemTextStyle: const TextStyle(color: Colors.black, fontSize: 19),
              dividerColor: Colors.blue,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.02)),
        ),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                context.router.pop();
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    Theme.of(context).colorScheme.onSurface.withAlpha(90),
              ),
              child: const Text('Cancel'),
            ),
            // Gap(ALC.getWidth(10)),
            TextButton(
              onPressed: () {
                context.router.pop();
                selectedEndDateStr = DateFormat("MMMM-yyyy")
                    .format(selectedEndDate ?? DateTime.now());
                endDateController.text = selectedEndDateStr;
                selectedEndDate = selectedEndDate ?? DateTime.now();
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }

  void _showStartDatePicker(BuildContext context) {
    showAnimatedDialog(
      context,
      barrierDismissible: true,
      barrierLabel: '',
      dialog: AppDialogBox(
        header: Text(
          "Select Date of Birth",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        content: DatePickerWidget(
          looping: false, // default is not looping
          firstDate: DateTime(1990, 01),
          // lastDate: DateTime(2030, 1, 1),
          initialDate: DateTime.now(),
          dateFormat: "MMMM-yyyy",
          onChange: (DateTime newDate, _) {
            setState(() {
              selectedStartDate = newDate;
            });
          },
          locale: DateTimePickerLocale.en_us,
          pickerTheme: DateTimePickerTheme(
              itemTextStyle: const TextStyle(color: Colors.black, fontSize: 19),
              dividerColor: Colors.blue,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.02)),
        ),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                context.router.pop();
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    Theme.of(context).colorScheme.onSurface.withAlpha(90),
              ),
              child: const Text('Cancel'),
            ),
            // Gap(ALC.getWidth(10)),
            TextButton(
              onPressed: () {
                context.router.pop();
                selectedStartDateStr = DateFormat("MMMM-yyyy")
                    .format(selectedStartDate ?? DateTime.now());
                startDateController.text = selectedStartDateStr;
                selectedStartDate = selectedStartDate ?? (DateTime.now());
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
