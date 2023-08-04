import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/sign_up/shared/sign_up_providers.dart';
import 'package:sumeer/utils/utils.dart';
import 'package:sumeer/widgets/widgets.dart';

class SignUpForm extends StatefulHookConsumerWidget {
  const SignUpForm({
    super.key,
  });

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordVisible = ref.watch(signUpPasswordVisibleProvider);

    ref.listen(signUpNotifierProvider, (previous, next) {
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
                    Text('Creating an account'),
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
        success: (_) {
          context.router.pop();
        },
        error: (_) {
          context.router.pop().then((value) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Sign Up Failed'),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FormLabel(label: 'Email'),
          const SizedBox(height: 5),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 10,
              ),
              fillColor: Color(0xFFF0F0F0),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: 'Email is required'),
              EmailValidator(errorText: 'Please provide a valid email address')
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
                      .read(signUpPasswordVisibleProvider.notifier)
                      .update((state) => !state);
                },
                child: passwordVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: 'Password is required'),
              MinLengthValidator(
                8,
                errorText: 'Password must be at least 8 digits long',
              ),
              // PatternValidator(
              //   r'(?=.*?[#?!@$%^&*-])',
              //   errorText: 'passwords must have at least one special character',
              // ),
            ]),
          ),
          const SizedBox(height: 10),
          const FormLabel(label: 'Re-type Password'),
          const SizedBox(height: 5),
          TextFormField(
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
                      .read(signUpPasswordVisibleProvider.notifier)
                      .update((state) => !state);
                },
                child: passwordVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
            ),
            validator: (val) =>
                MatchValidator(errorText: 'Passwords do not match')
                    .validateMatch(val ?? '', _passwordController.text.trim()),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                dLog('Email: ${_emailController.text.trim()}');
                dLog('Password: ${_passwordController.text.trim()}');

                ref.read(signUpNotifierProvider.notifier).signUp(
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
              'Create',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  context.router.pop();
                },
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ],
          ),
        ],
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
