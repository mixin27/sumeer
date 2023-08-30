import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/feat_data_input.dart';
import 'package:sumeer/shared/config/routes/app_router.gr.dart';
import 'package:sumeer/utils/extensions/dart_extensions.dart';

class PersonalDetailCard extends ConsumerWidget {
  const PersonalDetailCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumeData = ref.watch(resumeDataProvider);
    final imageData = ref.watch(imageDataProvider);

    return Card(
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () {
                context.router.push(const PersonalDetailRoute());
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xFF407BFF),
                child: Icon(
                  Icons.drive_file_rename_outline,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircularProfileAvatar(
                        '',
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        radius: 50,
                        child: imageData.isEmptyOrNull
                            ? Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey.withOpacity(0.3),
                                  size: 50,
                                ),
                              )
                            : Image.memory(base64.decode(imageData!)),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: CircularProfileAvatar(
                    //     '',
                    //     backgroundColor: Colors.grey.withOpacity(0.3),
                    //     radius: 50,
                    //     child: CachedNetworkImage(
                    //       fit: BoxFit.fill,
                    //       imageUrl: resumeData?.profileImage ?? '',
                    //       // imageUrl: '',
                    //       progressIndicatorBuilder:
                    //           (context, url, downloadProgress) =>
                    //               CircularProgressIndicator(
                    //                   value: downloadProgress.progress),
                    // errorWidget: (context, url, error) => Icon(
                    //   Icons.camera_alt,
                    //   color: Colors.grey.withOpacity(0.3),
                    //   size: 50,
                    // ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // "Your Name Your Name Your Name Your Name Your Name",
                            resumeData?.personalDetail?.fullName ?? '',
                            // "Your Name",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Visibility(
                            visible: resumeData != null,
                            child: Text(
                              resumeData?.personalDetail?.jobTitle ??
                                  "Mobile Developer",
                              // "Mobile Developer Mobile Developer",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          // const SizedBox(height: 2),
                          Visibility(
                            visible: resumeData != null,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  resumeData?.personalDetail?.email ??
                                      "testing2123@gmail.com",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.grey,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                resumeData?.personalDetail?.phone ??
                                    "09-xxx-xxx-xxx",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: resumeData != null,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    resumeData?.personalDetail?.address ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  // alignment: WrapAlignment.spaceEvenly,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  // spacing: 4,
                  children: [
                    profileItem(
                      context,
                      Icons.cake,
                      resumeData?.personalDetail?.personalInfo?.dateOfBirth ??
                          '',
                      resumeData != null &&
                          resumeData.personalDetail?.personalInfo?.dateOfBirth
                                  .toString() !=
                              "",
                    ),
                    profileItem(
                      context,
                      Icons.man,
                      resumeData?.personalDetail?.personalInfo?.gender ?? '',
                      resumeData != null &&
                          resumeData.personalDetail?.personalInfo?.gender
                                  .toString() !=
                              "",
                    ),
                    profileItem(
                      context,
                      Icons.language,
                      resumeData?.personalDetail?.personalInfo?.nationality ??
                          '',
                      resumeData != null &&
                          resumeData.personalDetail?.personalInfo?.nationality
                                  .toString() !=
                              "",
                    ),
                    profileItem(
                      context,
                      Icons.bed,
                      resumeData?.personalDetail?.personalInfo?.martialStatus ??
                          '',
                      resumeData != null &&
                          resumeData.personalDetail?.personalInfo?.martialStatus
                                  .toString() !=
                              "",
                    ),
                    profileItem(
                      context,
                      Icons.car_crash,
                      resumeData
                              ?.personalDetail?.personalInfo?.drivingLicense ??
                          '',
                      resumeData != null &&
                          resumeData
                                  .personalDetail?.personalInfo?.drivingLicense
                                  .toString() !=
                              "",
                    ),
                    // profileItem(
                    //   context,
                    //   Icons.badge,
                    //   resumeData?.passport ?? '',
                    //   resumeData != null &&
                    //       resumeData.passport.toString() != "",
                    // ),
                  ],
                ),
                // profileItemWithImage(
                //   context,
                //   "assets/images/resume/icons8-www-50.png",
                //   resumeData?.website ?? '',
                //   resumeData != null && resumeData.website.toString() != "",
                // ),

                // profileItem(
                //   context,
                //   Icons.badge,
                //   resumeData?.personalDetail?.links. ?? '',
                //   resumeData != null && resumeData.linkIn.toString() != "",
                // ),
                // profileItem(
                //   context,
                //   Icons.badge,
                //   resumeData?.gitHub ?? '',
                //   resumeData != null && resumeData.gitHub.toString() != "",
                // ),
                // profileItem(
                //   context,
                //   Icons.abc,
                //   resumeData?.skype ?? '',
                //   resumeData != null && resumeData.skype.toString() != "",
                // ),
                // Visibility(
                //   visible: profile?.gender.toString() != "",
                //   child: Row(
                //     children: [
                //       const Icon(
                //         Icons.man,
                //         color: Colors.grey,
                //         size: 14,
                //       ),
                //       const SizedBox(width: 5),
                //       Text(
                //         profile?.gender ?? "",
                //         style: Theme.of(context).textTheme.bodyMedium,
                //       ),
                //     ],
                //   ),
                // ),
                // Row(
                //   children: [
                //     const Icon(
                //       Icons.phone,
                //       color: Colors.grey,
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     Text(
                //       profile?.phone ?? "09-xxx-xxx-xxx",
                //       style: Theme.of(context).textTheme.bodyMedium,
                //     ),
                //   ],
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Visibility profileItem(
      BuildContext context, IconData? icon, String text, bool visible) {
    return Visibility(
      // visible: profile?.dOB.toString() != "",
      visible: visible,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.6,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 14,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Visibility profileItemWithImage(
      BuildContext context, String image, String text, bool visible) {
    return Visibility(
      // visible: profile?.dOB.toString() != "",
      visible: visible,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.6,
        child: Row(
          children: [
            Image.asset(
              image,
              height: 16,
              width: 16,
            ),
            // Icon(
            //   icon,
            //   color: Colors.grey,
            //   size: 14,
            // ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
