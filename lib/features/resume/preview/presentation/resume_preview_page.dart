import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

@RoutePage()
class ResumePreviewPage extends StatelessWidget {
  const ResumePreviewPage({super.key, required this.resume, this.resumeData});

  final ResumeTemplate resume;
  final ResumeData? resumeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resume.name),
      ),
      body: PdfPreview(
        pageFormats: const <String, pw.PdfPageFormat>{
          'A4': pw.PdfPageFormat.a4,
        },
        canChangePageFormat: false,
        // useActions: false,
        scrollViewDecoration: const BoxDecoration(
          color: Color(0xFFF1F2FD),
        ),
        allowPrinting: false,
        canChangeOrientation: false,
        canDebug: false,
        build: (format) => resume.builder(
          format,
          GenerateDocParams(
            title: 'RESUME',
            author: resumeData?.personalDetail?.fullName,
          ),
          resumeData ?? ResumeData.empty(),
        ),
      ),
    );
  }
}
