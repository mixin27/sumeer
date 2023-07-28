import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features.dart';
import '../../templates/domain/cv_model.dart';

final resumeDataProvider = StateProvider<ResumeData?>((ref) {
  return null;
});

final cvMOdelProvider = StateProvider<CVModel?>((ref) {
  return CVModel(
    profile: ref.watch(userProfileProvider),
    experiences: ref.watch(userExperienceListProvider),
    skills: ref.watch(userSkillListProvider),
    educations: ref.watch(userEducationListProvider),
  );
});

final userProfileProvider = StateProvider<UserProfile?>((ref) {
  return null;
});

final userExperienceListProvider = StateProvider<List<UserExperience>>((ref) {
  return [];
});

final userSkillListProvider = StateProvider<List<UserSkill>>((ref) {
  return [];
});

final userEducationListProvider = StateProvider<List<UserEducation>>((ref) {
  return [];
});
