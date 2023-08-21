import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/features.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
import 'package:sumeer/widgets/widgets.dart';

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
          return Card(
            color: Theme.of(context).colorScheme.background,
            elevation: 0.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.background,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: data.value[idx].profileImage ?? '',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.camera_alt,
                          color: Colors.grey.withOpacity(0.3),
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.value[idx].personalDetail?.fullName ?? ''),
                      Text(
                        data.value[idx].personalDetail?.email.toString() ?? '',
                      ),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            icon: const Icon(Icons.edit),
                            // style: outlineButtonStyle,
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundColor:
                                  const Color.fromARGB(255, 237, 245, 252),
                              minimumSize: const Size(88, 36),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),

                            onPressed: () {
                              // ref.read(resumeDataProvider.notifier).state =
                              //     data[idx];
                              // ref
                              //     .read(resumeModelIdProvider.notifier)
                              //     .state = data[idx].resumeId ?? '';
                              // context.router.push(const DetailRoute());
                            },
                            label: const Text('Edit'),
                          ),
                          horSpace(8),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.edit),
                            // style: outlineButtonStyle,
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundColor:
                                  const Color.fromARGB(255, 237, 245, 252),
                              minimumSize: const Size(88, 36),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),

                            onPressed: () async {
                              tLog(data.value[idx]);

                              ref
                                  .read(resumeDataProvider.notifier)
                                  .update((state) => data.value[idx]);
                              context.router.push(
                                ResumePreviewRoute(
                                  resume: getResumeTemplateById(
                                    data.value[idx].templateId,
                                  ),
                                  resumeData: data.value[idx],
                                ),
                              );
                            },
                            label: const Text('View'),
                          ),
                          horSpace(8),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.preview),
                            // style: outlineButtonStyle,
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              backgroundColor:
                                  const Color.fromARGB(255, 237, 245, 252),
                              minimumSize: const Size(88, 36),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),

                            onPressed: () async {
                              final oldData = await ref
                                  .read(resumeRepositoryProvider)
                                  .getLocalData();
                              final items = oldData
                                  .where(
                                    (element) =>
                                        element.resumeId !=
                                        data.value[idx].resumeId,
                                  )
                                  .toList();

                              await ref
                                  .read(resumeRepositoryProvider)
                                  .clearLocalData();
                              await ref
                                  .read(resumeRepositoryProvider)
                                  .saveToLocal(items);

                              getData();

                              // to delete
                              // var uid = ref
                              //     .watch(authRepositoryProvider)
                              //     .currentUser
                              //     ?.uid
                              //     .toString();

                              // if (uid == null &&
                              //     data.value[idx].resumeId == null) {
                              //   return;
                              // }
                              // ref
                              //     .read(resumeRepositoryProvider)
                              //     .removeResumeData(
                              //       userId: uid!,
                              //       resumeDocId: data.value[idx].resumeId!,
                              //     );
                            },
                            label: const Text('Delete'),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
