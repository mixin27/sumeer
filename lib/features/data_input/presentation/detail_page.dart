import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/features/data_input/feat_data_input.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/widgets/button1.dart';

import '../../features.dart';
import '../../resume/core/presentation/templates/resume1.dart';

@RoutePage()
class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume1"),
        actions: [
          Button1(
            text: "Preview",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ResumePreviewPage(
                      resume: ResumeTemplate(
                    'Preview',
                    'resume_template_tmn.dart',
                    'assets/images/templates/resume_template_1.jpg',
                    generateResume1,
                  )),
                ),
              );
            },
          ),
        ],
      ),
      body: const EditFormWidget(),
    );
  }
}
