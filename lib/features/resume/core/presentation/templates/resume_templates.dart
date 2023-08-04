import 'dart:typed_data';

import 'package:pdf/pdf.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/constants/asset_paths.dart';
export 'resume_template_1.dart';
export 'resume_template_6.dart';
export 'resume_template_7.dart';

typedef LayoutCallbackWithData = Future<Uint8List> Function(
  PdfPageFormat pageFormat,
  GenerateDocParams params,
  ResumeData resumeData,
);

enum DocumentType { resume, cv }

class ResumeTemplate {
  /// Template name
  final String name;

  // Templage file name
  final String file;

  final String thumbnail;

  final LayoutCallbackWithData builder;

  final bool needsData;

  final DocumentType type;

  const ResumeTemplate(
    this.name,
    this.file,
    this.thumbnail,
    this.builder, {
    this.needsData = false,
    this.type = DocumentType.resume,
  });
}

const resumeTemplates = <ResumeTemplate>[
  ResumeTemplate(
    'Resume Template 1',
    'resume_template_1.dart',
    AssetPaths.resumeTemplate1,
    generateTemplate1,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'Resume Template 2',
    'resume_template_2.dart',
    AssetPaths.resumeTemplate2,
    generateTemplate2,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'Resume Template 3',
    'resume_template_3.dart',
    AssetPaths.resumeTemplate3,
    generateTemplate3,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'Resume Template 2',
    'resume_template_2.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate2,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'Resume Template 1',
    'resume_template_1.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate1,
    type: DocumentType.cv,
  ),
  ResumeTemplate(
    'Resume Template 6',
    'resume_template_6.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate6,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'Resume Template 7',
    'resume_template_7.dart',
    'assets/images/templates/resume_template_1.jpg',
    generateTemplate7,
    type: DocumentType.resume,
  ),
];
