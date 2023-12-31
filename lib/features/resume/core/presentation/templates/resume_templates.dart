import 'dart:typed_data';

import 'package:pdf/pdf.dart';

import 'package:sumeer/features/resume/core/presentation/templates/resume_template_13.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/constants/asset_paths.dart';

typedef LayoutCallbackWithData = Future<Uint8List> Function(
  PdfPageFormat pageFormat,
  GenerateDocParams params,
  ResumeData resumeData,
);

enum DocumentType { resume, cv }

class ResumeTemplate {
  final String id;

  /// Template name
  final String name;

  // Templage file name
  final String file;

  final String thumbnail;

  final LayoutCallbackWithData builder;

  final bool needsData;

  final DocumentType type;

  const ResumeTemplate(
    this.id,
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
    'resume-template-1',
    'Pdf Built-in',
    'resume_template_1.dart',
    AssetPaths.resumeTemplate1,
    generateTemplate1,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-2',
    'Atlantic Blue · Multi-column resume',
    'resume_template_2.dart',
    AssetPaths.resumeTemplate2,
    generateTemplate2,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-3',
    'Grey Goose · Minimalistic · Simple',
    'resume_template_3.dart',
    AssetPaths.resumeTemplate3,
    generateTemplate3,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-4',
    'Santiago',
    'resume_template_4.dart',
    AssetPaths.resumeTemplate4,
    generateTemplate4,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-5',
    'Gold · Minimalistic',
    'resume_template_5.dart',
    AssetPaths.resumeTemplate5,
    generateTemplate5,
    type: DocumentType.cv,
  ),
  ResumeTemplate(
    'resume-template-6',
    'Space · Creative · Two-column',
    'resume_template_6.dart',
    AssetPaths.resumeTemplate6,
    generateTemplate6,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-7',
    'Toronto',
    'resume_template_7.dart',
    AssetPaths.resumeTemplate7,
    generateTemplate7,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-8',
    'Resume Template 8',
    'resume_template_8.dart',
    AssetPaths.resumeTemplate8,
    generateTemplate8,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-9',
    'Resume Template 9',
    'resume_template_9.dart',
    AssetPaths.resumeTemplate9,
    generateTemplate9,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-10',
    'Resume Template 10',
    'resume_template_10.dart',
    AssetPaths.resumeTemplate10,
    generateTemplate10,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-11',
    'Resume Template 11',
    'resume_template_11.dart',
    AssetPaths.resumeTemplate11,
    generateTemplate11,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-12',
    'Resume Template 12',
    'resume_template_12.dart',
    AssetPaths.resumeTemplate12,
    generateTemplate12,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'resume-template-13',
    'Curriculum Vitae . Myanmar Language',
    'resume_template_13.dart',
    AssetPaths.resumeTemplate13,
    generateTemplate13,
    type: DocumentType.resume,
  ),
];

ResumeTemplate getResumeTemplateById(String? id) {
  final template = resumeTemplates.firstWhere(
    (element) => element.id == id,
    orElse: () => resumeTemplates[0],
  );
  return template;
}
