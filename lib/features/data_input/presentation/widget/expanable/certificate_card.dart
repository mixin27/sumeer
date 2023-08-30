import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/expanable/certificate_widget.dart';
import 'package:sumeer/features/features.dart';

class CertificateCard extends ConsumerStatefulWidget {
  const CertificateCard({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final GestureTapCallback? onTap;

  @override
  ConsumerState<CertificateCard> createState() => _AddDataCardState();
}

class _AddDataCardState extends ConsumerState<CertificateCard> {
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
                        Icons.workspace_premium,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Certificate',
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
                    ref.watch(resumeDataProvider)?.certificate == null
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
            ref.watch(resumeDataProvider)?.certificate == null
                ? const SizedBox()
                : Column(
                    children: [
                      isShowSkill
                          ? const CertificateWidget()
                          : const SizedBox(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
