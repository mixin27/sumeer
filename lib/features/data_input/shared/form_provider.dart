import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features.dart';
import '../../templates/domain/cv_model.dart';

final resumeDataProvider = StateProvider<ResumeData?>((ref) {
  return ResumeData(
    profile: ref.watch(profileProvider),
    personalDetail: ref.watch(personalDetailSectionProvider),
    education: ref.watch(educationSectionListProvider),
    project: ref.watch(projectSectionListProvider),
    experience: ref.watch(experienceSectionListProvider),
    certificate: ref.watch(certificateSectionListProvider),
    skill: ref.watch(skillSectionListProvider),
    languages: ref.watch(languageSectionListProvider),
  );
});

final cvMOdelProvider = StateProvider<CVModel?>((ref) {
  return CVModel(
    profile: ref.watch(userProfileProvider),
    experiences: ref.watch(userExperienceListProvider),
    skills: ref.watch(userSkillListProvider),
    educations: ref.watch(userEducationListProvider),
  );
});
// final resumeModelProvider = StateProvider<ResumeData?>((ref) {
//   return ResumeData(
//     profile: ref.watch(userProfileProvider),
//     experiences: ref.watch(userExperienceListProvider),
//     skills: ref.watch(userSkillListProvider),
//     educations: ref.watch(userEducationListProvider),
//   );
// });

final userProfileProvider = StateProvider<UserProfile?>((ref) {
  return null;
});

final userExperienceListProvider = StateProvider<List<UserExperience>>((ref) {
  return [];
});

final userSkillListProvider = StateProvider<List<UserSkill>>((ref) {
  return [];
});

final userSkillProvider = StateProvider<UserSkill?>((ref) => null);
final userExpProvider = StateProvider<UserExperience?>((ref) => null);
final userEduProvider = StateProvider<UserEducation?>((ref) => null);

final userEducationListProvider = StateProvider<List<UserEducation>>((ref) {
  return [];
});

// resumeData
final personalDetailSectionProvider =
    StateProvider<PersonalDetailSection?>((ref) => null);
final personalDetailSectionListProvider =
    StateProvider<List<PersonalDetailSection>?>((ref) => []);
// profile
final profileProvider = StateProvider<ProfileSection?>((ref) => null);
// educaton
final educationSectionProvider =
    StateProvider<EducationSection?>((ref) => null);
final educationSectionListProvider =
    StateProvider<List<EducationSection>>((ref) => []);
// project
final projectSectionProvider = StateProvider<ProjectSection?>((ref) => null);
final projectSectionListProvider =
    StateProvider<List<ProjectSection>>((ref) => []);
// experience
final experienceSectionProvider =
    StateProvider<ExperienceSection?>((ref) => null);
final experienceSectionListProvider =
    StateProvider<List<ExperienceSection>>((ref) => []);
// skill
final skillSectionProvider = StateProvider<SkillSection?>((ref) => null);
final skillSectionListProvider = StateProvider<List<SkillSection>>((ref) => []);
// certificate
final certificateSectionProvider =
    StateProvider<CertificateSection?>((ref) => null);
final certificateSectionListProvider =
    StateProvider<List<CertificateSection>>((ref) => []);

// language
final languageSectionProvider = StateProvider<LanguageSection?>((ref) => null);
final languageSectionListProvider =
    StateProvider<List<LanguageSection>>((ref) => []);
