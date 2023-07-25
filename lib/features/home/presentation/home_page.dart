import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:sumeer/shared/constants/asset_paths.dart';
import 'package:sumeer/widgets/widgets.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            ///
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sumeer',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ///
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      // create job winnign
                      winningJob(context),
                      verSpace(10),
                      // create cv/resume
                      createCVorResume(context),
                      verSpace(10),
                      // build your cv/ resume free
                      viewAll(context),
                      verSpace(5),
                      Text(
                        'Pick one of our free resume templates, fill it out, and land that dream job!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 380,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: Image.asset(
                                'assets/images/home/template1.png',
                                height: 350,
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row viewAll(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Build your CV/Resume free',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: () {},
          child: const Text('View all -->'),
        ),
      ],
    );
  }

  Row createCVorResume(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///
        ElevatedButton.icon(
          onPressed: () {},
          style: FilledButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // <-- Radius
            ),
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            foregroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          icon: Image.asset(AssetPaths.cv),
          label: const Text('Create New\n CV form'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // <-- Radius
            ),
            elevation: 2,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            foregroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          icon: Image.asset(AssetPaths.resume),
          label: const Text('Create New\n Resume'),
        ),

        ///
      ],
    );
  }

  Widget winningJob(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textAlign: TextAlign.center,
          'Create a job winning\n Resume in a Minutes!',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Image.asset(
          AssetPaths.file,
          height: 80,
        )
      ],
    );
  }
}
