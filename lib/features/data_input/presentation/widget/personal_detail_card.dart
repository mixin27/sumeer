import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/feat_data_input.dart';
import 'package:sumeer/features/templates/domain/cv_model.dart';
import 'package:sumeer/shared/config/routes/app_router.gr.dart';

class PersonalDetailCard extends ConsumerWidget {
  const PersonalDetailCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
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
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: profile?.image ?? '',
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // "Your Name Your Name Your Name Your Name Your Name",
                            profile?.name ?? "Your Name",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Visibility(
                            visible: profile != null,
                            child: Text(
                              profile?.jobTitle ?? "Mobile Developer",
                              // "Mobile Developer Mobile Developer",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          // const SizedBox(height: 2),
                          Visibility(
                            visible: profile != null,
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
                                  profile?.email ?? "testing2123@gmail.com",
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
                                profile?.phone ?? "09-xxx-xxx-xxx",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: profile != null,
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
                                Text(
                                  profile?.address ?? "",
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                      profile?.dOB ?? '',
                      profile?.dOB.toString() != "",
                    ),
                    profileItem(
                      context,
                      Icons.man,
                      profile?.gender ?? '',
                      profile?.gender.toString() != "",
                    ),
                    profileItem(
                      context,
                      Icons.language,
                      profile?.nationality ?? '',
                      profile?.nationality.toString() != "",
                    ),
                    profileItem(
                      context,
                      Icons.bed,
                      profile?.maritalStatus ?? '',
                      profile?.maritalStatus.toString() != "",
                    ),
                    profileItem(
                      context,
                      Icons.car_crash,
                      profile?.drivingLicense ?? '',
                      profile?.drivingLicense.toString() != "",
                    ),
                    profileItem(
                      context,
                      Icons.badge,
                      profile?.passport ?? '',
                      profile?.passport.toString() != "",
                    ),
                  ],
                ),
                profileItemWithImage(
                  context,
                  "assets/images/resume/icons8-www-50.png",
                  profile?.website ?? '',
                  profile?.website.toString() != "",
                ),
                profileItem(
                  context,
                  Icons.badge,
                  profile?.linkIn ?? '',
                  profile?.linkIn.toString() != "",
                ),
                profileItem(
                  context,
                  Icons.badge,
                  profile?.gitHub ?? '',
                  profile?.gitHub.toString() != "",
                ),
                profileItem(
                  context,
                  Icons.abc,
                  profile?.skype ?? '',
                  profile?.skype.toString() != "",
                ),
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
