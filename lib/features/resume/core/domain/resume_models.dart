import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pdf/widgets.dart' as pw;

part 'resume_models.freezed.dart';

@freezed
class ResumeData with _$ResumeData {
  const factory ResumeData({
    pw.MemoryImage? profileImage,
    PersonalDetailSection? personalDetail,
    ProfileSection? profile,
    EducationSection? education,
    ProjectSection? project,
    ExperienceSection? experience,
    SkillSection? skill,
    CertificateSection? certificate,
    LanguageSection? languages,
  }) = _ResumeData;
}

@freezed
class PersonalDetailSection with _$PersonalDetailSection {
  const factory PersonalDetailSection({
    @Default('Personal Details') String title,

    /// Your title, first and last name
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
}

@freezed
class PersonalInformation with _$PersonalInformation {
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
  const factory PersonalLink({
    required String name,
    required String url,
  }) = _PersonalLink;
}

@freezed
class ProfileSection with _$ProfileSection {
  const factory ProfileSection({
    @Default('Profile') String title,
    @Default([]) List<String> contents,
  }) = _ProfileSection;
}

@freezed
class ExperienceSection with _$ExperienceSection {
  const factory ExperienceSection({
    @Default('Professional Experience') String title,
    @Default([]) List<Experience> experiences,
  }) = _ExperienceSection;
}

@freezed
class Experience with _$Experience {
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
  const factory Employer({
    required String name,
    String? link,
  }) = _Employer;
}

@freezed
class EducationSection with _$EducationSection {
  const factory EducationSection({
    @Default('Education') String title,
    @Default([]) List<Education> educations,
  }) = _EducationSection;
}

@freezed
class Education with _$Education {
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
  const factory SkillSection({
    @Default('Skills') String title,
    @Default([]) List<Skill> skills,
  }) = _SkillSection;
}

@freezed
class Skill with _$Skill {
  const factory Skill({
    required String skill,

    /// Information / Sub-skills
    String? information,
    SkillLevel? level,
    double? percentage,
  }) = _Skill;
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
  const factory ProjectSection({
    @Default('Projects') String title,
    @Default([]) List<Project> projects,
  }) = _ProjectSection;
}

@freezed
class Project with _$Project {
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
  const factory CertificateSection({
    @Default('Certificate') String title,
    @Default([]) List<Certificate> certificates,
  }) = _CertificateSection;
}

@freezed
class Certificate with _$Certificate {
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
  const factory LanguageSection({
    @Default('Language') String title,
    @Default([]) List<Language> languages,
  }) = _LanguageSection;
}

@freezed
class Language with _$Language {
  const factory Language({
    /// Degree / Field of Study / Exchange Semester
    String? title,
    String? description,
    LanguageLevel? level,
  }) = _Language;
}

enum LanguageLevel {
  beginner,
  elementary,
  limitedWorking,
  highlyProficient,
  native,
}
