import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sumeer/features/auth/core/shared/auth_providers.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/logger/logger.dart';

@RoutePage()
class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              // color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: ListView(
          children: [
            // Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(height: 10),
            // const Text(
            //   "Profile",
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 14),
            Consumer(
              builder: (context, ref, child) {
                final authStateChanges = ref.watch(authStateChangesProvider);

                return authStateChanges.when(
                  data: (data) {
                    if (data == null) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            context.router.push(const SignInRoute());
                          },
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          child: const Text('Sign In'),
                        ),
                      );
                    } else {
                      return InkWell(
                        // onTap: () {
                        //   context.router.push(const ProfileRoute());
                        // },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.person_2_outlined,
                                color: Colors.blueAccent,
                                size: 50,
                              ),
                              const Text(
                                'My Account',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(data.email),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  error: (error, stack) => Text(error.toString()),
                  loading: () => const SizedBox(),
                );
              },
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 8),
            Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(height: 22),
            const Text(
              'Term and Privacy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                context.router.push(const PrivacyAndPolicyRoute());
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.privacy_tip_outlined,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                      child: Text(
                    'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  )),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(height: 22),
            const Text(
              'Contact',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Rate Our App',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 22),
            InkWell(
              onTap: () async {
                try {
                  final uri = Uri.tryParse('https://github.com/mixin27/sumeer');
                  if (uri == null) return;

                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                } catch (e) {
                  eLog(e.toString());
                }
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.launch_outlined,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                      child: Text(
                    'Github',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  )),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(height: 20),
            const Text(
              'App Version',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            const Row(
              children: [
                Icon(
                  Icons.pages_outlined,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 6),
                Expanded(
                    child: Text(
                  'Version',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
                Text(
                  '1.0',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 14),
            Consumer(
              builder: (context, ref, child) {
                final authState = ref.watch(authStateChangesProvider);

                return authState.when(
                  data: (data) {
                    if (data == null) {
                      return const SizedBox();
                    } else {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              ref.read(authRepositoryProvider).signOut();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.redAccent,
                                  ),
                                  SizedBox(width: 6),
                                  Expanded(
                                      child: Text(
                                    'Sign Out',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  )),
                                  Icon(Icons.arrow_forward_ios,
                                      size: 16, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],
                      );
                    }
                  },
                  error: (error, stack) => Text(error.toString()),
                  loading: () => const SizedBox(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
