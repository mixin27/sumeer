import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

final experienceFormKeyProvider =
    StateProvider.autoDispose<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final showExperienceFormProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final experienceSectionProvider = StateProvider<ExperienceSection?>((ref) {
  return null;
});

final experiencesProvider = StateProvider<List<Experience>>((ref) {
  return [];
});

final expIsPresentProvider = StateProvider<bool>((ref) {
  return false;
});

final expEmployerProvider = StateProvider<String?>((ref) {
  return null;
});
final expJobTitleProvider = StateProvider<String?>((ref) {
  return null;
});
final expCityProvider = StateProvider<String?>((ref) {
  return null;
});
final expCountryProvider = StateProvider<String?>((ref) {
  return null;
});
final expDescriptionProvider = StateProvider<String?>((ref) {
  return null;
});

final expStartDateProvider = StateProvider<DateTime?>((ref) {
  return null;
});
final expEndDateProvider = StateProvider<DateTime?>((ref) {
  return null;
});
