import 'package:flutter/material.dart';

import '../../feat_data_input.dart';

class EditFormWidget extends StatelessWidget {
  const EditFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const PersonalDetailCard(),
            AddDataCard(
              text: "Education",
              onTap: () => showAddEducationForm(context),
            ),
            AddDataCard(
              text: "Professional Experience",
              onTap: () => showAddExperienceForm(context),
            ),
            AddDataCard(
              text: "Skill",
              onTap: () => showAddSkillForm(context),
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
          return const AddEducationForm();
        });
  }

  showAddExperienceForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddProfessionalExperienceForm();
        });
  }

  showAddSkillForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddSkillForm();
        });
  }
}
