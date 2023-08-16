import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/resume/feat_resume.dart';

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
        return ListView.builder(
          itemBuilder: (context, index) {
            final resumeData = data[index];

            return ListTile(
              title: Text(
                resumeData.personalDetail?.fullName ?? "Unknown user",
              ),
              subtitle: Text(
                resumeData.personalDetail?.jobTitle ?? "Unknown job title",
              ),
              trailing: IconButton(
                onPressed: () {
                  if (resumeData.resumeId == null) return;

                  ref.read(resumeRemoteServiceProvider).removeResumeData(
                        userId: currentUser.uid,
                        resumeDocId: resumeData.resumeId!,
                      );
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            );
          },
          itemCount: data.length,
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
