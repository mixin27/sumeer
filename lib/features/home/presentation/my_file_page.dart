import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/features.dart';
import '../../auth/feat_auth.dart';

@RoutePage()
class MyFilePage extends HookConsumerWidget {
  const MyFilePage({super.key});
  // List<ResumeData> resumeModeList = [];

  // Future<List<ResumeData>> getData() async {
  //  final currentUser = ref.watch(authRepositoryProvider).currentUser;

  // var uid = ref.watch(authRepositoryProvider).currentUser?.uid.toString();

  // TODO: refactor
  // await ref
  //     .read(cloudFirestoreProvider)
  //     .collection("sumeer")
  //     .doc(uid)
  //     .collection("user")
  //     .get()
  //     .then(
  //   (documentSnapshot) {
  //     if (documentSnapshot.docs.isNotEmpty) {
  //       var list = documentSnapshot.docs
  //           .map(
  //             (e) => ResumeData.fromJson(e.data()),
  //           )
  //           .toList();
  //       resumeModeList = list;
  //       return list;
  //     }
  //   },
  // );

  //   return resumeModeList;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() => getData());
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = useState<List<ResumeData>>([]);

    Future<void> getData() async {
      final result = await ref.read(resumeRepositoryProvider).getLocalData();
      data.value = result;
    }

    useEffect(() {
      getData();
      return null;
    }, []);

    final currentUser = ref.watch(authRepositoryProvider).currentUser;
    final resumeDataList =
        ref.watch(resumeDataListProvider(userId: currentUser?.uid ?? ""));

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Files'),
        ),
        body: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final resumeData = data.value[index];

            return ListTile(
              title: Text(
                resumeData.personalDetail?.fullName ?? "Unknown user",
              ),
              subtitle: Text(
                resumeData.personalDetail?.jobTitle ?? "Unknown job title",
              ),
              // trailing: IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.delete_outline,
              //     color: Theme.of(context).colorScheme.error,
              //   ),
              // ),
            );
          },
          itemCount: data.value.length,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Files'),
      ),
      body: SizedBox(
        child: resumeDataList.when(
          data: (data) => ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final resumeData = data[index];

              return ListTile(
                title: Text(
                  resumeData.personalDetail?.fullName ?? "Unknown user",
                ),
                subtitle: Text(
                  resumeData.personalDetail?.jobTitle ?? "Unknown job title",
                ),
                trailing: IconButton(
                  onPressed: () {
                    if (resumeData.resumeId == null) return;

                    ref.read(resumeRemoteServiceProvider).removeResumeData(
                          userId: currentUser.uid,
                          resumeDocId: resumeData.resumeId!,
                        );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            },
            itemCount: data.length,
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('My Files'),
    //   ),
    //   body: FutureBuilder(
    //     future: getData(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         var resumeModel = snapshot.data;
    //         if (resumeModel!.isEmpty || resumeModel.isEmpty) {
    //           return Center(
    //               child: Text(
    //             'No Data!',
    //             style: Theme.of(context).textTheme.titleLarge,
    //           ));
    //         } else {
    //           return ListView.builder(
    //               itemCount: resumeModel.length,
    //               itemBuilder: (cxt, idx) {
    //                 return Card(
    //                   color: Theme.of(context).colorScheme.background,
    //                   elevation: 0.5,
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: [
    //                         Container(
    //                           height: 50,
    //                           width: 50,
    //                           decoration: BoxDecoration(
    //                             border: Border.all(
    //                               color:
    //                                   Theme.of(context).colorScheme.background,
    //                             ),
    //                             borderRadius: BorderRadius.circular(8.0),
    //                           ),
    //                           child: ClipRRect(
    //                             borderRadius: BorderRadius.circular(8.0),
    //                             child: CachedNetworkImage(
    //                               fit: BoxFit.fill,
    //                               imageUrl: resumeModel[idx].profileImage ?? '',
    //                               progressIndicatorBuilder:
    //                                   (context, url, downloadProgress) =>
    //                                       CircularProgressIndicator(
    //                                 value: downloadProgress.progress,
    //                               ),
    //                               errorWidget: (context, url, error) => Icon(
    //                                 Icons.camera_alt,
    //                                 color: Colors.grey.withOpacity(0.3),
    //                                 size: 50,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         Column(
    //                           children: [
    //                             Text(
    //                                 resumeModel[idx].personalDetail?.fullName ??
    //                                     ''),
    //                             Text(
    //                               resumeModel[idx]
    //                                       .personalDetail
    //                                       ?.email
    //                                       .toString() ??
    //                                   '',
    //                             ),
    //                             Row(
    //                               children: [
    //                                 OutlinedButton.icon(
    //                                   icon: const Icon(Icons.edit),
    //                                   // style: outlineButtonStyle,
    //                                   style: OutlinedButton.styleFrom(
    //                                     foregroundColor: Theme.of(context)
    //                                         .colorScheme
    //                                         .primary,
    //                                     backgroundColor: const Color.fromARGB(
    //                                         255, 237, 245, 252),
    //                                     minimumSize: const Size(88, 36),
    //                                     padding: const EdgeInsets.symmetric(
    //                                         horizontal: 16),
    //                                     shape: const RoundedRectangleBorder(
    //                                       borderRadius: BorderRadius.all(
    //                                         Radius.circular(8),
    //                                       ),
    //                                     ),
    //                                   ),

    //                                   onPressed: () {
    //                                     ref
    //                                         .read(resumeDataProvider.notifier)
    //                                         .state = resumeModel[idx];
    //                                     ref
    //                                             .read(resumeModelIdProvider
    //                                                 .notifier)
    //                                             .state =
    //                                         resumeModel[idx].resumeId ?? '';
    //                                     AutoRouter.of(context)
    //                                         .push(const DetailRoute());
    //                                   },
    //                                   label: const Text('Edit'),
    //                                 ),
    //                                 horSpace(8),
    //                                 OutlinedButton.icon(
    //                                   icon: const Icon(Icons.edit),
    //                                   // style: outlineButtonStyle,
    //                                   style: OutlinedButton.styleFrom(
    //                                     foregroundColor: Theme.of(context)
    //                                         .colorScheme
    //                                         .primary,
    //                                     backgroundColor: const Color.fromARGB(
    //                                         255, 237, 245, 252),
    //                                     minimumSize: const Size(88, 36),
    //                                     padding: const EdgeInsets.symmetric(
    //                                         horizontal: 16),
    //                                     shape: const RoundedRectangleBorder(
    //                                       borderRadius: BorderRadius.all(
    //                                         Radius.circular(8),
    //                                       ),
    //                                     ),
    //                                   ),

    //                                   onPressed: () {
    //                                     ref
    //                                         .read(resumeDataProvider.notifier)
    //                                         .update(
    //                                             (state) => resumeModel[idx]);
    //                                     context.router.push(
    //                                       ResumePreviewRoute(
    //                                         resume: getResumeTemplateById(
    //                                           resumeModel[idx].templateId,
    //                                         ),
    //                                         resumeData: resumeModel[idx],
    //                                       ),
    //                                     );
    //                                   },
    //                                   label: const Text('View'),
    //                                 ),
    //                                 horSpace(8),
    //                                 OutlinedButton.icon(
    //                                   icon: const Icon(Icons.delete),
    //                                   // style: outlineButtonStyle,
    //                                   style: OutlinedButton.styleFrom(
    //                                     foregroundColor: Theme.of(context)
    //                                         .colorScheme
    //                                         .primary,
    //                                     backgroundColor: const Color.fromARGB(
    //                                         255, 237, 245, 252),
    //                                     minimumSize: const Size(88, 36),
    //                                     padding: const EdgeInsets.symmetric(
    //                                         horizontal: 16),
    //                                     shape: const RoundedRectangleBorder(
    //                                       borderRadius: BorderRadius.all(
    //                                         Radius.circular(8),
    //                                       ),
    //                                     ),
    //                                   ),

    //                                   onPressed: () async {
    //                                     // to delete
    //                                     var uid = ref
    //                                         .watch(authRepositoryProvider)
    //                                         .currentUser
    //                                         ?.uid
    //                                         .toString();
    //                                     await ref
    //                                         .read(cloudFirestoreProvider)
    //                                         .collection("sumeer")
    //                                         .doc(uid)
    //                                         .collection("user")
    //                                         .doc(resumeModel[idx].resumeId)
    //                                         .delete();
    //                                     setState(() {
    //                                       getData();
    //                                     });
    //                                   },
    //                                   label: const Text('Delete'),
    //                                 ),
    //                               ],
    //                             )
    //                           ],
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               });
    //         }
    //       } else {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
