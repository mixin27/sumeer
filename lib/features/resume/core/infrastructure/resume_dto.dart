import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sumeer/features/resume/feat_resume.dart';

part 'resume_dto.freezed.dart';
part 'resume_dto.g.dart';

// LanguageLevelEnum _languageLevelFromJson(Object? json) {
//   return (json as String?)?.toLangLevelEnum() ?? LanguageLevelEnum.beginner;
// }

// SkillLevelEnum _skillLevelFromJson(Object? json) {
//   return (json as String?)?.toSkillLevelEnum() ?? SkillLevelEnum.beginner;
// }

@freezed
class ResumeDataDto with _$ResumeDataDto {
  const ResumeDataDto._();
  const factory ResumeDataDto({
    // pw.MemoryImage? profileImage,
    String? templateId,
    String? resumeId,
    String? profileImage,
    PersonalDetailSectionDto? personalDetail,
    ProfileSectionDto? profile,
    EducationSectionDto? education,
    ProjectSectionDto? project,
    ExperienceSectionDto? experience,
    SkillSectionDto? skill,
    CertificateSectionDto? certificate,
    LanguageSectionDto? languages,
    InterestSectionDto? interest,
    AwardSectionDto? award,

    // extra
    required DateTime date,
  }) = _ResumeDataDto;

  factory ResumeDataDto.empty() => ResumeDataDto(date: DateTime.now());

  factory ResumeDataDto.fromJson(Map<String, dynamic> json) =>
      _$ResumeDataDtoFromJson(json);

  factory ResumeDataDto.fromDomain(ResumeData _) => ResumeDataDto(
        date: _.date ?? DateTime.now(),
        templateId: _.templateId,
        resumeId: _.resumeId,
        profileImage: _.profileImage,
        personalDetail: _.personalDetail == null
            ? null
            : PersonalDetailSectionDto.fromDomain(_.personalDetail!),
        profile:
            _.profile == null ? null : ProfileSectionDto.fromDomain(_.profile!),
        education: _.education == null
            ? null
            : EducationSectionDto.fromDomain(_.education!),
        project:
            _.project == null ? null : ProjectSectionDto.fromDomain(_.project!),
        experience: _.experience == null
            ? null
            : ExperienceSectionDto.fromDomain(_.experience!),
        skill: _.skill == null ? null : SkillSectionDto.fromDomain(_.skill!),
        certificate: _.certificate == null
            ? null
            : CertificateSectionDto.fromDomain(_.certificate!),
        languages: _.languages == null
            ? null
            : LanguageSectionDto.fromDomain(_.languages!),
        interest: _.interest == null
            ? null
            : InterestSectionDto.fromDomain(_.interest!),
        award: _.award == null ? null : AwardSectionDto.fromDomain(_.award!),
      );

  ResumeData toDomain() => ResumeData(
        date: date,
        templateId: templateId,
        resumeId: resumeId,
        profileImage: profileImage,
        personalDetail:
            personalDetail == null ? null : personalDetail!.toDomain(),
        profile: profile == null ? null : profile!.toDomain(),
        education: education == null ? null : education!.toDomain(),
        project: project == null ? null : project!.toDomain(),
        experience: experience == null ? null : experience!.toDomain(),
        skill: skill == null ? null : skill!.toDomain(),
        certificate: certificate == null ? null : certificate!.toDomain(),
        languages: languages == null ? null : languages!.toDomain(),
        interest: interest == null ? null : interest!.toDomain(),
        award: award == null ? null : award!.toDomain(),
      );
}

@freezed
class PersonalDetailSectionDto with _$PersonalDetailSectionDto {
  const PersonalDetailSectionDto._();
  const factory PersonalDetailSectionDto({
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
    PersonalInformationDto? personalInfo,
    @Default([]) List<PersonalLinkDto> links,
  }) = _PersonalDetailSectionDto;

  factory PersonalDetailSectionDto.fromJson(Map<String, dynamic> json) =>
      _$PersonalDetailSectionDtoFromJson(json);

  factory PersonalDetailSectionDto.fromDomain(PersonalDetailSection _) =>
      PersonalDetailSectionDto(
        title: _.title,
        firstName: _.firstName,
        lastName: _.lastName,
        jobTitle: _.jobTitle,
        email: _.email,
        phone: _.phone,
        address: _.address,
        imageData: _.imageData,
        personalInfo: _.personalInfo == null
            ? null
            : PersonalInformationDto.fromDomain(_.personalInfo!),
        links: _.links.map((e) => PersonalLinkDto.fromDomain(e)).toList(),
      );

  PersonalDetailSection toDomain() => PersonalDetailSection(
        title: title,
        firstName: firstName,
        lastName: lastName,
        jobTitle: jobTitle,
        email: email,
        phone: phone,
        address: address,
        imageData: imageData,
        personalInfo: personalInfo == null ? null : personalInfo!.toDomain(),
        links: links.map((e) => e.toDomain()).toList(),
      );
}

@freezed
class PersonalInformationDto with _$PersonalInformationDto {
  const PersonalInformationDto._();
  const factory PersonalInformationDto({
    /// dd-MMMM-yyyy
    String? dateOfBirth,
    String? nationality,

    /// Passport or Id
    String? identityNo,
    String? martialStatus,
    String? militaryService,
    String? drivingLicense,
    String? gender,
  }) = _PersonalInformationDto;
  factory PersonalInformationDto.fromJson(Map<String, dynamic> json) =>
      _$PersonalInformationDtoFromJson(json);

  factory PersonalInformationDto.fromDomain(PersonalInformation _) =>
      PersonalInformationDto(
        dateOfBirth: _.dateOfBirth,
        nationality: _.nationality,
        identityNo: _.identityNo,
        martialStatus: _.martialStatus,
        militaryService: _.militaryService,
        drivingLicense: _.drivingLicense,
        gender: _.gender,
      );

  PersonalInformation toDomain() => PersonalInformation(
        dateOfBirth: dateOfBirth,
        nationality: nationality,
        identityNo: identityNo,
        martialStatus: martialStatus,
        militaryService: militaryService,
        drivingLicense: drivingLicense,
        gender: gender,
      );
}

@freezed
class PersonalLinkDto with _$PersonalLinkDto {
  const PersonalLinkDto._();
  const factory PersonalLinkDto({
    required String name,
    required String url,
    int? codePoint,
  }) = _PersonalLinkDto;
  factory PersonalLinkDto.fromJson(Map<String, dynamic> json) =>
      _$PersonalLinkDtoFromJson(json);

  factory PersonalLinkDto.fromDomain(PersonalLink _) => PersonalLinkDto(
        name: _.name,
        url: _.url,
        codePoint: _.codePoint,
      );

  PersonalLink toDomain() => PersonalLink(
        name: name,
        url: url,
        codePoint: codePoint,
      );
}

@freezed
class ProfileSectionDto with _$ProfileSectionDto {
  const ProfileSectionDto._();
  const factory ProfileSectionDto({
    @Default('Profile') String title,
    @Default([]) List<String> contents,
  }) = _ProfileSectionDto;
  factory ProfileSectionDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileSectionDtoFromJson(json);

  factory ProfileSectionDto.fromDomain(ProfileSection _) => ProfileSectionDto(
        title: _.title,
        contents: _.contents,
      );

  ProfileSection toDomain() => ProfileSection(
        title: title,
        contents: contents,
      );
}

@freezed
class ExperienceSectionDto with _$ExperienceSectionDto {
  const ExperienceSectionDto._();
  const factory ExperienceSectionDto({
    @Default('Professional Experience') String title,
    @Default([]) List<ExperienceDto> experiences,
  }) = _ExperienceSectionDto;
  factory ExperienceSectionDto.fromJson(Map<String, dynamic> json) =>
      _$ExperienceSectionDtoFromJson(json);

  factory ExperienceSectionDto.fromDomain(ExperienceSection _) =>
      ExperienceSectionDto(
        title: _.title,
        experiences:
            _.experiences.map((e) => ExperienceDto.fromDomain(e)).toList(),
      );

  ExperienceSection toDomain() => ExperienceSection(
        title: title,
        experiences: experiences.map((e) => e.toDomain()).toList(),
      );
}

@freezed
class ExperienceDto with _$ExperienceDto {
  const ExperienceDto._();
  const factory ExperienceDto({
    EmployerDto? employer,
    required String jobTitle,
    String? city,
    String? country,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isPresent,
    String? description,
  }) = _ExperienceDto;
  factory ExperienceDto.fromJson(Map<String, dynamic> json) =>
      _$ExperienceDtoFromJson(json);

  factory ExperienceDto.fromDomain(Experience _) => ExperienceDto(
        employer:
            _.employer == null ? null : EmployerDto.fromDomain(_.employer!),
        jobTitle: _.jobTitle,
        city: _.city,
        country: _.country,
        startDate: _.startDate,
        endDate: _.endDate,
        isPresent: _.isPresent,
        description: _.description,
      );

  Experience toDomain() => Experience(
        employer: employer == null ? null : employer!.toDomain(),
        jobTitle: jobTitle,
        city: city,
        country: country,
        startDate: startDate,
        endDate: endDate,
        isPresent: isPresent,
        description: description,
      );
}

@freezed
class EmployerDto with _$EmployerDto {
  const EmployerDto._();
  const factory EmployerDto({
    required String name,
    String? link,
  }) = _EmployerDto;
  factory EmployerDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerDtoFromJson(json);

  factory EmployerDto.fromDomain(Employer _) => EmployerDto(
        name: _.name,
        link: _.link,
      );

  Employer toDomain() => Employer(
        name: name,
        link: link,
      );
}

@freezed
class EducationSectionDto with _$EducationSectionDto {
  const EducationSectionDto._();
  const factory EducationSectionDto({
    @Default('Education') String title,
    @Default([]) List<EducationDto> educations,
  }) = _EducationSectionDto;
  factory EducationSectionDto.fromJson(Map<String, dynamic> json) =>
      _$EducationSectionDtoFromJson(json);

  factory EducationSectionDto.fromDomain(EducationSection _) =>
      EducationSectionDto(
        title: _.title,
        educations:
            _.educations.map((e) => EducationDto.fromDomain(e)).toList(),
      );

  EducationSection toDomain() => EducationSection(
        title: title,
        educations: educations.map((e) => e.toDomain()).toList(),
      );
}

@freezed
class EducationDto with _$EducationDto {
  const EducationDto._();
  const factory EducationDto({
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
  }) = _EducationDto;
  factory EducationDto.fromJson(Map<String, dynamic> json) =>
      _$EducationDtoFromJson(json);

  factory EducationDto.fromDomain(Education _) => EducationDto(
        degree: _.degree,
        school: _.school,
        city: _.city,
        country: _.country,
        startDate: _.startDate,
        endDate: _.endDate,
        isPresent: _.isPresent,
        description: _.description,
      );

  Education toDomain() => Education(
        degree: degree,
        school: school,
        city: city,
        country: country,
        startDate: startDate,
        endDate: endDate,
        isPresent: isPresent,
        description: description,
      );
}

@freezed
class SkillSectionDto with _$SkillSectionDto {
  const SkillSectionDto._();
  const factory SkillSectionDto({
    @Default('Skills') String title,
    @Default([]) List<SkillDto> skills,
  }) = _SkillSectionDto;
  factory SkillSectionDto.fromJson(Map<String, dynamic> json) =>
      _$SkillSectionDtoFromJson(json);

  factory SkillSectionDto.fromDomain(SkillSection _) => SkillSectionDto(
        title: _.title,
        skills: _.skills.map((e) => SkillDto.fromDomain(e)).toList(),
      );

  SkillSection toDomain() => SkillSection(
        title: title,
        skills: skills.map((e) => e.toDomain()).toList(),
      );
}

@freezed
class SkillDto with _$SkillDto {
  const SkillDto._();
  const factory SkillDto({
    required String name,

    /// Information / Sub-skillDtos
    String? information,
    SkillLevelEnum? level,
    double? percentage,
  }) = _SkillDto;
  factory SkillDto.fromJson(Map<String, dynamic> json) =>
      _$SkillDtoFromJson(json);

  factory SkillDto.fromDomain(Skill _) => SkillDto(
        name: _.name,
        information: _.information,
        level: _.level,
        percentage: _.percentage,
      );

  Skill toDomain() => Skill(
        name: name,
        information: information,
        level: level,
        percentage: percentage,
      );
}

@freezed
class ProjectSectionDto with _$ProjectSectionDto {
  const ProjectSectionDto._();
  const factory ProjectSectionDto({
    @Default('Projects') String title,
    @Default([]) List<ProjectDto> projects,
  }) = _ProjectSectionDto;
  factory ProjectSectionDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectSectionDtoFromJson(json);

  factory ProjectSectionDto.fromDomain(ProjectSection _) => ProjectSectionDto(
        title: _.title,
        projects: _.projects.map((e) => ProjectDto.fromDomain(e)).toList(),
      );

  ProjectSection toDomain() => ProjectSection(
        title: title,
        projects: projects.map((e) => e.toDomain()).toList(),
      );
}

@freezed
class ProjectDto with _$ProjectDto {
  const ProjectDto._();
  const factory ProjectDto({
    required String title,
    String? subtitle,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isPresent,
    String? description,
  }) = _ProjectDto;
  factory ProjectDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectDtoFromJson(json);

  factory ProjectDto.fromDomain(Project _) => ProjectDto(
        title: _.title,
        subtitle: _.subtitle,
        startDate: _.startDate,
        endDate: _.endDate,
        isPresent: _.isPresent,
        description: _.description,
      );

  Project toDomain() => Project(
        title: title,
        subtitle: subtitle,
        startDate: startDate,
        endDate: endDate,
        isPresent: isPresent,
        description: description,
      );
}

@freezed
class CertificateSectionDto with _$CertificateSectionDto {
  const CertificateSectionDto._();
  const factory CertificateSectionDto({
    @Default('Certificate') String title,
    @Default([]) List<CertificateDto> certificates,
  }) = _CertificateSectionDto;
  factory CertificateSectionDto.fromJson(Map<String, dynamic> json) =>
      _$CertificateSectionDtoFromJson(json);

  factory CertificateSectionDto.fromDomain(CertificateSection _) =>
      CertificateSectionDto(
        title: _.title,
        certificates:
            _.certificates.map((e) => CertificateDto.fromDomain(e)).toList(),
      );

  CertificateSection toDomain() => CertificateSection(
        title: title,
        certificates: certificates.map((e) => e.toDomain()).toList(),
      );
}

@freezed
class CertificateDto with _$CertificateDto {
  const CertificateDto._();
  const factory CertificateDto({
    /// Degree / Field of Study / Exchange Semester
    String? title,

    /// School / University
    String? school,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isPresent,
    String? description,
  }) = _CertificateDto;
  factory CertificateDto.fromJson(Map<String, dynamic> json) =>
      _$CertificateDtoFromJson(json);

  factory CertificateDto.fromDomain(Certificate _) => CertificateDto(
        title: _.title,
        school: _.school,
        startDate: _.startDate,
        endDate: _.endDate,
        isPresent: _.isPresent,
        description: _.description,
      );

  Certificate toDomain() => Certificate(
        title: title,
        school: school,
        startDate: startDate,
        endDate: endDate,
        isPresent: isPresent,
        description: description,
      );
}

@freezed
class LanguageSectionDto with _$LanguageSectionDto {
  const LanguageSectionDto._();
  const factory LanguageSectionDto({
    @Default('Language') String title,
    @Default([]) List<LanguageDto> languages,
  }) = _LanguageSectionDto;
  factory LanguageSectionDto.fromJson(Map<String, dynamic> json) =>
      _$LanguageSectionDtoFromJson(json);

  factory LanguageSectionDto.fromDomain(LanguageSection _) =>
      LanguageSectionDto(
        title: _.title,
        languages: _.languages.map((e) => LanguageDto.fromDomain(e)).toList(),
      );

  LanguageSection toDomain() => LanguageSection(
        title: title,
        languages: languages.map((e) => e.toDomain()).toList(),
      );
}

@freezed
class LanguageDto with _$LanguageDto {
  const LanguageDto._();
  const factory LanguageDto({
    /// Degree / Field of Study / Exchange Semester
    String? title,
    String? description,
    LanguageLevelEnum? level,
    double? percentage,
  }) = _LanguageDto;
  factory LanguageDto.fromJson(Map<String, dynamic> json) =>
      _$LanguageDtoFromJson(json);

  factory LanguageDto.fromDomain(Language _) => LanguageDto(
        title: _.title,
        description: _.description,
        level: _.level,
        percentage: _.percentage,
      );

  Language toDomain() => Language(
        title: title,
        description: description,
        level: level,
        percentage: percentage,
      );
}

@freezed
class InterestSectionDto with _$InterestSectionDto {
  const InterestSectionDto._();
  const factory InterestSectionDto({
    @Default('Interests') String title,
    @Default([]) List<InterestDto> interests,
  }) = _InterestSectionDto;
  factory InterestSectionDto.fromJson(Map<String, dynamic> json) =>
      _$InterestSectionDtoFromJson(json);

  factory InterestSectionDto.fromDomain(InterestSection _) =>
      InterestSectionDto(
        title: _.title,
        interests: _.interests.map((e) => InterestDto.fromDomain(e)).toList(),
      );

  InterestSection toDomain() => InterestSection(
        title: title,
        interests: interests.map((e) => e.toDomain()).toList(),
      );
}

@freezed
class InterestDto with _$InterestDto {
  const InterestDto._();
  const factory InterestDto({
    String? title,
  }) = _InterestDto;
  factory InterestDto.fromJson(Map<String, dynamic> json) =>
      _$InterestDtoFromJson(json);

  factory InterestDto.fromDomain(Interest _) => InterestDto(
        title: _.title,
      );

  Interest toDomain() => Interest(title: title);
}

@freezed
class AwardSectionDto with _$AwardSectionDto {
  const AwardSectionDto._();
  const factory AwardSectionDto({
    @Default('Awards') String title,
    @Default([]) List<AwardDto> awards,
  }) = _AwardSectionDto;
  factory AwardSectionDto.fromJson(Map<String, dynamic> json) =>
      _$AwardSectionDtoFromJson(json);

  factory AwardSectionDto.fromDomain(AwardSection _) => AwardSectionDto(
        awards: _.awards.map((e) => AwardDto.fromDomain(e)).toList(),
        title: _.title,
      );

  AwardSection toDomain() => AwardSection(
        awards: awards.map((e) => e.toDomain()).toList(),
        title: title,
      );
}

@freezed
class AwardDto with _$AwardDto {
  const AwardDto._();
  const factory AwardDto({
    String? award,
    String? issuer,
    DateTime? awardDate,
    String? description,
  }) = _AwardDto;
  factory AwardDto.fromJson(Map<String, dynamic> json) =>
      _$AwardDtoFromJson(json);

  factory AwardDto.fromDomain(Award _) => AwardDto(
        award: _.award,
        awardDate: _.awardDate,
        description: _.description,
        issuer: _.issuer,
      );

  Award toDomain() => Award(
        award: award,
        awardDate: awardDate,
        description: description,
        issuer: issuer,
      );
}
