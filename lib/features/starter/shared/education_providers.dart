import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/features/resume/feat_resume.dart';

final educationFormKeyProvider =
    StateProvider.autoDispose<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final showEducationFormProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final educationSectionProvider = StateProvider<EducationSection?>((ref) {
  return null;
});

final educationsProvider = StateProvider<List<Education>>((ref) {
  return [];
});

final eduIsPresentProvider = StateProvider<bool>((ref) {
  return false;
});

final eduDegreeProvider = StateProvider<String?>((ref) {
  return null;
});
final eduSchoolProvider = StateProvider<String?>((ref) {
  return null;
});
final eduCityProvider = StateProvider<String?>((ref) {
  return null;
});
final eduCountryProvider = StateProvider<String?>((ref) {
  return null;
});
final eduDescriptionProvider = StateProvider<String?>((ref) {
  return null;
});

final eduStartDateProvider = StateProvider<DateTime?>((ref) {
  return null;
});
final eduEndDateProvider = StateProvider<DateTime?>((ref) {
  return null;
});
