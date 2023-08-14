import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/features/auth/core/shared/auth_providers.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/features/starter/feat_starter.dart';

@RoutePage()
class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final currentUser = ref.watch(authRepositoryProvider).currentUser;

          final resumeDataList =
              ref.watch(resumeDataListProvider(userId: currentUser?.uid ?? ""));

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ExpansionTile(
                  title: Text('Personal Information'),
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: PersonalInformationForm(),
                    ),
                  ],
                ),
                const ExpansionTile(
                  title: Text('Education'),
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: EducationForm(),
                    ),
                  ],
                ),
                const ExpansionTile(
                  title: Text('Experience'),
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ExperienceForm(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (currentUser == null) return;

                      final resumeData = await getDummyResumeData();
                      ref
                          .read(upsertResumeDataNotifierProvider.notifier)
                          .upsertResumeData(
                            userId: currentUser.uid,
                            resumeData: resumeData,
                          );
                    },
                    child: const Text("Save Resume Data"),
                  ),
                ),

                // Data
                SizedBox(
                  child: resumeDataList.when(
                    data: (data) => ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final resumeData = data[index];

                        return ListTile(
                          title: Text(
                            resumeData.personalDetail?.fullName ??
                                "Unknown user",
                          ),
                          subtitle: Text(
                            resumeData.personalDetail?.jobTitle ??
                                "Unknown job title",
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              if (currentUser == null) return;
                              if (resumeData.resumeId == null) return;

                              ref
                                  .read(resumeRemoteServiceProvider)
                                  .removeResumeData(
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
                    ),
                    error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
