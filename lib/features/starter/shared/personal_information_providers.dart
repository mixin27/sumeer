import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

final personalInfoFormKeyProvider =
    StateProvider.autoDispose<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final personalDetailProvider = StateProvider<PersonalDetailSection?>((ref) {
  return null;
});

final personalInformationProvider = StateProvider<PersonalInformation?>((ref) {
  return null;
});

final firstNameProvider = StateProvider<String>((ref) {
  return '';
});
final lastNameProvider = StateProvider<String>((ref) {
  return '';
});
final jobTitleProvider = StateProvider<String>((ref) {
  return '';
});
final emailProvider = StateProvider<String>((ref) {
  return '';
});
final phoneNumberProvider = StateProvider<String>((ref) {
  return '';
});
final addressProvider = StateProvider<String>((ref) {
  return '';
});
