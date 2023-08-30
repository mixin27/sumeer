import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/add_certificate_form.dart';
import 'package:sumeer/features/data_input/presentation/widget/add_language_form.dart';
import 'package:sumeer/features/data_input/presentation/widget/expanable/education_card.dart';
import 'package:sumeer/features/data_input/presentation/widget/expanable/experience_card.dart';
import 'package:sumeer/features/data_input/presentation/widget/expanable/language_card.dart';
import 'package:sumeer/features/data_input/presentation/widget/expanable/profile_card.dart';
import 'package:sumeer/features/features.dart';
import '../../feat_data_input.dart';
import 'expanable/certificate_card.dart';

class EditFormWidget extends ConsumerStatefulWidget {
  const EditFormWidget({super.key});

  @override
  ConsumerState<EditFormWidget> createState() => _EditFormWidgetState();
}

class _EditFormWidgetState extends ConsumerState<EditFormWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // personnal detail card
            const PersonalDetailCard(),
            ProfileCard(
              onTap: () => showProfileForm(context),
            ),
            EducationCard(
              onTap: () => showAddEducationForm(context),
            ),

            ExperienceCard(
              onTap: () => showAddExperienceForm(context),
            ),
            SkillCard(
              onTap: () {
                ref.read(skillLevelProvider.notifier).state = null;
                showAddSkillForm(context);
              },
            ),
            LanguageCard(
              onTap: () {
                ref.read(skillLevelProvider.notifier).state = null;
                showLanguageForm(context);
              },
            ),
            CertificateCard(
              onTap: () {
                ref.read(skillLevelProvider.notifier).state = null;
                showCertificateForm(context);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                  height: 1,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.only(top: 20),
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      showAddContent(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Add More Content",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          ClipOval(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: Icon(
                                Icons.add,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Column skillList() {
  //   return Column(
  //     children: List.generate(
  //         ref.watch(userSkillListProvider).length,
  //         (index) => Padding(
  //               padding: const EdgeInsets.only(left: 8),
  //               child: Card(
  //                 child: ListTile(
  //                   onTap: () {
  //                     showModalBottomSheet(
  //                         backgroundColor: Colors.transparent,
  //                         isScrollControlled: true,
  //                         context: context,
  //                         builder: (cxt) {
  //                           return const AddSkillForm();
  //                         });
  //                   },
  //                   title: Text(ref.watch(userSkillListProvider)[index].skill),
  //                   subtitle: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(ref.watch(userSkillListProvider)[index].level),
  //                       Text(ref.watch(userSkillListProvider)[index].info)
  //                     ],
  //                   ),
  //                   trailing: IconButton(
  //                       onPressed: () {
  //                         setState(() {
  //                           ref.watch(userSkillListProvider).removeAt(index);
  //                         });
  //                       },
  //                       icon: const Icon(Icons.delete)),
  //                 ),
  //               ),
  //             )),
  //   );
  // }

  // Widget experienceList() {
  //   return Column(
  //     children: List.generate(
  //         ref.watch(userExperienceListProvider).length,
  //         (index) => Padding(
  //               padding: const EdgeInsets.only(left: 8),
  //               child: Card(
  //                 child: ListTile(
  //                   onTap: () {
  //                     showModalBottomSheet(
  //                         backgroundColor: Colors.transparent,
  //                         isScrollControlled: true,
  //                         context: context,
  //                         builder: (cxt) {
  //                           return const AddProfessionalExperienceForm(null);
  //                         });
  //                   },
  //                   title: Text(
  //                       ref.watch(userExperienceListProvider)[index].jobTitle),
  //                   subtitle: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(ref
  //                           .watch(userExperienceListProvider)[index]
  //                           .description),
  //                       Text(ref
  //                           .watch(userExperienceListProvider)[index]
  //                           .employer)
  //                     ],
  //                   ),
  //                   trailing: IconButton(
  //                     onPressed: () {
  //                       setState(() {
  //                         ref.watch(userSkillListProvider).removeAt(index);
  //                       });
  //                     },
  //                     icon: const Icon(Icons.delete),
  //                   ),
  //                 ),
  //               ),
  //             )),
  //   );
  // }

  showAddContent(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const MoreContentBottomSheet();
        });
  }

  showAddEducationForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddEducationForm(null, null);
        });
  }

  showAddExperienceForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddProfessionalExperienceForm(null, null);
        });
  }

  showAddSkillForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddSkillForm(null, null);
        });
  }

  showLanguageForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddLanguageForm(null, null);
        });
  }

  showCertificateForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddCertificateForm(null, null);
        });
  }

  showProfileForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddProfileForm(null, null);
        });
  }
}
