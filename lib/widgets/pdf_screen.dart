import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key, this.pdfData});

  final Uint8List? pdfData;

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PDFView(
          pdfData: widget.pdfData,
          onViewCreated: (controller) {
            _controller.complete(controller);
          },
        ),
      ],
    );
  }
}
