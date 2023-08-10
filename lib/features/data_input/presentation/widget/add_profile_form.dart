import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/features/features.dart';
import '../../../../utils/utils.dart';

class AddProfileForm extends ConsumerStatefulWidget {
  final int? index;
  final String? content;
  const AddProfileForm(this.index, this.content, {super.key});

  @override
  ConsumerState<AddProfileForm> createState() => _AddProfileFormState();
}

class _AddProfileFormState extends ConsumerState<AddProfileForm> {
  final TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    super.initState();

    setData();
  }

  Future<void> setData() async {
    Future.microtask(() {
      // final skill = ref.watch(userSkillProvider);
      if (widget.content != null) {
        contentController.text = widget.content ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    dLog('context list', widget.content);
    dLog('context index', widget.index);
    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            color: Theme.of(context).colorScheme.background),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Create Profile",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextInputFieldWidget(
                      controller: contentController,
                      title: "Text",
                      hintText:
                          "Introduce yourself by pitching your skill & explaining how they can be of value to a company",
                      maxLines: 4,
                    ),
                    SaveBottomSheetWidget(
                      onTap: () {
                        // final oldProfileSection =
                        //     ref.watch(profileSectionProvider);
                        final oldProfileSection =
                            ref.watch(resumeDataProvider)?.profile?.contents ??
                                [];

                        final oldResumeData = ref.watch(resumeDataProvider);

                        // String content = contentController.text;
                        // ProfileSection education = ProfileSection(
                        //  title: '',
                        //  contents:
                        // );
                        if (contentController.text.isEmpty) {
                          return Navigator.of(context).pop();
                        } else {
                          if (widget.index != null) {
                            List<String> list1 = [];
                            List<String> oldList =
                                oldResumeData?.profile?.contents ?? [];
                            for (var element in oldList) {
                              list1.add(element);
                            }
                            list1.removeAt(widget.index ?? 0);
                            wLog('updated list remove', list1);
                            list1.insert(
                                widget.index ?? 0, contentController.text);

                            wLog('updated list', list1);
                            ProfileSection profileSection = ProfileSection(
                                title: 'Profile', contents: list1);

                            // ref
                            //     .read(profileSectionProvider.notifier)
                            //     .update((state) => profileSection);

                            final newResumeData = oldResumeData?.copyWith(
                              profile: profileSection,
                            );
                            ref
                                .read(resumeDataProvider.notifier)
                                .update((state) => newResumeData);
                            dLog(
                                'updated profile content list',
                                ref
                                        .watch(resumeDataProvider)
                                        ?.profile
                                        ?.contents ??
                                    []);
                          } else {
                            List<String> contentList = oldProfileSection == null
                                ? [contentController.text]
                                : [
                                    ...oldProfileSection,
                                    contentController.text
                                  ];
                            ProfileSection profileSection = ProfileSection(
                              title: '',
                              contents: contentList,
                            );
                            ref
                                .read(profileSectionProvider.notifier)
                                .update((state) => profileSection);
                            // ResumeData resumeData = ResumeData(
                            //     education: ref.watch(educationSectionProvider));
                            final newResumeData = oldResumeData?.copyWith(
                              profile: ref.watch(profileSectionProvider),
                            );
                            ref
                                .read(resumeDataProvider.notifier)
                                .update((state) => newResumeData);
                            // ref
                            //     .read(resumeDataProvider.notifier)
                            //     .update((state) => state);
                            dLog(
                                'updated profile content list',
                                ref
                                        .watch(resumeDataProvider)
                                        ?.profile
                                        ?.contents ??
                                    []);
                          }
                        }
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
