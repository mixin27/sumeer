import 'package:sumeer/features/resume/feat_resume.dart';

Future<ResumeData> getDummyResumeData() async {
  // final profileImage = pw.MemoryImage(
  //   (await rootBundle.load(AssetPaths.resumeProfile)).buffer.asUint8List(),
  // );

  final dummyResumeData = ResumeData(
    // TODO: profile image
    profileImage: "",
    personalDetail: const PersonalDetailSection(
      fullName: "KYAW ZAYAR TUN",
      jobTitle: "Mobile Developer",
      email: "kyawzayartun.sbs@gmail.com",
      phone: "+959 985 753 791",
      address: "Yangon, Myanmar",
      links: [
        PersonalLink(
          name: 'GitHub',
          url: 'https://www.github.com/mixin27',
          codePoint: 0xe157,
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
          skill: 'Android',
          percentage: 0.7,
          level: SkillLevel.experienced,
          information: 'Java, Kotlin',
        ),
        Skill(skill: 'Flutter', percentage: 0.8, level: SkillLevel.experienced),
        Skill(
            skill: 'Strategic thinking and problem-solving',
            percentage: 0.5,
            level: SkillLevel.skillfull),
        Skill(
            skill: 'Relationship building and networking',
            percentage: 0.5,
            level: SkillLevel.skillfull),
        Skill(
            skill: 'Effective communication and negotiatior',
            percentage: 0.5,
            level: SkillLevel.skillfull),
        Skill(
            skill: 'Creative and innovative thinking',
            percentage: 0.5,
            level: SkillLevel.skillfull),
      ],
    ),
    languages: language,
    interest: interest,
    certificate: certificate,
    award: award,
  );

  return dummyResumeData;
}

const profileData = ProfileSection(title: "Profile", contents: [
  'Senior Wev Developer specilizing in fornt end development. Experienced with all stages of the development cycle for dynamic web projects. Well-versed in numerous programming languages including HTMLS,PHP OOP, Javaspript, CSS, MySQL. Strong background in project management and customer relations.',
]);

final experienceData = ExperienceSection(
  title: 'Work Experience',
  experiences: [
    Experience(
      employer: const Employer(name: "SYSTEMATIC Business Solution"),
      jobTitle: "Mobile Developer",
      city: 'Hlaing',
      country: 'Myanmar',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      isPresent: true,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    Experience(
      employer: const Employer(name: "eTrade Myanmar"),
      jobTitle: "Developer",
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

const language = LanguageSection(
  title: 'Languages',
  languages: [
    Language(
      title: "English",
      description: "Level1",
      level: LanguageLevel.elementary,
      percentage: 20,
    ),
    Language(
      title: "Chinese",
      description: "A1",
      level: LanguageLevel.limitedWorking,
      percentage: 50.5,
    ),
  ],
);
final certificate = CertificateSection(
  title: 'Certifications',
  certificates: [
    Certificate(
      title: 'PHP Framework(certificate)',
      school: 'Zwnd, Fodegnier Symfony',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    Certificate(
      title: 'Programming Languages',
      school:
          'Java, Kotlin, Flutter, MySQL, Dart, C#, Firebase, SQL, Python, Java',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ],
);

const interest = InterestSection(
  title: 'Interests',
  interests: [
    Interest(title: 'Travelling'),
    Interest(title: 'Playing Guitar'),
  ],
);

final award = AwardSection(
  title: 'Awards',
  awards: [
    Award(
      award: 'Outattanding Business Student Award',
      issuer: "University of Southern Calfomia",
      awardDate: DateTime.parse("2014-03-04"),
    ),
    Award(
      award: 'Dan\'s List',
      issuer: "University of Calfomia",
      awardDate: DateTime.now(),
    ),
  ],
);
