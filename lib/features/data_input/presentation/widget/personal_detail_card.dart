import 'package:auto_route/auto_route.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:sumeer/shared/config/routes/app_router.gr.dart';

class PersonalDetailCard extends StatelessWidget {
  const PersonalDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.grey.shade50,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Your Name",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Mobile Developer",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "testing2123@gmail.com",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
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
                      "09-xxxx-xxx-xxx",
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
