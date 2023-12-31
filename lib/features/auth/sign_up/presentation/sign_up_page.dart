import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/shared/shared.dart';
import 'widgets/sign_up_form.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 20),
            Image.asset(
              AssetPaths.logo,
              width: 200,
              height: 200,
            ),
            // const SizedBox(height: 20),
            // Text(
            //   'Create account',
            //   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            //         fontWeight: FontWeight.w500,
            //         fontSize: 20,
            //       ),
            // ),
            // const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}
