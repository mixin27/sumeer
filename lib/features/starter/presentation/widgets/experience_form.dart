import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:sumeer/features/starter/feat_starter.dart';

class ExperienceForm extends StatefulHookConsumerWidget {
  const ExperienceForm({super.key});

  @override
  ConsumerState<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends ConsumerState<ExperienceForm> {
  final _employerController = TextEditingController();
  final _jobTitleController = TextEditingController();
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
        _startDateController.text = DateFormat("MMM, yyyy").format(dt);
        ref.read(expStartDateProvider.notifier).update((state) => dt);
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
        _endDateController.text = DateFormat("MMM, yyyy").format(dt);
        ref.read(expEndDateProvider.notifier).update((state) => dt);
      }
    }

    final isPresent = ref.watch(expIsPresentProvider);

    return Form(
      key: ref.watch(experienceFormKeyProvider),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Employer',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _employerController,
                keyboardType: TextInputType.text,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Employer is required'),
                ]),
                onChanged: (value) => ref
                    .read(expEmployerProvider.notifier)
                    .update((state) => value.trim()),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Job Title',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _jobTitleController,
                keyboardType: TextInputType.text,
                validator: MultiValidator([
                  RequiredValidator(
                    errorText: 'Job title is required',
                  ),
                ]),
                onChanged: (value) => ref
                    .read(expJobTitleProvider.notifier)
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
                          .read(expCityProvider.notifier)
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
                          .read(expCountryProvider.notifier)
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
            title: const Text("Present"),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) => ref
                .read(expIsPresentProvider.notifier)
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
                    .read(expDescriptionProvider.notifier)
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
    _employerController.dispose();
    _jobTitleController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}
