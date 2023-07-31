import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/features/templates/shared/provider.dart';
import 'package:sumeer/utils/utils.dart';

import '../../auth/feat_auth.dart';
import '../../templates/domain/cv_model.dart';

@RoutePage()
class MyFilePage extends HookConsumerWidget {
  const MyFilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<CVModel> cvModel = [];
    var uid = ref.watch(authRepositoryProvider).currentUser?.uid.toString();
    dLog('userId build', uid);
    Future<List<CVModel>> getData() async {
      dLog('userId', uid);
      await ref
          .read(cloudFirestoreProvider)
          .collection("summer")
          .doc(uid)
          .collection("user")
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.docs.isNotEmpty) {
          vLog('IsnotEmpty', documentSnapshot.docs.isNotEmpty);
          var list = documentSnapshot.docs
              .map(
                (e) => CVModel.fromJson(e.data()),
              )
              .toList();
          cvModel = list;
          wLog('cv list', cvModel);
          return list;
        }
      });
      return cvModel;
    }

    useEffect(() {
      Future.microtask(() => getData());

      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Files'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var cvModel = snapshot.data;
            return ListView.builder(itemBuilder: (cxt, idx) {
              return Text(cvModel!.length.toString());
            });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
