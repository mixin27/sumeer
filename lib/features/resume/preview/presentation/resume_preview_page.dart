import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/config/routes/app_router.gr.dart';
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
    return WillPopScope(
      onWillPop: () async {
        ref.read(resumeDataProvider.notifier).state = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(resume.name),
          // actions: [
          //   Button1(
          //     text: 'Save',
          //     onPressed: () async {
          //       final oldResumeData = ref.watch(resumeDataProvider);

          //       ref.read(resumeDataProvider.notifier).update(
          //             (state) => oldResumeData?.copyWith(templateId: resume.id),
          //           );
          //       var uid =
          //           ref.watch(authRepositoryProvider).currentUser?.uid.toString();
          //       await ref
          //           .read(cloudFirestoreProvider)
          //           .collection("sumeer")
          //           .doc(uid)
          //           .collection("user")
          //           .doc(ref.watch(resumeModelIdProvider))
          //           .set(
          //             ref.watch(resumeDataProvider)?.toJson() ?? {},
          //           );
          //     },
          //   )
          // ],
        ),
        body: Stack(
          children: [
            PdfPreview(
              pageFormats: const <String, pw.PdfPageFormat>{
                'A4': pw.PdfPageFormat.a4,
              },
              canChangePageFormat: false,

              // useActions: false,
              scrollViewDecoration: const BoxDecoration(
                color: Color(0xFFF1F2FD),
              ),
              onPrinted: (context) {},
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
            Positioned(
              bottom: 0,
              left: 30,
              child: IconButton(
                  onPressed: () {
                    //
                    context.router.push(const TemplatesRoute());
                  },
                  icon: Icon(
                    Icons.change_circle,
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
            ),
            Positioned(
              bottom: 0,
              right: 30,
              child: IconButton(
                  onPressed: () async {
                    //
                    final oldResumeData = ref.watch(resumeDataProvider);
                    ref.read(resumeDataProvider.notifier).update(
                          (state) =>
                              oldResumeData?.copyWith(templateId: resume.id),
                        );
                    var uid = ref
                        .watch(authRepositoryProvider)
                        .currentUser
                        ?.uid
                        .toString();
                    await ref
                        .read(cloudFirestoreProvider)
                        .collection("sumeer")
                        .doc(uid)
                        .collection("user")
                        .doc(ref.watch(resumeDataProvider)?.resumeId)
                        .set(
                          ref.watch(resumeDataProvider)?.toJson() ?? {},
                        )
                        .then((value) => {
                              context.router.replaceAll([const HomeRoute()]),
                              ref.read(resumeDataProvider.notifier).state = null
                            });
                  },
                  icon: Icon(
                    Icons.save,
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
