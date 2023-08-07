import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/utils/logger/logger.dart';
import '../../../../features.dart';

class ExperienceWidget extends StatefulHookConsumerWidget {
  const ExperienceWidget({super.key});

  @override
  ConsumerState<ExperienceWidget> createState() => _ExperienceState();
}

class _ExperienceState extends ConsumerState<ExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    final expSection = ref.watch(resumeDataProvider)?.experience;
    final expList = expSection?.experiences ?? [];
    wLog('skill list', expList.length);
    return Column(
      children: List.generate(
        expList.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (cxt) {
                    return AddProfessionalExperienceForm(expList[index], index);
                  });
            },
            title: Text(
              expList[index].jobTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(expList[index].endDate.toString()),
                Text(expList[index].description ?? ''),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                final oldResumeDataProvider = ref.watch(resumeDataProvider);

                List<Experience> newExpList = [];

                for (var element in expList) {
                  newExpList.add(element);
                }
                newExpList.removeAt(index);

                ExperienceSection experienceScetion = ExperienceSection(
                  title: '',
                  experiences: newExpList,
                );
                final newResumeData = oldResumeDataProvider?.copyWith(
                  experience: experienceScetion,
                );
                wtfLog('exp list', experienceScetion);
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
