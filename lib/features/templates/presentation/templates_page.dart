import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:sumeer/features/features.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
import '../../auth/feat_auth.dart';

@RoutePage()
class TemplatesPage extends ConsumerStatefulWidget {
  const TemplatesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends ConsumerState<TemplatesPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int? initialIndex;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: initialIndex ?? 0,
      vsync: this,
      length: 3,
    );
    _tabController.addListener(tabListener);
  }

  tabListener() {
    switch (_tabController.index) {
      case 0:
        setState(() {
          initialIndex = _tabController.index;
        });
        break;
      case 1:
        setState(() {
          initialIndex = _tabController.index;
        });
        break;
      case 2:
        setState(() {
          initialIndex = _tabController.index;
        });
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: initialIndex ?? 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Templates',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                // color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 0,
                      childAspectRatio: 13.8 / 20,
                    ),
                    itemCount: resumeTemplates.length,
                    itemBuilder: (context, index) {
                      final template = resumeTemplates[index];

                      return InkWell(
                        onTap: () {
                          if (ref.watch(authRepositoryProvider).currentUser !=
                              null) {
                            if (ref.watch(resumeDataProvider)?.templateId !=
                                null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => ResumePreviewPage(
                                    resume: template,
                                    resumeData: ref.watch(resumeDataProvider),
                                  ),
                                ),
                              );
                            } else if (ref.watch(resumeDataProvider) != null) {
                              wLog('resumeDataProvider i = null',
                                  ref.watch(resumeDataProvider));
                              ref.read(resumeModelIdProvider.notifier).state =
                                  ref.watch(resumeDataProvider)?.resumeId ?? '';
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => ResumePreviewPage(
                                    resume: template,
                                    resumeData: ref.watch(resumeDataProvider),
                                  ),
                                ),
                              );
                            } else {
                              //
                              ref.read(resumeDataProvider.notifier).state =
                                  null;
                              ref.read(skillSectionProvider.notifier).state =
                                  null;
                              ref
                                  .read(educationSectionProvider.notifier)
                                  .state = null;
                              ref
                                  .read(experienceSectionProvider.notifier)
                                  .state = null;
                              ref.read(resumeModelIdProvider.notifier).state =
                                  '';
                              //
                              ref.read(resumeModelIdProvider.notifier).state =
                                  const Uuid().v4();
                              ref.read(templatelIdProvider.notifier).state =
                                  template.id;
                              context.router.push(const PersonalDetailRoute());
                            }
                          } else {
                            context.router.push(const SignInRoute());
                          }
                        },
                        child: GridTile(
                          key: ValueKey(index),
                          child: Column(
                            children: [
                              Card(
                                  clipBehavior: Clip.hardEdge,
                                  elevation: 5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                  ),
                                  child: Image.asset(template.thumbnail)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Tab templateTab(String text) {
    return Tab(text: text);
  }
}
