import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../auth/feat_auth.dart';
import '../../../templates/domain/cv_model.dart';
import '../../../templates/shared/provider.dart';

class SaveBottomSheetWidget extends StatelessWidget {
  const SaveBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => context.router.pop(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Cancel",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Consumer(builder: ((context, ref, child) {
                return InkWell(
                  onTap: () async {
                    log(ref
                        .watch(authRepositoryProvider)
                        .currentUser
                        .toString());
                    UserExperience experience = const UserExperience(
                        "position", "company", "year", "jobDescription");
                    UserEducation education =
                        const UserEducation("degree", "year");
                    UserSkill skill = const UserSkill("title", "level");
                    UserProfile profile = const UserProfile(
                        "name", "phone", "email", "address", "position");
                    CVModel cvModel = CVModel(profile, [experience, experience],
                        [skill, skill], [education, education]);
                    var uid = ref
                        .watch(authRepositoryProvider)
                        .currentUser
                        ?.uid
                        .toString();
                    await FirebaseFirestore.instance
                        .collection('summer')
                        .doc(uid)
                        .set({"test": 123});
                    log(cvModel.toJson().toString());
                    await ref
                        .read(cloudFirestoreProvider)
                        .collection("summer")
                        .doc(uid)
                        .collection("user")
                        .doc(const Uuid().v4())
                        .set(cvModel.toJson());
                  },
                  child: Text(
                    "Save",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                );
              }))),
        ),
      ],
    );
  }
}
