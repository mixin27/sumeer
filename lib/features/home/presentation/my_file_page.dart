import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/features/templates/shared/provider.dart';
import 'package:sumeer/utils/utils.dart';
import 'package:sumeer/widgets/widgets.dart';

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
            return ListView.builder(
                itemCount: cvModel!.length,
                itemBuilder: (cxt, idx) {
                  return Card(
                    color: Theme.of(context).colorScheme.background,
                    elevation: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.background,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: cvModel[idx].profile!.image ?? '',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey.withOpacity(0.3),
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(cvModel[idx].profile!.name),
                              Text(
                                cvModel[idx].profile!.createdOn.toString(),
                              ),
                              Row(
                                children: [
                                  OutlinedButton.icon(
                                    icon: const Icon(Icons.edit),
                                    // style: outlineButtonStyle,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      backgroundColor: const Color.fromARGB(
                                          255, 237, 245, 252),
                                      minimumSize: const Size(88, 36),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),

                                    onPressed: () {},
                                    label: const Text('Edit'),
                                  ),
                                  horSpace(8),
                                  OutlinedButton.icon(
                                    icon: const Icon(Icons.edit),
                                    // style: outlineButtonStyle,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      backgroundColor: const Color.fromARGB(
                                          255, 237, 245, 252),
                                      minimumSize: const Size(88, 36),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),

                                    onPressed: () {},
                                    label: const Text('View'),
                                  ),
                                  horSpace(8),
                                  OutlinedButton.icon(
                                    icon: const Icon(Icons.delete),
                                    // style: outlineButtonStyle,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      backgroundColor: const Color.fromARGB(
                                          255, 237, 245, 252),
                                      minimumSize: const Size(88, 36),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                    ),

                                    onPressed: () {},
                                    label: const Text('Delete'),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
