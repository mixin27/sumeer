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
    final skill = ref.watch(skillSectionProvider);
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
                setState(() {
                  ref.watch(userSkillListProvider).removeAt(index);
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
