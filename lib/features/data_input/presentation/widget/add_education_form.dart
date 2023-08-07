import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/utils/utils.dart';

import '../../../../widgets/app_dialog_box.dart';

class AddEducationForm extends ConsumerStatefulWidget {
  final int? index;
  final Education? education;
  const AddEducationForm(this.education, this.index, {super.key});

  @override
  ConsumerState<AddEducationForm> createState() => _AddEducationFormState();
}

class _AddEducationFormState extends ConsumerState<AddEducationForm> {
  final degreeController = TextEditingController();
  final schoolController = TextEditingController();
  final cityController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  String selectedStartDateStr = "";
  DateTime? selectedStartDate;
  String selectedEndDateStr = "";
  DateTime? selectedEndDate;
  bool isChecked = false;
  bool isChecked1 = false;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    Future.microtask(() {
      // final skill = ref.watch(userSkillProvider);
      if (widget.education != null) {
        degreeController.text = widget.education?.degree ?? '';
        schoolController.text = widget.education?.school ?? '';
        cityController.text = widget.education?.city.toString() ?? '';

        if (widget.education?.startDate != null) {
          selectedStartDate = widget.education?.startDate;
          selectedStartDateStr = DateFormat("MMMM-yyyy")
              .format(selectedStartDate ?? DateTime.now());
          startDateController.text = selectedStartDateStr;
        }
        if (widget.education?.endDate != null) {
          selectedEndDate = widget.education?.endDate;
          selectedEndDateStr =
              DateFormat("MMMM-yyyy").format(selectedEndDate ?? DateTime.now());
          endDateController.text = selectedEndDateStr;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    wLog('index number', 'called');
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
                          controller: schoolController,
                          title: "School",
                        ),
                        TextInputFieldWidget(
                          controller: degreeController,
                          title: "Degree",
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
                        TextInputFieldWidget(
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
                        const SizedBox(
                          height: 20,
                        ),
                        SaveBottomSheetWidget(
                          onTap: () {
                            final oldEduSection =
                                ref.watch(educationSectionProvider);
                            final oldResumeData = ref.watch(resumeDataProvider);
                            Education education = Education(
                              degree: degreeController.text,
                              school: schoolController.text,
                              city: cityController.text,
                              startDate: selectedStartDate,
                              endDate: selectedEndDate,
                            );
                            if (degreeController.text.isEmpty &&
                                schoolController.text.isEmpty) {
                              return Navigator.of(context).pop();
                            } else {
                              if (widget.index != null) {
                                List<Education> list1 = [];
                                List<Education> list =
                                    oldEduSection?.educations ?? [];
                                for (var element in list) {
                                  list1.add(element);
                                }
                                list1.removeAt(widget.index ?? 0);
                                wLog('updated list remove', list1);

                                list1.insert(widget.index ?? 0, education);
                                wLog('updated list', list1);
                                EducationSection educationSection =
                                    EducationSection(
                                        title: '', educations: list1);

                                ref
                                    .read(educationSectionProvider.notifier)
                                    .update((state) => educationSection);

                                final newResumeData = oldResumeData?.copyWith(
                                    education:
                                        ref.watch(educationSectionProvider));
                                ref
                                    .read(resumeDataProvider.notifier)
                                    .update((state) => newResumeData);
                              } else {
                                List<Education> eduList = oldEduSection == null
                                    ? [education]
                                    : [...oldEduSection.educations, education];
                                EducationSection eduScetion = EducationSection(
                                  title: '',
                                  educations: eduList,
                                );
                                ref
                                    .read(educationSectionProvider.notifier)
                                    .update((state) => eduScetion);
                                // ResumeData resumeData = ResumeData(
                                //     education: ref.watch(educationSectionProvider));
                                final newResumeData = oldResumeData?.copyWith(
                                  education:
                                      ref.watch(educationSectionProvider),
                                );
                                ref
                                    .read(resumeDataProvider.notifier)
                                    .update((state) => newResumeData);
                                // ref
                                //     .read(resumeDataProvider.notifier)
                                //     .update((state) => state);
                              }
                            }

                            Navigator.pop(context);
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
