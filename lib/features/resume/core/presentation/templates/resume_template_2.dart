import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/shared.dart';

Future<Uint8List> generateTemplate2(
  PdfPageFormat format,
  GenerateDocParams params,
  ResumeData resumeData,
) async {
  final doc = pw.Document(
    title: params.title,
    author: params.author,
    creator: params.creator,
    subject: params.subject,
    keywords: params.keywords,
    producer: params.producer,
  );

  final pageTheme = await _pageTheme(format);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Partitions(
            children: [
              pw.Partition(
                child: pw.Column(
                  children: [
                    pw.Text('Hello World'),
                  ],
                ),
              ),
            ],
          ),
        ];
      },
    ),
  );

  return doc.save();
}

Future<pw.PageTheme> _pageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString(AssetPaths.resumeSvg);

  format = format.applyMargin(
    left: 2.0 * PdfPageFormat.cm,
    top: 4.0 * PdfPageFormat.cm,
    right: 2.0 * PdfPageFormat.cm,
    bottom: 2.0 * PdfPageFormat.cm,
  );

  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.poppinsRegular(),
      bold: await PdfGoogleFonts.poppinsBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                angle: pi,
                child: pw.SvgImage(svg: bgShape),
              ),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      );
    },
  );
}
