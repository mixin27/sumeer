import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:sumeer/features/features.dart';

class FileListItem extends StatelessWidget {
  const FileListItem({
    super.key,
    required this.resumeData,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final ResumeData resumeData;
  final Function(ResumeData)? onTap;
  final Function(ResumeData)? onEdit;
  final Function(ResumeData)? onDelete;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.shade100,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTap?.call(resumeData);
          },
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: resumeData.profileImage ?? '',
                        imageBuilder: (context, imageProvider) => Container(
                          height: 65,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey.withOpacity(0.3),
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: resumeData.personalDetail?.fullName,
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                    text:
                                        '(${resumeData.personalDetail?.jobTitle})',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              resumeData.personalDetail?.email ?? '',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () async {},
                    //   style: IconButton.styleFrom(
                    //     foregroundColor: Theme.of(context).colorScheme.error,
                    //   ),
                    //   icon: const Icon(Icons.delete_forever_outlined),
                    // ),
                  ],
                ),
                if (onDelete != null || onEdit != null) ...[
                  Divider(color: Colors.grey.shade300),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (onDelete != null)
                        TextButton(
                          onPressed: () {
                            onDelete?.call(resumeData);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                          ),
                          child: const Text('Delete'),
                        ),
                      if (onEdit != null)
                        TextButton(
                          onPressed: () {
                            onEdit?.call(resumeData);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blueAccent,
                          ),
                          child: const Text('Edit'),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
