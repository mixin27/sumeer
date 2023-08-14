import 'package:flutter/material.dart';

import 'package:sumeer/shared/shared.dart';

class HomeWinningJobSection extends StatelessWidget {
  const HomeWinningJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: 'Create a job winning\nresume ',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500, letterSpacing: 1, wordSpacing: 2),
            children: <TextSpan>[
              TextSpan(
                text: 'in a minute!',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.4,
                      wordSpacing: 2,
                    ),
              ),
            ],
          ),
        ),
        Image.asset(
          AssetPaths.file,
          height: 80,
        ),
      ],
    );
  }
}
