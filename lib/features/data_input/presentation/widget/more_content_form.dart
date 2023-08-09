import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/features/data_input/presentation/widget/add_language_form.dart';
import 'package:sumeer/features/features.dart';

class MoreContentBottomSheet extends StatelessWidget {
  const MoreContentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
                color: Theme.of(context).colorScheme.background),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add Contents",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ContentItemCard(
                      icon: const Icon(
                        Icons.badge,
                        size: 30,
                      ),
                      title: "Profile",
                      decription:
                          "Make a great first impression by presenting yourself in a few sentences.",
                      onTap: () {
                        context.router
                            .pop()
                            .then((value) => showAddProfileForm(context));
                      },
                    ),
                    ContentItemCard(
                      icon: const Icon(
                        Icons.school,
                        size: 30,
                      ),
                      title: "Education",
                      decription:
                          "Show off your primary education, college degrees & exchange semesters.",
                      onTap: () {
                        context.router
                            .pop()
                            .then((value) => showAddEducationForm(context));
                      },
                    ),
                    ContentItemCard(
                      icon: const Icon(
                        Icons.business_center,
                        size: 30,
                      ),
                      title: "Professional Experience",
                      decription:
                          "A place to highlight your professional experience - including internships.",
                      onTap: () {
                        context.router
                            .pop()
                            .then((value) => showAddExperienceForm(context));
                      },
                    ),
                    ContentItemCard(
                      icon: const Icon(
                        Icons.psychology_alt,
                        size: 30,
                      ),
                      title: "Skill",
                      decription:
                          "List your technical, managerial or soft skills in this section.",
                      onTap: () {
                        context.router
                            .pop()
                            .then((value) => showAddSkillForm(context));
                      },
                    ),
                    ContentItemCard(
                      icon: const Icon(
                        Icons.language,
                        size: 30,
                      ),
                      title: "Language",
                      decription:
                          "You speak more than one language? Make sure to list them here.",
                      onTap: () {
                        context.router
                            .pop()
                            .then((value) => showAddLanguageForm(context));
                      },
                    ),
                    const ContentItemCard(
                        icon: Icon(
                          Icons.workspace_premium,
                          size: 30,
                        ),
                        title: "Certificate",
                        decription:
                            "Drivers licenses and other industry-specific certificates you have belong here."),
                    const ContentItemCard(
                        icon: Icon(
                          Icons.interests,
                          size: 30,
                        ),
                        title: "Interest",
                        decription:
                            "Dou you have interests that align with your career aspiration?"),
                    const ContentItemCard(
                        icon: Icon(
                          Icons.folder,
                          size: 30,
                        ),
                        title: "Project",
                        decription:
                            "Worked on a particular challenging project in the past?Mention it here."),
                    const ContentItemCard(
                        icon: Icon(
                          Icons.bookmark,
                          size: 30,
                        ),
                        title: "Coruse",
                        decription:
                            "Did you complete MOOCs or an evening course? Show them off in this section."),
                    const ContentItemCard(
                        icon: Icon(
                          Icons.emoji_events,
                          size: 30,
                        ),
                        title: "Award",
                        decription:
                            "Awards like student competitions or industry accolades belong here."),
                    const ContentItemCard(
                        icon: Icon(
                          Icons.corporate_fare,
                          size: 30,
                        ),
                        title: "Organisation",
                        decription:
                            "If you volunteer or participate in a good cause, why not state it?"),
                    const ContentItemCard(
                        icon: Icon(
                          Icons.publish,
                          size: 30,
                        ),
                        title: "Publication",
                        decription:
                            "Academic publications or book releases have a dedicated place here."),
                    const ContentItemCard(
                        icon: Icon(
                          Icons.article_sharp,
                          size: 30,
                        ),
                        title: "Reference",
                        decription:
                            "If you have former colleagues or bosses that vouch for you, list them."),
                  ],
                ),
              )
            ]),
          );
        });
  }

  showAddProfileForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddProfileForm(null, null);
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

  showAddLanguageForm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (cxt) {
          return const AddLanguageForm(null, null);
        });
  }
}
