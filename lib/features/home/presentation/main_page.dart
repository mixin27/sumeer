import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:sumeer/shared/shared.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        TemplatesRoute(),
        AccountRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        int currentIndex = tabsRouter.activeIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 182, 180, 180),
                      blurRadius: 0.5)
                ]),
            child: SalomonBottomBar(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: [
                SalomonBottomBarItem(
                  selectedColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.home,
                      color: currentIndex == 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                  title: const Text('Home'),
                ),
                SalomonBottomBarItem(
                  selectedColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.file_copy,
                      color: currentIndex == 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                  title: const Text('Templates'),
                ),
                SalomonBottomBarItem(
                  // selectedColor: Colors.green,
                  selectedColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.person,
                      color: currentIndex == 2
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                  title: const Text('Account'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
