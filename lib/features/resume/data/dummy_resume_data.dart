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
    experience: ExperienceSection(
      title: 'Work Experience',
      experiences: [
        Experience(
          jobTitle: "SYSTEMATIC Business Solution",
          city: 'Hlaing',
          country: 'Myanmar',
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          isPresent: true,
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        Experience(
          jobTitle: "eTrade Myanmar",
          city: 'Hlaing',
          country: 'Myanmar',
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        Experience(
          jobTitle: "IrraHub",
          city: 'Yangon',
          country: 'Myanmar',
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        Experience(
          jobTitle: "IrraHub",
          city: 'Yangon',
          country: 'Myanmar',
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        // Experience(
        //   jobTitle: "IrraHub",
        //   city: 'Yangon',
        //   country: 'Myanmar',
        //   startDate: DateTime.now(),
        //   endDate: DateTime.now(),
        //   description:
        //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        // ),
      ],
    ),
    education: EducationSection(
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
      ],
    ),
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
  );

  return dummyResumeData;
}
