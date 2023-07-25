import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: ListView(
          children: [
            Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(height: 18),
            const Text(
              "Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            const Row(
              children: [
                Icon(
                  Icons.person_2_outlined,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 6),
                Expanded(
                    child: Text(
                  "My Account",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
                Text("theintmyatnoe@gmail.com"),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(
                  Icons.language,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 6),
                Expanded(
                    child: Text(
                  "Language",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
                Text("English"),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.dark_mode,
                  color: Colors.blueAccent,
                ),
                const SizedBox(width: 6),
                const Expanded(
                    child: Text(
                  "My Account",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
                Switch(value: false, onChanged: (val) {}),
              ],
            ),
            const SizedBox(height: 8),
            Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(height: 22),
            const Text(
              "Term and Privacy",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 6),
                Expanded(
                    child: Text(
                  "Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(height: 22),
            const Text(
              "Contact",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 6),
                Expanded(
                    child: Text(
                  "Rate Our App",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 22),
            const Row(
              children: [
                Icon(
                  Icons.language_outlined,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 6),
                Expanded(
                    child: Text(
                  "Our Website",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(height: 20),
            const Text(
              "App Version",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            const Row(
              children: [
                Icon(
                  Icons.pages_outlined,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 6),
                Expanded(
                    child: Text(
                  "Version",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
                Text(
                  "1.0",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
