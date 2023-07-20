import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/features/features.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemplateListingPage();
  }
}
