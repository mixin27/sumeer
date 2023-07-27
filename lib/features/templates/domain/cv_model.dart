import 'package:freezed_annotation/freezed_annotation.dart';
part 'cv_model.g.dart';
part 'cv_model.freezed.dart';

@freezed
class CVModel with _$CVModel {
  const factory CVModel(
    final UserProfile profile,
    final List<UserExperience> experiences,
    final List<UserSkill> skills,
    final List<UserEducation> educations,
  ) = _CVModel;

  factory CVModel.fromJson(Map<String, dynamic> json) =>
      _$CVModelFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile(
    final String name,
    final String phone,
    final String email,
    final String address,
    final String position,
  ) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class UserExperience with _$UserExperience {
  const factory UserExperience(
    final String position,
    final String company,
    final String year,
    final String jobDescription,
  ) = _UserExperience;

  factory UserExperience.fromJson(Map<String, dynamic> json) =>
      _$UserExperienceFromJson(json);
}

@freezed
class UserEducation with _$UserEducation {
  const factory UserEducation(
    final String degree,
    final String year,
  ) = _UserEducation;

  factory UserEducation.fromJson(Map<String, dynamic> json) =>
      _$UserEducationFromJson(json);
}

@freezed
class UserSkill with _$UserSkill {
  const factory UserSkill(
    final String title,
    final String level,
  ) = _UserSkill;

  factory UserSkill.fromJson(Map<String, dynamic> json) =>
      _$UserSkillFromJson(json);
}
