import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/shared/shared.dart';
import 'widgets/sign_in_form.dart';

@RoutePage()
class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AssetPaths.logo,
              width: 200,
              height: 200,
            ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 16.0),
            //     child: Text(
            //       'Login',
            //       style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 20,
            //           ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SignInForm(),
            ),
          ],
        ),
      ),
    );
  }
}
