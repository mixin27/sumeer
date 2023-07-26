import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/features/data_input/feat_data_input.dart';
import 'package:sumeer/widgets/button1.dart';

@RoutePage()
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume1"),
        actions: const [
          Button1(
            text: "Preview",
          ),
        ],
      ),
      body: const EditFormWidget(),
    );
  }
}
