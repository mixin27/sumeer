import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:sumeer/features/starter/feat_starter.dart';

class EducationForm extends StatefulHookConsumerWidget {
  const EducationForm({super.key});

  @override
  ConsumerState<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends ConsumerState<EducationForm> {
  final _degreeController = TextEditingController();
  final _schoolController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> showStartDatePickerDialog() async {
      final dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (dt != null) {
        _startDateController.text = DateFormat('MMM, yyyy').format(dt);
        ref.read(eduStartDateProvider.notifier).update((state) => dt);
      }
    }

    Future<void> showEndDatePickerDialog() async {
      final dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (dt != null) {
        _endDateController.text = DateFormat('MMM, yyyy').format(dt);
        ref.read(eduEndDateProvider.notifier).update((state) => dt);
      }
    }

    final isPresent = ref.watch(eduIsPresentProvider);

    return Form(
      key: ref.watch(educationFormKeyProvider),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Degree',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _degreeController,
                keyboardType: TextInputType.text,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Degree is required'),
                ]),
                onChanged: (value) => ref
                    .read(eduDegreeProvider.notifier)
                    .update((state) => value.trim()),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'School / Unversity',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _schoolController,
                keyboardType: TextInputType.text,
                validator: MultiValidator([
                  RequiredValidator(
                    errorText: 'School or university is required',
                  ),
                ]),
                onChanged: (value) => ref
                    .read(eduSchoolProvider.notifier)
                    .update((state) => value.trim()),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'City',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) => ref
                          .read(eduCityProvider.notifier)
                          .update((state) => value.trim()),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Country',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _countryController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) => ref
                          .read(eduCountryProvider.notifier)
                          .update((state) => value.trim()),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Date',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _startDateController,
                      onTap: showStartDatePickerDialog,
                      readOnly: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              if (!isPresent)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Date',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _endDateController,
                        onTap: showEndDatePickerDialog,
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          CheckboxListTile.adaptive(
            value: isPresent,
            contentPadding: EdgeInsets.zero,
            title: const Text('Present'),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) => ref
                .read(eduIsPresentProvider.notifier)
                .update((state) => value ?? false),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                onChanged: (value) => ref
                    .read(eduDescriptionProvider.notifier)
                    .update((state) => value.trim()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _degreeController.dispose();
    _schoolController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}
