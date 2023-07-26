import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sumeer/features/data_input/feat_data_input.dart';
import 'package:sumeer/widgets/button1.dart';

import '../../features.dart';
import '../../resume/core/presentation/templates/resume_template_tmn.dart';

@RoutePage()
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    generateTemplatetmn,
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
