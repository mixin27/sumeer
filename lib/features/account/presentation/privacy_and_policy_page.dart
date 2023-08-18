import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:sumeer/shared/shared.dart';

@RoutePage()
class PrivacyAndPolicyPage extends StatelessWidget {
  const PrivacyAndPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Policy'),
      ),
      body: SingleChildScrollView(
        child: Html(data: AppStrings.privacyAndPolicyHtml),
      ),
    );
  }
}
