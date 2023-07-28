import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:printing/printing.dart';

import 'package:sumeer/features/data_input/shared/form_provider.dart';
import 'package:sumeer/features/resume/feat_resume.dart';

@RoutePage()
class ResumePreviewPage extends ConsumerStatefulWidget {
  const ResumePreviewPage({super.key, required this.resume});

  final ResumeTemplate resume;

  @override
  ConsumerState<ResumePreviewPage> createState() => _ResumePreviewPageState();
}

class _ResumePreviewPageState extends ConsumerState<ResumePreviewPage> {
  ResumeData? _dummyResumeData;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    Future.microtask(() {
      ref.read(resumeDataProvider.notifier).state = ResumeData(
        profileImage: ref.watch(resumeDataProvider)?.profileImage,
        personalDetail: ref.watch(resumeDataProvider)?.personalDetail,
        profile: profileData,
        experience: experienceData,
        education: educationData,
        project: ref.watch(resumeDataProvider)?.project,
        skill: const SkillSection(
          title: 'Skills',
          skills: [
            Skill(
              skill: 'Android(Java, Kotlin)',
              percentage: 0.7,
              level: SkillLevel.experienced,
            ),
            Skill(
                skill: 'Flutter',
                percentage: 0.8,
                level: SkillLevel.experienced),
            Skill(
                skill: 'Project Management',
                percentage: 0.5,
                level: SkillLevel.skillfull),
            Skill(
                skill: 'Strong decision maker',
                percentage: 0.5,
                level: SkillLevel.skillfull),
            Skill(
                skill: 'Creative design',
                percentage: 0.5,
                level: SkillLevel.skillfull),
            Skill(
                skill: 'Inovation',
                percentage: 0.5,
                level: SkillLevel.skillfull),
            Skill(
                skill: 'Complex problem solver',
                percentage: 0.5,
                level: SkillLevel.skillfull),
          ],
        ),
        languages: language,
        certificate: certificate,
      );
      final dummyResumeData = ref.watch(resumeDataProvider);
      setState(() {
        _dummyResumeData = dummyResumeData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.resume.name),
      ),
      body: _dummyResumeData != null
          ? PdfPreview(
              // canChangePageFormat: false,
              // useActions: false,
              scrollViewDecoration: const BoxDecoration(
                color: Color(0xFFF1F2FD),
              ),
              allowPrinting: false,
              canChangeOrientation: false,
              canDebug: false,
              build: (format) => widget.resume.builder(
                format,
                const GenerateDocParams(
                  title: 'RESUME',
                  author: 'Kyaw Zayar Tun',
                ),
                _dummyResumeData!,
              ),
            )
          : const Center(
              child: Text('Pdf Preview'),
            ),
    );
  }
}
