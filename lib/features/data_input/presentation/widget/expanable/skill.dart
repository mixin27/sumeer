import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/utils/logger/logger.dart';
import '../../../../features.dart';

class SkillWdiget extends StatefulHookConsumerWidget {
  const SkillWdiget({super.key});

  @override
  ConsumerState<SkillWdiget> createState() => _SkillWdigetState();
}

class _SkillWdigetState extends ConsumerState<SkillWdiget> {
  @override
  Widget build(BuildContext context) {
    final skill = ref.watch(resumeDataProvider)?.skill;
    final skillList = skill?.skills ?? [];
    wLog('skill list', skillList.length);
    return Column(
      children: List.generate(
        skillList.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (cxt) {
                    return AddSkillForm(skillList[index], index);
                  });
            },
            title: Text(skillList[index].skill),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(skillList[index].skill),
                Text(skillList[index].information ?? ''),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                final oldResumeDataProvider = ref.watch(resumeDataProvider);

                List<Skill> newSkillList = [];

                for (var element in skillList) {
                  newSkillList.add(element);
                }
                newSkillList.removeAt(index);

                SkillSection skillSection = SkillSection(
                  title: '',
                  skills: newSkillList,
                );
                final newResumeData = oldResumeDataProvider?.copyWith(
                  skill: skillSection,
                );
                wtfLog('edu list', skillSection);
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
