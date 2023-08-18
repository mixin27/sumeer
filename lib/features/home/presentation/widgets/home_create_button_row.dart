import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';

class HomeCreateButtonRow extends HookConsumerWidget {
  const HomeCreateButtonRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () {
              if (ref.watch(authRepositoryProvider).currentUser != null) {
                ref.read(resumeDataProvider.notifier).state = null;
                ref.read(profileSectionProvider.notifier).state = null;
                ref.read(skillSectionProvider.notifier).state = null;
                ref.read(educationSectionProvider.notifier).state = null;
                ref.read(experienceSectionProvider.notifier).state = null;
                ref.read(resumeModelIdProvider.notifier).state = '';

                //
                ref.read(resumeModelIdProvider.notifier).state =
                    ref.watch(resumeModelIdProvider).isEmptyOrNull
                        ? const Uuid().v4()
                        : ref.watch(resumeModelIdProvider);
                context.router.push(const PersonalDetailRoute());
              } else {
                context.router.push(const SignInRoute());
              }
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              // backgroundColor: const Color(0xFFF5F5F5),
              backgroundColor: Colors.grey.shade200,
              foregroundColor: const Color(0xFF363636),
            ),
            // icon: Image.asset(
            //   AssetPaths.createResume,
            //   width: 24,
            // ),
            icon: Icon(
              Icons.file_open_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: const Text('New resume'),
          ),
        ),
        const SizedBox(width: 20),
        // const Expanded(child: SizedBox()),
        Expanded(
          child: FilledButton.icon(
            onPressed: () {
              context.router.push(const MyFilesRoute());
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              backgroundColor: const Color(0xFFF5F5F5),
              foregroundColor: const Color(0xFF363636),
            ),
            // icon: Image.asset(
            //   AssetPaths.myFiles,
            //   width: 24,
            // ),
            icon: Icon(
              Icons.description_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: const Text('My Files'),
          ),
        ),
      ],
    );
  }
}
