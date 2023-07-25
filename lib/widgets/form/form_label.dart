import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
