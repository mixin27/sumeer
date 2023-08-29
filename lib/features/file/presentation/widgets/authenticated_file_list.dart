import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/features/templates/shared/provider.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/logger/logger.dart';
import 'file_list_item.dart';

class AuthenticatedFileList extends HookConsumerWidget {
  const AuthenticatedFileList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authRepositoryProvider).currentUser;
    final resumeDataList =
        ref.watch(resumeDataListProvider(userId: currentUser?.uid ?? ""));

    if (currentUser == null) return const SizedBox();

    return resumeDataList.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(
            child: Text(
              'No Data!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (cxt, idx) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: FileListItem(
                resumeData: data[idx],
                onTap: (resumeData) {
                  tLog(resumeData.profileImage);
                  ref
                      .read(resumeDataProvider.notifier)
                      .update((state) => resumeData);

                  final resumeTemplate =
                      getResumeTemplateById(resumeData.templateId);
                  ref
                      .read(resumeTemplateProvider.notifier)
                      .update((state) => resumeTemplate);

                  context.router.push(
                    const ResumePreviewRoute(
                        // resume: getResumeTemplateById(
                        //   resumeData.templateId,
                        // ),
                        // resumeData: resumeData,
                        ),
                  );
                },
                onEdit: (resumeData) {
                  ref.read(resumeDataProvider.notifier).state = resumeData;
                  ref.read(resumeModelIdProvider.notifier).state =
                      resumeData.resumeId ?? '';
                  ref
                      .read(imageDataProvider.notifier)
                      .update((state) => resumeData.profileImage);

                  context.router.push(const DetailRoute());
                },
                onDelete: (resumeData) async {
                  var uid = ref
                      .watch(authRepositoryProvider)
                      .currentUser
                      ?.uid
                      .toString();

                  if (uid == null && resumeData.resumeId == null) {
                    return;
                  }
                  ref.read(resumeRepositoryProvider).removeResumeData(
                        userId: uid!,
                        resumeDocId: resumeData.resumeId!,
                      );
                },
              ),
            );
          },
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
