import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/utils/logger/logger.dart';
import '../../../../features.dart';

class EducationWidget extends StatefulHookConsumerWidget {
  const EducationWidget({super.key});

  @override
  ConsumerState<EducationWidget> createState() => _ExperienceState();
}

class _ExperienceState extends ConsumerState<EducationWidget> {
  @override
  Widget build(BuildContext context) {
    final eduSection = ref.watch(educationSectionProvider);
    final eduList = eduSection?.educations ?? [];
    wLog('skill list', eduList.length);
    return Column(
      children: List.generate(
        eduList.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (cxt) {
                    return AddEducationForm(eduList[index]);
                  });
            },
            title: Text(
              eduList[index].school ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eduList[index].degree ?? ''),
                Text(eduList[index].city ?? ''),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  // ref.watch(userSkillListProvider).removeAt(index);
                });
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ),
      ),
    );
  }
}
