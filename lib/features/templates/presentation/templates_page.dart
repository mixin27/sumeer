import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/features.dart';

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
    final resTemplates = resumeTemplates
        .where((element) => element.type == DocumentType.resume)
        .toList();
    final cvTemplates = resumeTemplates
        .where((element) => element.type == DocumentType.cv)
        .toList();

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
          // bottom: TabBar(
          //   controller: _tabController,
          //   labelColor: Colors.white,
          //   unselectedLabelColor: Colors.black,
          //   indicatorColor: Colors.yellowAccent,
          //   tabs: [
          //     TemplateTab(
          //       "All",
          //       initialIndex == 0 ? Colors.blueAccent : Colors.white,
          //     ),
          //     TemplateTab(
          //       "CVs",
          //       initialIndex == 1 ? Colors.blueAccent : Colors.white,
          //     ),
          //     TemplateTab(
          //       "Resumes",
          //       initialIndex == 2 ? Colors.blueAccent : Colors.white,
          //     ),
          //     // Tab(icon: Icon(Icons.directions_transit)),
          //     // Tab(icon: Icon(Icons.directions_car)),
          //   ],
          // ),
        ),
        // body: TabBarView(
        //   controller: _tabController,
        //   children: const [
        //     Icon(Icons.flight, size: 350),
        //     Icon(Icons.directions_transit, size: 350),
        //     Icon(Icons.directions_car, size: 350),
        //   ],
        // ),
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // const SizedBox(
                //   height: 10,
                // ),
                Center(
                  child: ButtonsTabBar(
                    radius: 17,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 45),
                    backgroundColor: Colors.blueAccent,
                    unselectedBackgroundColor: Colors.white,
                    unselectedLabelStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    borderColor: Colors.blueAccent,
                    unselectedBorderColor: Colors.grey.shade300,
                    borderWidth: 1,
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    tabs: [
                      templateTab("All"),
                      templateTab("CVs"),
                      templateTab("Resumes"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      GridView.builder(
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      ResumePreviewPage(resume: template),
                                ),
                              );
                            },
                            child: GridTile(
                              key: ValueKey(index),
                              child: Column(
                                children: [
                                  Card(
                                      clipBehavior: Clip.hardEdge,
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                      ),
                                      child: Image.asset(template.thumbnail)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 0,
                          childAspectRatio: 13.8 / 20,
                        ),
                        itemCount: cvTemplates.length,
                        itemBuilder: (context, index) {
                          final template = cvTemplates[index];

                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      ResumePreviewPage(resume: template),
                                ),
                              );
                            },
                            child: GridTile(
                              key: ValueKey(index),
                              child: Column(
                                children: [
                                  Card(
                                      clipBehavior: Clip.hardEdge,
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                      ),
                                      child: Image.asset(template.thumbnail)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 0,
                          childAspectRatio: 13.8 / 20,
                        ),
                        itemCount: resTemplates.length,
                        itemBuilder: (context, index) {
                          final template = resTemplates[index];

                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      ResumePreviewPage(resume: template),
                                ),
                              );
                            },
                            child: GridTile(
                              key: ValueKey(index),
                              child: Column(
                                children: [
                                  Card(
                                      clipBehavior: Clip.hardEdge,
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                      ),
                                      child: Image.asset(template.thumbnail)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // Center(
                      //   child: Icon(Icons.directions_car),
                      // ),
                      // const Center(
                      //   child: Icon(Icons.directions_transit),
                      // ),
                      // const Center(
                      //   child: Icon(Icons.directions_bike),
                      // ),
                    ],
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
