import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/widgets/button1.dart';

import '../../../auth/feat_auth.dart';
import '../../../data_input/feat_data_input.dart';
import '../../../templates/shared/provider.dart';

@RoutePage()
class ResumePreviewPage extends HookConsumerWidget {
  const ResumePreviewPage({super.key, required this.resume, this.resumeData});

  final ResumeTemplate resume;
  final ResumeData? resumeData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resume.name),
        actions: [
          Button1(
            text: 'Save',
            onPressed: () async {
              final oldResumeData = ref.watch(resumeDataProvider);

              ref.read(resumeDataProvider.notifier).update(
                    (state) => oldResumeData?.copyWith(templateId: resume.id),
                  );
              var uid =
                  ref.watch(authRepositoryProvider).currentUser?.uid.toString();
              await ref
                  .read(cloudFirestoreProvider)
                  .collection("sumeer")
                  .doc(uid)
                  .collection("user")
                  .doc(ref.watch(resumeModelIdProvider))
                  .set(
                    ref.watch(resumeDataProvider)?.toJson() ?? {},
                  );
            },
          )
        ],
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
