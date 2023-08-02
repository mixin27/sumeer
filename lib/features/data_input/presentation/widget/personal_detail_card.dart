import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/feat_data_input.dart';
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
            right: 5,
            top: 5,
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  // "Your Name",
                  profile?.name ?? "Your Name",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Visibility(
                  visible: profile != null,
                  child: Text(
                    profile?.jobTitle ?? "Mobile Developer",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: profile != null,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
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
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      profile?.phone ?? "09-xxxx-xxx-xxx",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
