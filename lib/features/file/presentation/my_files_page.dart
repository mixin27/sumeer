import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/features/auth/feat_auth.dart';

import 'widgets/authenticated_file_list.dart';
import 'widgets/not_authenticated_file_list.dart';

@RoutePage()
class MyFilesPage extends HookConsumerWidget {
  const MyFilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Files'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final currentUser = ref.watch(authRepositoryProvider).currentUser;

          return currentUser == null
              ? const NoAuthenticatedFileList()
              : const AuthenticatedFileList();
        },
      ),
    );
  }
}
