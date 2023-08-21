import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/config/routes/app_router.gr.dart';
import 'package:sumeer/utils/utils.dart';
import '../../../data_input/feat_data_input.dart';

@RoutePage()
class ResumePreviewPage extends HookConsumerWidget {
  const ResumePreviewPage({super.key, required this.resume, this.resumeData});

  final ResumeTemplate resume;
  final ResumeData? resumeData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // saveLocalStorage(Uint8List data) async {
    //   final permissionStatus = await Permission.storage.status;
    //   if (permissionStatus.isDenied) {
    //     // Here just ask for the permission for the first time
    //     await Permission.storage.request();

    //     // I noticed that sometimes popup won't show after user press deny
    //     // so I do the check once again but now go straight to appSettings
    //     if (permissionStatus.isDenied) {
    //       await openAppSettings();
    //     }
    //   } else if (permissionStatus.isPermanentlyDenied) {
    //     // Here open app settings for user to manually enable permission in case
    //     // where permission was permanently denied
    //     await openAppSettings();
    //   } else {
    //     // Do stuff that require permission here
    //     final String dir = await ExternalPath.getExternalStoragePublicDirectory(
    //         ExternalPath.DIRECTORY_DOWNLOADS);
    //     final String path = '$dir/${resume.name}.pdf';
    //     final File file = File(path);
    //     await file.writeAsBytes(data);
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(resume.name),
      ),
      body: Stack(
        children: [
          InteractiveViewer(
            child: PdfPreview(
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
              actions: [
                IconButton(
                  onPressed: () {
                    //
                    context.router.push(const TemplatesRoute());
                  },
                  icon: Icon(
                    Icons.change_circle,
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                PdfPreviewAction(
                  icon: Icon(
                    Icons.save,
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: (context, fn, format) async {
                    //if you call fn(format), you'll get Future<UInt8List>
                    // var data = await fn(format);
                    // saveLocalStorage(data);
                    // final oldResumeData = ref.watch(resumeDataProvider);
                    // ref.read(resumeDataProvider.notifier).update(
                    //       (state) =>
                    //           oldResumeData?.copyWith(templateId: resume.id),
                    //     );

                    var uid = ref
                        .watch(authRepositoryProvider)
                        .currentUser
                        ?.uid
                        .toString();
                    final resumeData = ref.watch(resumeDataProvider);

                    if (resumeData != null) {
                      if (uid == null) {
                        final oldData = await ref
                            .watch(resumeRepositoryProvider)
                            .getLocalData();

                        final exist = oldData.firstWhere(
                          (element) => element.resumeId == resumeData.resumeId,
                          orElse: () => ResumeData.empty(),
                        );

                        if (exist.resumeId.isEmptyOrNull) {
                          ref.read(resumeRepositoryProvider).saveToLocal(
                            [
                              resumeData.copyWith(templateId: resume.id),
                              ...oldData
                            ],
                          );
                        } else {
                          final items = oldData
                              .where((element) =>
                                  element.resumeId != resumeData.resumeId)
                              .toList();
                          ref.read(resumeRepositoryProvider).saveToLocal(
                            [
                              resumeData.copyWith(templateId: resume.id),
                              ...items
                            ],
                          );
                        }
                      } else {
                        await ref
                            .read(upsertResumeDataNotifierProvider.notifier)
                            .upsertResumeData(
                              userId: uid,
                              resumeData: resumeData,
                              resumeDocId: resumeData.resumeId,
                            );
                      }

                      ref.read(resumeDataProvider.notifier).state = null;
                      ref.read(resumeDataProvider.notifier).state = null;
                      ref.read(resumeDataProvider.notifier).state = null;
                      ref.read(skillSectionProvider.notifier).state = null;
                      ref.read(educationSectionProvider.notifier).state = null;
                      ref.read(experienceSectionProvider.notifier).state = null;
                      ref.read(resumeModelIdProvider.notifier).state = '';
                      ref.read(profileSectionProvider.notifier).state = null;

                      if (context.mounted) {
                        context.router.replaceAll([const HomeRoute()]);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
