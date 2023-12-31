import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/expanable/education.dart';
import '../../../../features.dart';

class EducationCard extends ConsumerStatefulWidget {
  const EducationCard({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final GestureTapCallback? onTap;

  @override
  ConsumerState<EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends ConsumerState<EducationCard> {
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
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.school,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Education',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    // const Spacer(),
                    IconButton(
                      onPressed: widget.onTap,
                      icon: const Icon(
                        Icons.add_circle,
                        size: 40,
                        color: Color(0xFF407BFF),
                      ),
                    ),
                    ref.watch(resumeDataProvider)?.education == null
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
                          ),
                  ],
                ),
              ),
            ),
            ref.watch(resumeDataProvider)?.education == null
                ? const SizedBox()
                : Column(
                    children: [
                      isShowSkill ? const EducationWidget() : const SizedBox(),
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
