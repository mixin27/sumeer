import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/expanable/experience.dart';
import '../../../../features.dart';

class ExperienceCard extends ConsumerStatefulWidget {
  const ExperienceCard({
    Key? key,
    // required this.text,
    this.onTap,
  }) : super(key: key);

  // final String text;
  final GestureTapCallback? onTap;

  @override
  ConsumerState<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends ConsumerState<ExperienceCard> {
  bool isShowSkill = false;
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
                      'Professional Experience',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: widget.onTap,
                      icon: const Icon(
                        Icons.add_circle,
                        size: 40,
                        color: Color(0xFF407BFF),
                      ),
                    ),
                    // Image.asset(
                    //   'assets/images/resume/down_arrow.png',
                    //   height: 20,
                    // ),
                    ref.watch(resumeDataProvider)?.experience == null
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () {
                              isShowSkill = !isShowSkill;
                              setState(() {});
                            },
                            icon: Icon(
                              isShowSkill
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                  ],
                ),
              ),
            ),
            ref.watch(resumeDataProvider)?.experience == null
                ? const SizedBox()
                : Column(
                    children: [
                      isShowSkill ? const ExperienceWidget() : const SizedBox(),
                    ],
                  ),
            // if (widget.text.contains('Professional')) const ExperienceWidget(),
            // if (widget.text.contains('Education')) const EducationWidget(),
          ],
        ),
      ),
    );
  }
}
