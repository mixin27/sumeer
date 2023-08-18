import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/features/starter/feat_starter.dart';
import 'package:sumeer/shared/shared.dart';

@RoutePage()
class StarterPersonalDetailPage extends StatelessWidget {
  const StarterPersonalDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Personal Detail',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const PersonalInformationForm(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 20),
                  Consumer(
                    builder: (context, ref, child) {
                      final formKey = ref.watch(personalInfoFormKeyProvider);

                      return FilledButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final personalDetail = PersonalDetailSection(
                              firstName: ref.watch(firstNameProvider),
                              lastName: ref.watch(lastNameProvider),
                              email: ref.watch(emailProvider),
                              phone: ref.watch(phoneNumberProvider),
                              jobTitle: ref.watch(jobTitleProvider),
                              address: ref.watch(addressProvider),
                            );
                            ref
                                .read(personalDetailProvider.notifier)
                                .update((state) => personalDetail);

                            // go to next form
                            context.router.push(const StarterEducationRoute());
                          }
                        },
                        style: FilledButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text("Next"),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
