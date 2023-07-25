import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/login/shared/login_providers.dart';
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
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 10,
              ),
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: 'Please provide email address'),
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
          Center(
            child: FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  dLog('Email: ${_emailController.text.trim()}');
                  dLog('Password: ${_passwordController.text.trim()}');
                }
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 75,
                  vertical: 15,
                ),
              ),
              child: const Text('Login'),
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
