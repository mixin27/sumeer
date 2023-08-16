import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sumeer/features/starter/feat_starter.dart';
import 'package:sumeer/shared/shared.dart';

@RoutePage()
class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: ElevatedButton(
            onPressed: () async {
              context.router.push(const StarterPersonalDetailRoute());
            },
            child: const Text("Get Started"),
          ),
        ),
      ),
      // body: Consumer(
      //   builder: (context, ref, child) {
      //     final currentUser = ref.watch(authRepositoryProvider).currentUser;

      //     final resumeDataList =
      //         ref.watch(resumeDataListProvider(userId: currentUser?.uid ?? ""));

      //     return SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.stretch,
      //         children: [
      //           const ExpansionTile(
      //             title: Text('Personal Information'),
      //             children: [
      //               Padding(
      //                 padding:
      //                     EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //                 child: PersonalInformationForm(),
      //               ),
      //             ],
      //           ),
      //           const ExpansionTile(
      //             title: Text('Education'),
      //             children: [
      //               Padding(
      //                 padding:
      //                     EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //                 child: EducationForm(),
      //               ),
      //             ],
      //           ),
      //           const ExpansionTile(
      //             title: Text('Experience'),
      //             children: [
      //               Padding(
      //                 padding:
      //                     EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //                 child: ExperienceForm(),
      //               ),
      //             ],
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(
      //               horizontal: 16,
      //               vertical: 8,
      //             ),
      //             child: ElevatedButton(
      //               onPressed: () async {
      //                 context.router.push(const StarterPersonalDetailRoute());
      //                 // if (currentUser == null) return;

      //                 // final resumeData = await getDummyResumeData();
      //                 // final personalDetail = ref.read(personalDetailProvider);
      //                 // tLog('PersonalDetail: $personalDetail');

      //                 // ref
      //                 //     .read(upsertResumeDataNotifierProvider.notifier)
      //                 //     .upsertResumeData(
      //                 //       userId: currentUser.uid,
      //                 //       resumeData: resumeData,
      //                 //     );
      //               },
      //               child: const Text("Get Started"),
      //             ),
      //           ),

      //           // Data
      //           SizedBox(
      //             child: resumeDataList.when(
      //               data: (data) => ListView.builder(
      //                 primary: false,
      //                 shrinkWrap: true,
      //                 itemBuilder: (context, index) {
      //                   final resumeData = data[index];

      //                   return ListTile(
      //                     title: Text(
      //                       resumeData.personalDetail?.fullName ??
      //                           "Unknown user",
      //                     ),
      //                     subtitle: Text(
      //                       resumeData.personalDetail?.jobTitle ??
      //                           "Unknown job title",
      //                     ),
      //                     trailing: IconButton(
      //                       onPressed: () {
      //                         if (currentUser == null) return;
      //                         if (resumeData.resumeId == null) return;

      //                         ref
      //                             .read(resumeRemoteServiceProvider)
      //                             .removeResumeData(
      //                               userId: currentUser.uid,
      //                               resumeDocId: resumeData.resumeId!,
      //                             );
      //                       },
      //                       icon: Icon(
      //                         Icons.delete_outline,
      //                         color: Theme.of(context).colorScheme.error,
      //                       ),
      //                     ),
      //                   );
      //                 },
      //                 itemCount: data.length,
      //               ),
      //               error: (error, stackTrace) => Center(
      //                 child: Text(error.toString()),
      //               ),
      //               loading: () =>
      //                   const Center(child: CircularProgressIndicator()),
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }

  List<Step> getSteps(int currentStep) {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Personal Detail"),
        content: const PersonalInformationForm(),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Education"),
        content: const EducationForm(),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Experience"),
        content: const ExperienceForm(),
      ),
    ];
  }
}
