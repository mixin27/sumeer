import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/login/shared/login_providers.dart';
import 'package:sumeer/features/features.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
import 'package:sumeer/widgets/widgets.dart';

class SignInForm extends StatefulHookConsumerWidget {
  const SignInForm({
    super.key,
  });

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordVisible = ref.watch(passwordVisibleProvider);

    ref.listen(signInNotifierProvider, (previous, next) {
      next.maybeMap(
        orElse: () {},
        loading: (_) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Logging in'),
                    SizedBox(height: 10),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        success: (_) async {
          final localData =
              await ref.read(resumeRepositoryProvider).getLocalData();
          if (localData.isEmpty && mounted) {
            context.router.replaceAll([const MainRoute()]);
          }

          for (ResumeData data in localData) {
            await ref
                .read(upsertResumeDataNotifierProvider.notifier)
                .upsertResumeData(
                  userId: _.user.uid,
                  resumeData: data,
                  resumeDocId: data.resumeId,
                );
          }

          await ref.read(resumeRepositoryProvider).clearLocalData();
          if (mounted) context.router.replaceAll([const MainRoute()]);
        },
        error: (_) {
          context.router.pop().then((value) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Login Failed'),
                  content: Text(_.error),
                );
              },
            );
          });
        },
      );
    });

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FormLabel(label: 'Email'),
            const SizedBox(height: 5),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 10,
                ),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: 'Please provide email address'),
                EmailValidator(
                    errorText: 'Please provide a valid email address')
              ]),
            ),
            const SizedBox(height: 10),
            const FormLabel(label: 'Password'),
            const SizedBox(height: 5),
            TextFormField(
              controller: _passwordController,
              obscureText: !passwordVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 10,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    ref
                        .read(passwordVisibleProvider.notifier)
                        .update((state) => !state);
                  },
                  child: passwordVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: 'password is required'),
                MinLengthValidator(
                  8,
                  errorText: 'password must be at least 8 digits long',
                ),
                // PatternValidator(
                //   r'(?=.*?[#?!@$%^&*-])',
                //   errorText: 'passwords must have at least one special character',
                // ),
              ]),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  dLog('Email: ${_emailController.text.trim()}');
                  dLog('Password: ${_passwordController.text.trim()}');

                  ref.read(signInNotifierProvider.notifier).login(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim());
                }
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 75,
                  vertical: 15,
                ),
              ),
              child: Text(
                'Login',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                context.router.push(const SignUpRoute());
              },
              child: const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
