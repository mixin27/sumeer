import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/add_language_form.dart';
import '../../../../features.dart';

class LanguageWidget extends StatefulHookConsumerWidget {
  const LanguageWidget({super.key});

  @override
  ConsumerState<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends ConsumerState<LanguageWidget> {
  @override
  Widget build(BuildContext context) {
    final language = ref.watch(resumeDataProvider)?.languages;
    final languageList = language?.languages ?? [];

    return Column(
      children: List.generate(
        languageList.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (cxt) {
                    return AddLanguageForm(languageList[index], index);
                  });
            },
            title: Text(languageList[index].title ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(languageList[index].description ?? ''),
                Text(getLanguageLevel(
                  languageList[index].level ?? LanguageLevelEnum.beginner,
                )),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                final oldResumeDataProvider = ref.watch(resumeDataProvider);

                List<Language> newLanguageList = [];

                for (var element in languageList) {
                  newLanguageList.add(element);
                }
                newLanguageList.removeAt(index);

                LanguageSection languageSection = LanguageSection(
                  title: '',
                  languages: newLanguageList,
                );
                final newResumeData = oldResumeDataProvider?.copyWith(
                  languages: languageSection,
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
