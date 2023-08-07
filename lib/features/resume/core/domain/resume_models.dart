import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_models.freezed.dart';
part 'resume_models.g.dart';

@freezed
class ResumeData with _$ResumeData {
  const ResumeData._();
  const factory ResumeData({
    // pw.MemoryImage? profileImage,
    String? resumeId,
    String? profileImage,
    PersonalDetailSection? personalDetail,
    ProfileSection? profile,
    EducationSection? education,
    ProjectSection? project,
    ExperienceSection? experience,
    SkillSection? skill,
    CertificateSection? certificate,
    LanguageSection? languages,
    InterestSection? interest,
    AwardSection? award,
  }) = _ResumeData;
  factory ResumeData.fromJson(Map<String, dynamic> json) =>
      _$ResumeDataFromJson(json);
}

@freezed
class PersonalDetailSection with _$PersonalDetailSection {
  const PersonalDetailSection._();
  const factory PersonalDetailSection({
    @Default('Personal Details') String title,

    /// Your title, first and last name
    required String firstName,
    required String lastName,
    required String fullName,
    required String jobTitle,
    required String email,
    required String phone,

    /// City, Country
    required String address,
    String? imageData,
    PersonalInformation? personalInfo,
    @Default([]) List<PersonalLink> links,
  }) = _PersonalDetailSection;

  factory PersonalDetailSection.fromJson(Map<String, dynamic> json) =>
      _$PersonalDetailSectionFromJson(json);
}

@freezed
class PersonalInformation with _$PersonalInformation {
  const PersonalInformation._();
  const factory PersonalInformation({
    /// dd-MMMM-yyyy
    String? dateOfBirth,
    String? nationality,

    /// Passport or Id
    String? identityNo,
    String? martialStatus,
    String? militaryService,
    String? drivingLicense,
    String? gender,
  }) = _PersonalInformation;
  factory PersonalInformation.fromJson(Map<String, dynamic> json) =>
      _$PersonalInformationFromJson(json);
}

@freezed
class PersonalLink with _$PersonalLink {
  const PersonalLink._();
  const factory PersonalLink({
    required String name,
    required String url,
    int? codePoint,
  }) = _PersonalLink;
  factory PersonalLink.fromJson(Map<String, dynamic> json) =>
      _$PersonalLinkFromJson(json);
}

@freezed
class ProfileSection with _$ProfileSection {
  const ProfileSection._();
  const factory ProfileSection({
    @Default('Profile') String title,
    @Default([]) List<String> contents,
  }) = _ProfileSection;
  factory ProfileSection.fromJson(Map<String, dynamic> json) =>
      _$ProfileSectionFromJson(json);
}

@freezed
class ExperienceSection with _$ExperienceSection {
  const ExperienceSection._();
  const factory ExperienceSection({
    @Default('Professional Experience') String title,
    @Default([]) List<Experience> experiences,
  }) = _ExperienceSection;
  factory ExperienceSection.fromJson(Map<String, dynamic> json) =>
      _$ExperienceSectionFromJson(json);
}

@freezed
class Experience with _$Experience {
  const Experience._();
  const factory Experience({
    Employer? employer,
    required String jobTitle,
    String? city,
    String? country,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isPresent,
    String? description,
  }) = _Experience;
  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}

@freezed
class Employer with _$Employer {
  const Employer._();
  const factory Employer({
    required String name,
    String? link,
  }) = _Employer;
  factory Employer.fromJson(Map<String, dynamic> json) =>
      _$EmployerFromJson(json);
}

@freezed
class EducationSection with _$EducationSection {
  const EducationSection._();
  const factory EducationSection({
    @Default('Education') String title,
    @Default([]) List<Education> educations,
  }) = _EducationSection;
  factory EducationSection.fromJson(Map<String, dynamic> json) =>
      _$EducationSectionFromJson(json);
}

@freezed
class Education with _$Education {
  const Education._();
  const factory Education({
    /// Degree / Field of Study / Exchange Semester
    String? degree,

    /// School / University
    String? school,
    String? city,
    String? country,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isPresent,
    String? description,
  }) = _Education;
  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

@freezed
class SkillSection with _$SkillSection {
  const SkillSection._();
  const factory SkillSection({
    @Default('Skills') String title,
    @Default([]) List<Skill> skills,
  }) = _SkillSection;
  factory SkillSection.fromJson(Map<String, dynamic> json) =>
      _$SkillSectionFromJson(json);
}

@freezed
class Skill with _$Skill {
  const Skill._();
  const factory Skill({
    required String skill,

    /// Information / Sub-skills
    String? information,
    SkillLevel? level,
    double? percentage,
  }) = _Skill;
  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

enum SkillLevel {
  novice,
  beginner,
  skillfull,
  experienced,
  expert,
}

@freezed
class ProjectSection with _$ProjectSection {
  const ProjectSection._();
  const factory ProjectSection({
    @Default('Projects') String title,
    @Default([]) List<Project> projects,
  }) = _ProjectSection;
  factory ProjectSection.fromJson(Map<String, dynamic> json) =>
      _$ProjectSectionFromJson(json);
}

@freezed
class Project with _$Project {
  const Project._();
  const factory Project({
    required String title,
    String? subtitle,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isPresent,
    String? description,
  }) = _Project;
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

@freezed
class CertificateSection with _$CertificateSection {
  const CertificateSection._();
  const factory CertificateSection({
    @Default('Certificate') String title,
    @Default([]) List<Certificate> certificates,
  }) = _CertificateSection;
  factory CertificateSection.fromJson(Map<String, dynamic> json) =>
      _$CertificateSectionFromJson(json);
}

@freezed
class Certificate with _$Certificate {
  const Certificate._();
  const factory Certificate({
    /// Degree / Field of Study / Exchange Semester
    String? title,

    /// School / University
    String? school,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isPresent,
    String? description,
  }) = _Certificate;
  factory Certificate.fromJson(Map<String, dynamic> json) =>
      _$CertificateFromJson(json);
}

@freezed
class LanguageSection with _$LanguageSection {
  const LanguageSection._();
  const factory LanguageSection({
    @Default('Language') String title,
    @Default([]) List<Language> languages,
  }) = _LanguageSection;
  factory LanguageSection.fromJson(Map<String, dynamic> json) =>
      _$LanguageSectionFromJson(json);
}

@freezed
class Language with _$Language {
  const Language._();
  const factory Language({
    /// Degree / Field of Study / Exchange Semester
    String? title,
    String? description,
    LanguageLevel? level,
    double? percentage,
  }) = _Language;
  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}

@freezed
class InterestSection with _$InterestSection {
  const InterestSection._();
  const factory InterestSection({
    @Default('Interests') String title,
    @Default([]) List<Interest> interests,
  }) = _InterestSection;
  factory InterestSection.fromJson(Map<String, dynamic> json) =>
      _$InterestSectionFromJson(json);
}

@freezed
class Interest with _$Interest {
  const Interest._();
  const factory Interest({
    String? title,
  }) = _Interest;
  factory Interest.fromJson(Map<String, dynamic> json) =>
      _$InterestFromJson(json);
}

@freezed
class AwardSection with _$AwardSection {
  const AwardSection._();
  const factory AwardSection({
    @Default('Awards') String title,
    @Default([]) List<Award> awards,
  }) = _AwardSection;
  factory AwardSection.fromJson(Map<String, dynamic> json) =>
      _$AwardSectionFromJson(json);
}

@freezed
class Award with _$Award {
  const Award._();
  const factory Award({
    String? award,
    String? issuer,
    DateTime? awardDate,
    String? description,
  }) = _Award;
  factory Award.fromJson(Map<String, dynamic> json) => _$AwardFromJson(json);
}

enum LanguageLevel {
  beginner,
  elementary,
  limitedWorking,
  highlyProficient,
  native,
}

String getLanguageLevel(LanguageLevel level) {
  return switch (level) {
    LanguageLevel.beginner => "Beginner",
    LanguageLevel.elementary => "Elementary",
    LanguageLevel.limitedWorking => "Limited working",
    LanguageLevel.highlyProficient => "Highly proficient",
    LanguageLevel.native => "Native"
  };
}
