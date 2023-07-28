import 'package:freezed_annotation/freezed_annotation.dart';
part 'cv_model.g.dart';
part 'cv_model.freezed.dart';

@freezed
class CVModel with _$CVModel {
  const factory CVModel({
    UserProfile? profile,
    List<UserExperience>? experiences,
    List<UserSkill>? skills,
    List<UserEducation>? educations,
  }) = _CVModel;

  factory CVModel.fromJson(Map<String, dynamic> json) =>
      _$CVModelFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    String? image,
    required String name,
    required String jobTitle,
    required String email,
    required String phone,
    required String address,
    String? dOB,
    String? gender,
    String? nationality,
    String? passport,
    String? maritalStatus,
    String? drivingLicense,
    String? website,
    String? linkIn,
    String? gitHub,
    String? skype,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class UserExperience with _$UserExperience {
  const factory UserExperience({
    required String employer,
    required String jobTitle,
    required String city,
    required String startDate,
    required String endDate,
    required String description,
  }) = _UserExperience;

  factory UserExperience.fromJson(Map<String, dynamic> json) =>
      _$UserExperienceFromJson(json);
}

@freezed
class UserEducation with _$UserEducation {
  const factory UserEducation({
    required String degree,
    required String school,
    required String city,
    required String startDate,
    required String endDate,
  }) = _UserEducation;

  factory UserEducation.fromJson(Map<String, dynamic> json) =>
      _$UserEducationFromJson(json);
}

@freezed
class UserSkill with _$UserSkill {
  const factory UserSkill({
    required String skill,
    required String info,
    required String level,
  }) = _UserSkill;

  factory UserSkill.fromJson(Map<String, dynamic> json) =>
      _$UserSkillFromJson(json);
}
