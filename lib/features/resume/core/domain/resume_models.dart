import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sumeer/features/resume/feat_resume.dart';

part 'resume_models.freezed.dart';

@freezed
class ResumeData with _$ResumeData {
  const ResumeData._();
  const factory ResumeData({
    // pw.MemoryImage? profileImage,
    String? templateId,
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
    DateTime? date,
  }) = _ResumeData;

  factory ResumeData.empty() => const ResumeData();
}

@freezed
class PersonalDetailSection with _$PersonalDetailSection {
  const PersonalDetailSection._();
  const factory PersonalDetailSection({
    @Default('Personal Details') String title,

    /// Your title, first and last name
    required String firstName,
    required String lastName,
    // required String fullName,
    required String jobTitle,
    required String email,
    required String phone,

    /// City, Country
    required String address,
    String? imageData,
    PersonalInformation? personalInfo,
    @Default([]) List<PersonalLink> links,
  }) = _PersonalDetailSection;

  String get fullName => '$firstName $lastName';
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
}

@freezed
class PersonalLink with _$PersonalLink {
  const PersonalLink._();
  const factory PersonalLink({
    required String name,
    required String url,
    int? codePoint,
  }) = _PersonalLink;
}

@freezed
class ProfileSection with _$ProfileSection {
  const ProfileSection._();
  const factory ProfileSection({
    @Default('Profile') String title,
    @Default([]) List<String> contents,
  }) = _ProfileSection;
}

@freezed
class ExperienceSection with _$ExperienceSection {
  const ExperienceSection._();
  const factory ExperienceSection({
    @Default('Professional Experience') String title,
    @Default([]) List<Experience> experiences,
  }) = _ExperienceSection;
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
}

@freezed
class Employer with _$Employer {
  const Employer._();
  const factory Employer({
    required String name,
    String? link,
  }) = _Employer;
}

@freezed
class EducationSection with _$EducationSection {
  const EducationSection._();
  const factory EducationSection({
    @Default('Education') String title,
    @Default([]) List<Education> educations,
  }) = _EducationSection;
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
}

@freezed
class SkillSection with _$SkillSection {
  const SkillSection._();
  const factory SkillSection({
    @Default('Skills') String title,
    @Default([]) List<Skill> skills,
  }) = _SkillSection;
}

@freezed
class Skill with _$Skill {
  const Skill._();
  const factory Skill({
    required String name,

    /// Information / Sub-skills
    String? information,
    SkillLevelEnum? level,
    double? percentage,
  }) = _Skill;
}

@freezed
class ProjectSection with _$ProjectSection {
  const ProjectSection._();
  const factory ProjectSection({
    @Default('Projects') String title,
    @Default([]) List<Project> projects,
  }) = _ProjectSection;
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
}

@freezed
class CertificateSection with _$CertificateSection {
  const CertificateSection._();
  const factory CertificateSection({
    @Default('Certificate') String title,
    @Default([]) List<Certificate> certificates,
  }) = _CertificateSection;
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
}

@freezed
class LanguageSection with _$LanguageSection {
  const LanguageSection._();
  const factory LanguageSection({
    @Default('Language') String title,
    @Default([]) List<Language> languages,
  }) = _LanguageSection;
}

@freezed
class Language with _$Language {
  const Language._();
  const factory Language({
    /// Degree / Field of Study / Exchange Semester
    String? title,
    String? description,
    LanguageLevelEnum? level,
    double? percentage,
  }) = _Language;
}

@freezed
class InterestSection with _$InterestSection {
  const InterestSection._();
  const factory InterestSection({
    @Default('Interests') String title,
    @Default([]) List<Interest> interests,
  }) = _InterestSection;
}

@freezed
class Interest with _$Interest {
  const Interest._();
  const factory Interest({
    String? title,
  }) = _Interest;
}

@freezed
class AwardSection with _$AwardSection {
  const AwardSection._();
  const factory AwardSection({
    @Default('Awards') String title,
    @Default([]) List<Award> awards,
  }) = _AwardSection;
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
}

String getLanguageLevel(LanguageLevelEnum level) {
  return switch (level) {
    LanguageLevelEnum.beginner => "Beginner",
    LanguageLevelEnum.elementary => "Elementary",
    LanguageLevelEnum.limitedWorking => "Limited working",
    LanguageLevelEnum.highlyProficient => "Highly proficient",
    LanguageLevelEnum.native => "Native"
  };
}

String getSkillLevel(SkillLevelEnum level) {
  return switch (level) {
    SkillLevelEnum.novice => "Novice",
    SkillLevelEnum.beginner => "Beginner",
    SkillLevelEnum.skillfull => "Skill Full",
    SkillLevelEnum.experienced => "Experienced",
    SkillLevelEnum.expert => "Expert"
  };
}
