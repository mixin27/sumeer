import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:sumeer/features/data_input/feat_data_input.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/widgets/button1.dart';
import 'package:uuid/uuid.dart';

import '../../auth/feat_auth.dart';
import '../../features.dart';
import '../../resume/core/presentation/templates/resume1.dart';
import '../../templates/shared/provider.dart';

@RoutePage()
class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  String invId = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      invId = const Uuid().v4();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume"),
        actions: [
          Button1(
            text: "Preview",
            onPressed: () async {
              print(ref.watch(cvMOdelProvider));
              var uid =
                  ref.watch(authRepositoryProvider).currentUser?.uid.toString();
              await ref
                  .read(cloudFirestoreProvider)
                  .collection("summer")
                  .doc(uid)
                  .collection("user")
                  .doc(invId)
                  .set(ref.watch(cvMOdelProvider)?.toJson() ?? {});
              // await ref
              //     .read(cloudFirestoreProvider)
              //     .collection("summer")
              //     .doc(uid)
              //     .collection("user")
              //     .get()
              //     .then((documentSnapshot) {
              //   if (documentSnapshot.docs.isNotEmpty) {
              //     // var docData = documentSnapshot.docs[0].data();
              //     // var chat = CVModel.fromJson(docData);
              //     var list = documentSnapshot.docs
              //         .map(
              //           (e) => CVModel.fromJson(e.data()),
              //         )
              //         .toList();
              //     log(list.toString());
              //     log(list.length.toString());
              //     // return chat;
              //   } else {
              //     return null;
              //   }
              // });
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (ctx) => const ResumePreviewPage(
              //         resume: ResumeTemplate(
              //       'Preview',
              //       'resume_template_tmn.dart',
              //       'assets/images/templates/resume_template_1.jpg',
              //       generateResume1,
              //     )),
              //   ),
              // );
            },
          ),
        ],
      ),
      body: const EditFormWidget(),
    );
  }
}
