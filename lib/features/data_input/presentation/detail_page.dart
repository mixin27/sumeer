import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/feat_data_input.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
import 'package:sumeer/widgets/button1.dart';
import '../../auth/feat_auth.dart';
import '../../features.dart';
import '../../templates/shared/provider.dart';

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
        leading: const AutoLeadingButton(),
        actions: [
          Button1(
            text: "Save",
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
              context.router.push(const TemplateListingRoute());
            },
          ),
        ],
      ),
      body: WillPopScope(
          onWillPop: () async {
            context.router.replaceAll([const HomeRoute()]);
            return true;
          },
          child: const EditFormWidget()),
    );
  }
}
