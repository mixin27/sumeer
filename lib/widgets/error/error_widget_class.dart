import 'package:flutter/material.dart';
import 'package:sumeer/widgets/widgets.dart';

class ErrorWidgetClass extends StatelessWidget {
  const ErrorWidgetClass({super.key, required this.errorDetails});

  final FlutterErrorDetails errorDetails;

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      errorMessage: errorDetails.exceptionAsString(),
    );
  }
}
