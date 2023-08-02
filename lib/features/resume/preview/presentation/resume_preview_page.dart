import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

@RoutePage()
class ResumePreviewPage extends StatefulWidget {
  const ResumePreviewPage({super.key, required this.resume});

  final ResumeTemplate resume;

  @override
  State<ResumePreviewPage> createState() => _ResumePreviewPageState();
}

class _ResumePreviewPageState extends State<ResumePreviewPage> {
  ResumeData? _dummyResumeData;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    final dummyResumeData = await getDummyResumeData();
    setState(() {
      _dummyResumeData = dummyResumeData;
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
