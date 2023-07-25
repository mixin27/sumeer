import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/sign_in_form.dart';

@RoutePage()
class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 64),
            const CircleAvatar(
              radius: 45,
              child: Text('Logo'),
            ),
            const SizedBox(height: 20),
            Text(
              'Login',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(height: 20),
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
