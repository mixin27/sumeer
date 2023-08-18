import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/starter/feat_starter.dart';

class PersonalInformationForm extends StatefulHookConsumerWidget {
  const PersonalInformationForm({super.key});

  @override
  ConsumerState<PersonalInformationForm> createState() =>
      _PersonalInformationFormState();
}

class _PersonalInformationFormState
    extends ConsumerState<PersonalInformationForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    Future.microtask(() {
      final personalDetail = ref.watch(personalDetailProvider);
      if (personalDetail != null) {
        _firstNameController.text = personalDetail.firstName;
        _lastNameController.text = personalDetail.lastName;
        _jobTitleController.text = personalDetail.jobTitle;
        _emailController.text = personalDetail.email;
        _phoneController.text = personalDetail.phone;
        _addressController.text = personalDetail.address;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ref.watch(personalInfoFormKeyProvider),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First Name',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: 'First name is required',
                        ),
                      ]),
                      onChanged: (value) => ref
                          .read(firstNameProvider.notifier)
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
                      'Last Name',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.name,
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: 'Last name is required',
                        ),
                      ]),
                      onChanged: (value) => ref
                          .read(lastNameProvider.notifier)
                          .update((state) => value.trim()),
                    ),
                  ],
                ),
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
                    errorText: 'Job title(position) is required',
                  ),
                ]),
                onChanged: (value) => ref
                    .read(jobTitleProvider.notifier)
                    .update((state) => value.trim()),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: MultiValidator([
                  RequiredValidator(
                    errorText: 'Email is required',
                  ),
                ]),
                onChanged: (value) => ref
                    .read(emailProvider.notifier)
                    .update((state) => value.trim()),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Phone number',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: MultiValidator([
                  RequiredValidator(
                    errorText: 'Phone number is required',
                  ),
                ]),
                onChanged: (value) => ref
                    .read(phoneNumberProvider.notifier)
                    .update((state) => value.trim()),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'City, Country',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.streetAddress,
                validator: MultiValidator([
                  RequiredValidator(
                    errorText: 'City or country is required',
                  ),
                ]),
                onChanged: (value) => ref
                    .read(addressProvider.notifier)
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
