import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../features.dart';

class ProfileWidget extends StatefulHookConsumerWidget {
  const ProfileWidget({super.key});

  @override
  ConsumerState<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends ConsumerState<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final profileSection = ref.watch(resumeDataProvider)?.profile;
    final contentList = profileSection?.contents ?? [];

    return Column(
      children: List.generate(
        contentList.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (cxt) {
                    return AddProfileForm(index, contentList[index]);
                  });
            },
            title: Text(contentList[index]),
            // subtitle: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(contentList[index]),
            //   ],
            // ),
            trailing: IconButton(
              onPressed: () {
                final oldResumeDataProvider = ref.watch(resumeDataProvider);

                List<String> newContentList = [];

                for (var element in contentList) {
                  newContentList.add(element);
                }
                newContentList.removeAt(index);

                ProfileSection languageSection = ProfileSection(
                  title: '',
                  contents: newContentList,
                );
                final newResumeData = oldResumeDataProvider?.copyWith(
                  profile: languageSection,
                );
                setState(() {
                  ref
                      .read(resumeDataProvider.notifier)
                      .update((state) => newResumeData);
                });
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
