import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/features/data_input/presentation/widget/expanable/education.dart';
import 'package:sumeer/features/data_input/presentation/widget/expanable/experience.dart';
import 'package:sumeer/features/data_input/presentation/widget/expanable/skill.dart';

import '../../../features.dart';

class AddDataCard extends ConsumerStatefulWidget {
  const AddDataCard({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final GestureTapCallback? onTap;

  @override
  ConsumerState<AddDataCard> createState() => _AddDataCardState();
}

class _AddDataCardState extends ConsumerState<AddDataCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            Container(
              // height: 80,
              padding: const EdgeInsets.only(left: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.text,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      onPressed: widget.onTap,
                      icon: const Icon(
                        Icons.add_circle,
                        size: 40,
                        color: Color(0xFF407BFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.text.contains('Skill'))
              ref.watch(skillSectionProvider) == null
                  ? const SizedBox()
                  : const SkillWdiget(),
            if (widget.text.contains('Professional')) const ExperienceWidget(),
            if (widget.text.contains('Education')) const EducationWidget(),
          ],
        ),
      ),
    );
  }
}
