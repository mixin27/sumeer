import 'package:flutter/services.dart' show rootBundle;

import 'package:pdf/widgets.dart' as pw;

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/shared.dart';

Future<ResumeData> getDummyResumeData() async {
  final profileImage = pw.MemoryImage(
    (await rootBundle.load(AssetPaths.resumeProfile)).buffer.asUint8List(),
  );

  final dummyResumeData = ResumeData(
    profileImage: profileImage,
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
        Skill(skill: 'NodeJS', percentage: 0.5, level: SkillLevel.skillfull),
      ],
    ),
    languages: language,
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
          'I am a motivated IT graduate looking forward to expanding my knowledge and career in the IT sector. Along with that, I want to experience working with professionals in the field so that I am able to stay up-to-date and learn the best practices that should be used while working in the IT sector. As for me, some of my greatest strengths are communicating and working alongside my peers.',
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
    Language(title: "English", description: "Level1"),
    Language(title: "Chinese", description: "A1"),
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
