import 'package:flutter/material.dart';

/// Make modal bottom sheet or dialog dismissible when user tap outside
/// of the widget.
class ModalDismissible extends StatelessWidget {
  const ModalDismissible({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }
}
