import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
import 'package:sumeer/widgets/widgets.dart';

@RoutePage()
class SecondHomePage extends StatefulWidget {
  const SecondHomePage({super.key});

  @override
  State<SecondHomePage> createState() => _SecondHomePageState();
}

class _SecondHomePageState extends State<SecondHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            const SizedBox(height: 50),

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
                  Consumer(
                    builder: (context, ref, child) {
                      final authStateChanges =
                          ref.watch(authStateChangesProvider);

                      return authStateChanges.when(
                        data: (data) {
                          if (data != null) {
                            return const SizedBox();
                          } else {
                            return FilledButton.icon(
                              onPressed: () {
                                context.router.push(const SignInRoute());
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              icon: const Icon(Icons.login),
                              label: const Text('Login'),
                            );
                          }
                        },
                        error: (error, stackTrace) {
                          eLog(error.toString());
                          return const SizedBox();
                        },
                        loading: () => const CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ///
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      // create job winnign
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Create a job winning\nResume in a Minutes!',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Image.asset(
                            AssetPaths.file,
                            height: 100,
                          )
                        ],
                      ),

                      verSpace(10),
                      // create cv/resume
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .error
                                      .withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(right: 5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.description_outlined,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      Text('Resume',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Colors.white,
                                              )),
                                    ]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(left: 5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.description_outlined,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Cv Form',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ]),
                              ),
                            )
                          ]),
                      verSpace(30),
                      // build your cv/ resume free
                      viewAll(context),
                      Text(
                        'Pick one of our free resume templates, fill it out, and land that dream job!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.5)),
                      ),
                      verSpace(30),
                      SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: resumeTemplates.length > 4
                              ? 4
                              : resumeTemplates.length,
                          itemBuilder: (context, index) {
                            final template = resumeTemplates[index];

                            return Card(
                              clipBehavior: Clip.hardEdge,
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                              ),
                              child: Image.asset(
                                template.thumbnail,
                                // height: 350,
                                fit: BoxFit.cover,
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
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            context.router.navigate(const TemplatesRoute());
          },
          child: Text(
            'View all ->',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
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
          onPressed: () {
            context.router.push(const DetailRoute());
          },
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
          onPressed: () {
            context.router.push(const DetailRoute());
          },
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
