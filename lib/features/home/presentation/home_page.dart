import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/features/resume/feat_resume.dart';
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
              padding: const EdgeInsets.only(
                  top: 20, left: 16, right: 12, bottom: 8),
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
                            return FilledButton.icon(
                              onPressed: () async {
                                await ref
                                    .read(authRepositoryProvider)
                                    .signOut();

                                // if (mounted) {
                                //   context.router.push(const SignInRoute());
                                // }
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              icon: const Icon(Icons.login),
                              label: const Text('Sign Out'),
                            );
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
                      verSpace(20),
                      // create cv/resume
                      createCVorResume(context),
                      verSpace(20),
                      // build your cv/ resume free
                      viewAll(context, title: 'CV'),
                      // verSpace(5),
                      Text(
                        'Pick one of our free resume templates, fill it out, and land that dream job!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey.shade500),
                      ),
                      verSpace(10),
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: resumeTemplates.length > 4
                              ? 4
                              : resumeTemplates.length,
                          itemBuilder: (context, index) {
                            final template = resumeTemplates[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 10,
                              ),
                              child: Image.asset(
                                template.thumbnail,
                                // height: 350,
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ),

                      viewAll(context, title: 'Resume'),
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: resumeTemplates.length > 4
                              ? 4
                              : resumeTemplates.length,
                          itemBuilder: (context, index) {
                            final template = resumeTemplates[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 10,
                              ),
                              child: Image.asset(
                                template.thumbnail,
                                // height: 350,
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

  Widget viewAll(BuildContext context, {required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Build your $title free',
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
                  ref.read(resumeModelIdProvider.notifier).state = '';
                  context.router.push(const PersonalDetailRoute());
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
