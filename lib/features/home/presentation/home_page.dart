import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sumeer'),
      ),
      body: const Center(
        child: Text('HOME PAGE'),
      ),
    );
  }
}
