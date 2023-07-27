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
          title: const Text('Templates'),
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
              children: <Widget>[
                ButtonsTabBar(
                  radius: 17,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  backgroundColor: Colors.blueAccent,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    templateTab("All"),
                    templateTab("CV"),
                    templateTab("Resume"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 0,
                          childAspectRatio: 13.5 / 20,
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
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Image.asset(template.thumbnail)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 0,
                          childAspectRatio: 13.5 / 20,
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
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.green[200],
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Image.asset(template.thumbnail)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 0,
                          childAspectRatio: 13.5 / 20,
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
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(14)),
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
