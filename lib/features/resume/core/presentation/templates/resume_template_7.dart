import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

Future<Uint8List> generateTemplate7(
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

  final sourceCodeFontRegular = await PdfGoogleFonts.sourceCodeProRegular();

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Partitions(
                children: [
                  pw.Partition(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // image
                        pw.ClipOval(
                          child: pw.Container(
                            height: 70,
                            width: 70,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.blue300,
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Mobile Developer",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        pw.Text(
                          "kyawzayartun.sbs@gmail.com",
                          // style: pw.TextStyle(
                          //   fontWeight: pw.FontWeight.bold,
                          //   fontSize: 16,
                          // ),
                        ),
                        pw.Text(
                          "Yangon, Myanmar",
                          // style: pw.TextStyle(
                          //   fontWeight: pw.FontWeight.bold,
                          //   fontSize: 16,
                          // ),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Text(
                          "Date of Birth",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        pw.Text(
                          "27/07/1998",
                          style: pw.TextStyle(
                            font: sourceCodeFontRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Partition(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Kyaw",
                          style: pw.TextStyle(
                            fontSize: 40,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          "Zayar Tun",
                          style: pw.TextStyle(
                            fontSize: 40,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.grey300,
                            borderRadius: pw.BorderRadius.all(
                              pw.Radius.circular(20),
                            ),
                          ),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                            children: [
                              pw.Text(
                                "Profile",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                // style: pw.TextStyle(
                                //   fontSize: 14,
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 10),
                child: pw.Divider(color: PdfColors.grey200),
              ),
              pw.Partitions(
                children: [
                  pw.Partition(
                    flex: 2,
                    child: pw.Text('halo'),
                  ),
                  pw.Partition(
                    child: pw.Text('halo'),
                  ),
                ],
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
  // format = format.applyMargin(
  // left: PdfPageFormat.cm,
  //   top: PdfPageFormat.cm,
  //   right: PdfPageFormat.cm,
  //   bottom: PdfPageFormat.cm,
  // );

  return pw.PageTheme(
    pageFormat: format,
    margin: const pw.EdgeInsets.all(20),
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.sourceSansProRegular(),
      bold: await PdfGoogleFonts.sourceSansProBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Container(
          color: PdfColors.white,
        ),
        // child: pw.Row(
        //   children: [
        //     pw.Expanded(
        //       flex: 4,
        //       child: pw.Container(
        //         color: PdfColor.fromHex('DBDBF9'),
        //       ),
        //     ),
        //     pw.Expanded(
        //       flex: 5,
        //       child: pw.Container(
        //         color: PdfColor.fromHex('54448D'),
        //       ),
        //     ),
        //   ],
        // ),
      );
    },
  );
}
