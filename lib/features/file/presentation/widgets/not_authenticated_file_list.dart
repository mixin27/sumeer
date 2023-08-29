import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/features.dart';
import 'package:sumeer/features/templates/shared/provider.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
import 'file_list_item.dart';

class NoAuthenticatedFileList extends HookConsumerWidget {
  const NoAuthenticatedFileList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = useState<List<ResumeData>>([]);

    Future<void> getData() async {
      final result = await ref.read(resumeRepositoryProvider).getLocalData();
      data.value = result;
    }

    useEffect(() {
      getData();
      return null;
    }, []);

    return ListView.builder(
      itemCount: data.value.length,
      itemBuilder: (cxt, idx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: FileListItem(
            resumeData: data.value[idx],
            onTap: (resumeData) {
              tLog(resumeData);

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
              final oldData =
                  await ref.read(resumeRepositoryProvider).getLocalData();
              final items = oldData
                  .where(
                    (element) => element.resumeId != resumeData.resumeId,
                  )
                  .toList();

              await ref.read(resumeRepositoryProvider).clearLocalData();
              await ref.read(resumeRepositoryProvider).saveToLocal(items);
              getData();
            },
          ),
        );
      },
    );
  }
}
