import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/features/starter/feat_starter.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';

@RoutePage()
class StarterCompletePage extends HookConsumerWidget {
  const StarterCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = useState<List<ResumeData>>([]);

    Future<void> getData() async {
      final result = await ref.read(resumeRepositoryProvider).getLocalData();
      data.value = result;
    }

    useEffect(() {
      getData();
      return null;
    }, []);

    final selectedTemplate = ref.watch(selectedResumeTemplateProvider);
    final starterResumeData = ref.watch(starterResumeDataProvider);
    tLog(selectedTemplate?.id);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.tips_and_updates_outlined,
                  size: 20,
                  color: Colors.amber,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'You can zoom in/out preview page by tapping twice',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (starterResumeData != null) {
                      final oldData = await ref
                          .read(resumeRepositoryProvider)
                          .getLocalData();
                      oldData.addFirst(starterResumeData);

                      ref
                          .read(resumeRepositoryProvider)
                          .saveToLocal(oldData)
                          .then((value) {
                        ref
                            .read(personalDetailProvider.notifier)
                            .update((state) => null);
                        ref
                            .read(educationsProvider.notifier)
                            .update((state) => []);
                        ref
                            .read(experiencesProvider.notifier)
                            .update((state) => []);

                        context.router.replaceAll([const MainRoute()]);
                      });
                    }
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
          Expanded(
            child: selectedTemplate == null
                ? const SizedBox()
                : PdfPreview(
                    previewPageMargin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    useActions: false,
                    build: (format) => selectedTemplate.builder(
                      format,
                      GenerateDocParams(
                        title: 'RESUME',
                        author: starterResumeData?.personalDetail?.fullName,
                      ),
                      starterResumeData ?? ResumeData.empty(),
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Choose template",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    resumeTemplates.length,
                    (index) {
                      final template = resumeTemplates[index];

                      return InkWell(
                        onTap: () {
                          ref
                              .read(selectedResumeTemplateProvider.notifier)
                              .update((state) => resumeTemplates[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: 120,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(template.thumbnail),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
