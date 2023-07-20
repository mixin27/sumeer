import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

@RoutePage()
class TemplateListingPage extends StatelessWidget {
  const TemplateListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Templates'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 7 / 11,
        ),
        itemCount: resumeTemplates.length,
        itemBuilder: (context, index) {
          final template = resumeTemplates[index];

          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ResumePreviewPage(resume: template),
                ),
              );
            },
            child: GridTile(
              key: ValueKey(index),
              child: Column(
                children: [
                  Image.asset(template.thumbnail),
                  const SizedBox(height: 5),
                  Text(template.name),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
