import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/shared/shared.dart';
import 'home_section_title.dart';

class HomeMyResumeListSection extends StatelessWidget {
  const HomeMyResumeListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: HomeSectionTitle(
            label: 'My Resumes',
            onTap: () {
              context.router.push(const MyFileRoute());
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Center(
              child: Text(
                'No Resumes',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4),
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
