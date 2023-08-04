import 'dart:typed_data';

import 'package:pdf/pdf.dart';

import 'package:sumeer/features/resume/core/presentation/templates/resume_template_5.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/constants/asset_paths.dart';
import 'resume_template_4.dart';

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
    'Resume Template 4',
    'resume_template_4.dart',
    AssetPaths.resumeTemplate4,
    generateTemplate4,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'Resume Template 5',
    'resume_template_5.dart',
    AssetPaths.resumeTemplate5,
    generateTemplate5,
    type: DocumentType.cv,
  ),
  ResumeTemplate(
    'Resume Template 6',
    'resume_template_6.dart',
    AssetPaths.resumeTemplate6,
    generateTemplate6,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'Resume Template 7',
    'resume_template_7.dart',
    AssetPaths.resumeTemplate7,
    generateTemplate6,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'Resume Template 8',
    'resume_template_8.dart',
    AssetPaths.resumeTemplate8,
    generateTemplate8,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'Resume Template 9',
    'resume_template_8.dart',
    AssetPaths.resumeTemplate9,
    generateTemplate9,
    type: DocumentType.resume,
  ),
  ResumeTemplate(
    'CV Template 1',
    'cv_template_1.dart',
    AssetPaths.cvTemplate1,
    generateCVTemplate1,
    type: DocumentType.cv,
  ),
];
