import 'package:sumeer/features/resume/feat_resume.dart';

Future<ResumeData> getDummyResumeData() async {
  // final profileImage = pw.MemoryImage(
  //   (await rootBundle.load(AssetPaths.resumeProfile)).buffer.asUint8List(),
  // );

  final dummyResumeData = ResumeData(
    // profile image
    profileImage: 'https://www.nfet.net/nfet.jpg',
    personalDetail: const PersonalDetailSection(
      firstName: 'Kyaw',
      lastName: 'Zayar Tun',
      // fullName: "KYAW ZAYAR TUN",
      jobTitle: 'Mobile Developer',
      email: 'kyawzayartun.sbs@gmail.com',
      phone: '+959 985 753 791',
      address: 'Yangon, Myanmar',
      personalInfo: PersonalInformation(
        dateOfBirth: '14-02-2000',
        drivingLicense: 'Plane-AC0012',
        gender: 'Male',
        identityNo: 'YGN099122',
        martialStatus: 'Single',
        nationality: 'Myanmar',
        militaryService: 'Head',
      ),
      links: [
        PersonalLink(
          name: 'GitHub',
          url: 'https://www.github.com/mixin27',
          codePoint: 0xe157,
        ),
        PersonalLink(
          name: 'Facebook',
          url: 'https://www.facebook.com/mixin27',
        ),
      ],
    ),
    profile: profileData,
    experience: experienceData,
    education: educationData,
    skill: const SkillSection(
      title: 'Skills',
      skills: [
        Skill(
          name: 'Android',
          percentage: 60,
          level: SkillLevelEnum.experienced,
          information: 'Java, Kotlin',
        ),
        Skill(
            name: 'Flutter', percentage: 60, level: SkillLevelEnum.experienced),
        Skill(
            name: 'Strategic thinking and problem-solving',
            percentage: 50,
            level: SkillLevelEnum.skillfull),
        Skill(
            name: 'Relationship building and networking',
            percentage: 40,
            level: SkillLevelEnum.skillfull),
        Skill(
            name: 'Effective communication and negotiatior',
            percentage: 60,
            level: SkillLevelEnum.skillfull),
        Skill(
            name: 'Creative and innovative thinking',
            percentage: 90,
            level: SkillLevelEnum.skillfull),
      ],
    ),
    languages: languageSection,
    interest: interestSection,
    certificate: certificateSection,
    award: awardSection,
  );

  return dummyResumeData;
}

const profileData = ProfileSection(title: 'Profile', contents: [
  'Senior Wev Developer specilizing in fornt end development. Experienced with all stages of the development cycle for dynamic web projects. Well-versed in numerous programming languages including HTMLS,PHP OOP, Javaspript, CSS, MySQL. Strong background in project management and customer relations.',
]);

final experienceData = ExperienceSection(
  title: 'Work Experience',
  experiences: [
    Experience(
      employer: const Employer(name: 'SYSTEMATIC Business Solution'),
      jobTitle: 'Mobile Developer',
      city: 'Hlaing',
      country: 'Myanmar',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      isPresent: true,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    Experience(
      employer: const Employer(name: 'eTrade Myanmar'),
      jobTitle: 'Developer',
      city: 'Hlaing',
      country: 'Myanmar',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ],
);

final educationData = EducationSection(
  title: 'Education',
  educations: [
    Education(
      degree: 'Bachelor of Computer Science',
      school: 'University of Computer Studies, Yangon',
      city: 'Shwe Pyi Thar',
      country: 'Myanmar',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      isPresent: false,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    // Education(
    //   degree: 'Bachelor of Computer Science',
    //   school: 'University of Computer Studies, Yangon',
    //   city: 'Shwe Pyi Thar',
    //   country: 'Myanmar',
    //   startDate: DateTime.now(),
    //   endDate: DateTime.now(),
    //   isPresent: false,
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    // ),
  ],
);

const languageSection = LanguageSection(
  title: 'Languages',
  languages: [
    Language(
      title: 'English',
      description: 'Level1',
      level: LanguageLevelEnum.elementary,
      percentage: 80,
    ),
    Language(
      title: 'Chinese',
      description: 'A1',
      level: LanguageLevelEnum.limitedWorking,
      percentage: 50.5,
    ),
  ],
);
final certificateSection = CertificateSection(
  title: 'Certifications',
  certificates: [
    Certificate(
      title: 'Web Development Certificate',
      school: 'Realistic Infoteach Group(RGI)',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    Certificate(
      title: 'Helth Consulte(PHP)',
      school: '',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    Certificate(
      title: 'Internship Completion Letter(Sept 2020 to Nov 2020)',
      school: '',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ],
);

const interestSection = InterestSection(
  title: 'Interests',
  interests: [
    Interest(title: 'Travelling'),
    Interest(title: 'Playing Guitar'),
  ],
);

final awardSection = AwardSection(
  title: 'Awards',
  awards: [
    Award(
      award: 'Outattanding Business Student Award',
      issuer: 'University of Southern Calfomia',
      awardDate: DateTime.parse('2014-03-04'),
    ),
    Award(
      award: 'Dan\'s List',
      issuer: 'University of Calfomia',
      awardDate: DateTime.now(),
    ),
  ],
);
