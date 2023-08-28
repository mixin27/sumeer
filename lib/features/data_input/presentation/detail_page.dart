import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
import 'package:sumeer/widgets/button1.dart';
import '../../features.dart';

@RoutePage()
class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  // String invId = '';
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     Future.microtask(() {
  //       invId = const Uuid().v4();
  //       ref.read(resumeModelIdProvider.notifier).state =
  //           ref.watch(resumeModelIdProvider).isEmptyOrNull
  //               ? invId
  //               : ref.watch(resumeModelIdProvider);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume"),
        // leading: const AutoLeadingButton(),
        leading: IconButton(
            onPressed: () {
              context.router.pushAll([
                const HomeRoute(),
              ]);
            },
            icon: const Icon(Icons.arrow_back_ios)),

        actions: [
          Button1(
            text: "View",
            onPressed: () async {
              dLog(ref.watch(resumeModelIdProvider));
              // var uid =
              //     ref.watch(authRepositoryProvider).currentUser?.uid.toString();
              // await ref
              //     .read(cloudFirestoreProvider)
              //     .collection("sumeer")
              //     .doc(uid)
              //     .collection("user")
              //     .doc(ref.watch(resumeModelIdProvider))
              //     .set(
              //       ref.watch(resumeDataProvider)?.toJson() ?? {},
              //     );

              context.router.push(
                ResumePreviewRoute(
                  resume: getResumeTemplateById(
                      ref.watch(resumeDataProvider)?.templateId),
                  resumeData: ref.watch(resumeDataProvider),
                ),
              );
              // if (ref.watch(resumeDataProvider)?.templateId != null) {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (ctx) => ResumePreviewPage(
              //         resume: getResumeTemplateById(
              //             ref.watch(resumeDataProvider)?.templateId),
              //         resumeData: ref.watch(resumeDataProvider),
              //       ),
              //     ),
              //   );
              // } else {
              //   context.router.push(const TemplatesRoute());
              // }
            },
          ),
        ],
      ),
      body: const EditFormWidget(),
    );
  }
}
