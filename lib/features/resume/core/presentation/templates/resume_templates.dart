import 'dart:typed_data';

import 'package:pdf/pdf.dart';

import 'package:sumeer/features/resume/core/presentation/templates/resume_template_3.dart';
import 'package:sumeer/features/resume/feat_resume.dart';

export 'resume_template_1.dart';

typedef LayoutCallbackWithData = Future<Uint8List> Function(
  PdfPageFormat pageFormat,
  GenerateDocParams params,
  ResumeData resumeData,
);

class ResumeTemplate {
  /// Template name
  final String name;

  // Templage file name
  final String file;

  final String thumbnail;

  final LayoutCallbackWithData builder;

  final bool needsData;

  const ResumeTemplate(
    this.name,
    this.file,
    this.thumbnail,
    this.builder, [
    this.needsData = false,
  ]);
}

const resumeTemplates = <ResumeTemplate>[
  ResumeTemplate(
    'Resume Template 1',
    'resume_template_1.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate1,
  ),
  ResumeTemplate(
    'Resume Template 2',
    'resume_template_2.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate2,
  ),
  ResumeTemplate(
    'Resume Template 3',
    'resume_template_3.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate3,
  ),
  ResumeTemplate(
    'Resume Template 2',
    'resume_template_2.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate2,
  ),
  ResumeTemplate(
    'Resume Template 1',
    'resume_template_1.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate1,
  ),
  ResumeTemplate(
    'Resume Template 2',
    'resume_template_2.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate2,
  ),
];
