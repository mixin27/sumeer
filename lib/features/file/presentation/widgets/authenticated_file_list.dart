import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/widgets/widgets.dart';

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
                            imageUrl: data[idx].profileImage ?? '',
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
                          Text(data[idx].personalDetail?.fullName ?? ''),
                          Text(
                            data[idx].personalDetail?.email.toString() ?? '',
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),

                                onPressed: () {
                                  ref.read(resumeDataProvider.notifier).state =
                                      data[idx];
                                  ref
                                      .read(resumeModelIdProvider.notifier)
                                      .state = data[idx].resumeId ?? '';
                                  context.router.push(const DetailRoute());
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),

                                onPressed: () {
                                  ref
                                      .read(resumeDataProvider.notifier)
                                      .update((state) => data[idx]);
                                  context.router.push(
                                    ResumePreviewRoute(
                                      resume: getResumeTemplateById(
                                        data[idx].templateId,
                                      ),
                                      resumeData: data[idx],
                                    ),
                                  );
                                },
                                label: const Text('View'),
                              ),
                              horSpace(8),
                              OutlinedButton.icon(
                                icon: const Icon(Icons.delete),
                                // style: outlineButtonStyle,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  backgroundColor:
                                      const Color.fromARGB(255, 237, 245, 252),
                                  minimumSize: const Size(88, 36),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),

                                onPressed: () async {
                                  // to delete
                                  var uid = ref
                                      .watch(authRepositoryProvider)
                                      .currentUser
                                      ?.uid
                                      .toString();

                                  if (uid == null &&
                                      data[idx].resumeId == null) {
                                    return;
                                  }
                                  ref
                                      .read(resumeRepositoryProvider)
                                      .removeResumeData(
                                        userId: uid!,
                                        resumeDocId: data[idx].resumeId!,
                                      );
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
      },
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
