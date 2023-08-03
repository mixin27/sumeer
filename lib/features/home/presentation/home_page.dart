import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 0,
      ),
      body: Container(
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
                        fontWeight: FontWeight.bold),
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
                              child: InkWell(
                                onTap: () => context.router
                                    .push(const PersonalDetailRoute()),
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
                                        Text("New Resume/CVs",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color: Colors.white,
                                                )),
                                      ]),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () =>
                                    context.router.push(const MyFileRoute()),
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
                                          "My Files",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ]),
                                ),
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

                            return Container(
                              child: Card(
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

  Widget viewAll(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Build your CV/Resume free',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () {
            context.router.navigate(const TemplatesRoute());
          },
          child: const Text('View all'),
        ),
      ],
    );
  }

  Widget createCVorResume(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///
            // Expanded(
            // child: SizedBox(
            //   height: 80,
            //   child: ElevatedButton.icon(
            //     onPressed: () {
            //       context.router.push(const MyFileRoute());
            //     },
            //     style: FilledButton.styleFrom(
            //       elevation: 0.5,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15), // <-- Radius
            //       ),
            //       backgroundColor: const Color.fromARGB(255, 237, 245, 252),
            //       foregroundColor: Theme.of(context).colorScheme.primary,
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //     ),
            //     icon: const Icon(
            //       Icons.file_copy,
            //     ),
            //     label: const Text(
            //       textAlign: TextAlign.start,
            //       'My files',
            //     ),
            //   ),
            // ),

            // ),
            Expanded(
              child: InkWell(
                onTap: () {
                  context.router.push(const MyFileRoute());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 237, 245, 252),
                      // color: Theme.of(context).primaryCo,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.file_copy_outlined,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        verSpace(4),
                        Text(
                          textAlign: TextAlign.start,
                          'My Files',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            horSpace(20),
            Expanded(
              child: InkWell(
                onTap: () {
                  ref.read(resumeDataProvider.notifier).state = null;
                  context.router.push(const DetailRoute());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 237, 245, 252),
                      // color: Theme.of(context).primaryCo,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Image.asset(AssetPaths.resume),
                        verSpace(4),
                        Text(
                          textAlign: TextAlign.start,
                          'Create resume +',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            ///
          ],
        );
      }),
    );
  }

  Widget winningJob(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Text(
        //   // textAlign: TextAlign.center,
        //   'Create a job winning\nresume',
        //   style: Theme.of(context)
        //       .textTheme
        //       .titleLarge!
        //       .copyWith(fontWeight: FontWeight.w500),
        // ),
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
