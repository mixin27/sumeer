import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:sumeer/features/resume/feat_resume.dart';

class SectionDesign1 extends pw.StatelessWidget {
  SectionDesign1({
    required this.title,
  });

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}

class SectionDesign4 extends pw.StatelessWidget {
  SectionDesign4({
    required this.title,
  });

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.center,
      width: double.infinity,
      height: 30,
      decoration: const pw.BoxDecoration(
        color: PdfColors.grey300,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 2, top: 10),
      // padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(title,
          textScaleFactor: 1.5,
          style: const pw.TextStyle(
            decoration: pw.TextDecoration.underline,
          )),
    );
  }
}

class SectionDesign5 extends pw.StatelessWidget {
  SectionDesign5({
    required this.title,
    required this.lineColor,
  });

  final String title;
  final PdfColor lineColor;
  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          // textScaleFactor: 1.5,
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold
              // decoration: pw.TextDecoration.underline,
              ),
        ),
        pw.Divider(
            height: 2,
            thickness: 2,
            color: lineColor,
            borderStyle: const pw.BorderStyle(pattern: [5, 3])),
      ],
    );
  }
}

class SectionDesign11 extends pw.StatelessWidget {
  SectionDesign11({
    required this.title,
    required this.lineColor,
  });

  final String title;
  final PdfColor lineColor;
  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            // decoration: pw.TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
