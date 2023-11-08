import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/features.dart';
import 'package:sumeer/features/templates/shared/provider.dart';
import 'package:sumeer/utils/logger/logger.dart';

class TemplateChooserDialog extends HookConsumerWidget {
  const TemplateChooserDialog({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text(
            'Choose template',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Expanded(
          child: GridView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 0,
              childAspectRatio: 12 / 20,
            ),
            itemCount: resumeTemplates.length,
            itemBuilder: (context, index) {
              final template = resumeTemplates[index];

              return InkWell(
                onTap: () {
                  tLog('Tap ${template.name}');
                  ref
                      .read(resumeTemplateProvider.notifier)
                      .update((state) => template);
                  // ref.read(resumeDataProvider.notifier).update(
                  //       (state) => state?.copyWith(
                  //         templateId: template.id,
                  //       ),
                  //     );
                  context.router.pop();
                },
                child: GridTile(
                  key: ValueKey(index),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Image.asset(template.thumbnail),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        template.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: List.generate(
        //       resumeTemplates.length,
        //       (index) {
        //         final template = resumeTemplates[index];

        //         return InkWell(
        //           onTap: () {
        //             // ref
        //             //     .read(selectedResumeTemplateProvider.notifier)
        //             //     .update((state) => resumeTemplates[index]);
        //           },
        //           child: Container(
        //             margin: const EdgeInsets.all(8),
        //             width: 120,
        //             height: 150,
        //             decoration: BoxDecoration(
        //               image: DecorationImage(
        //                 image: AssetImage(template.thumbnail),
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
