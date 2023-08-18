import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

final stepperCurrentIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final starterResumeDataProvider = StateProvider<ResumeData?>((ref) {
  return null;
});
